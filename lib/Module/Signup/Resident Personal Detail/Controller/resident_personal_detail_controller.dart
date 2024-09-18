import 'dart:convert';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';
import '../../../Family Member/Add Family Member/Controller/add_family_member_controller.dart';
import '../../../Login/Model/User.dart' as userModel;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/Module/Signup/Resident%20Personal%20Detail/Model/resident.dart';
import '../../../../utils/Constants/api_routes.dart';
import '../../../../utils/Constants/constants.dart';
import '../../../../Routes/set_routes.dart';
import '../../../Verification/Verification Code/View/forget_pass_verification_code.dart';

class ResidentPersonalDetailController extends GetxController {
  var isHidden = false;
  var isLoading = false;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController vehiclenoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ownernameController = TextEditingController();
  TextEditingController owneraddressController = TextEditingController();
  TextEditingController ownerphonenumController = TextEditingController();
  TextEditingController addPhonephonenumController = TextEditingController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  var imageFile;
  var imagePath;
  String type = "";
  RxBool loading = false.obs;
  Resident? resident;

  ////////////////

  RxString countryFlag = "".obs;
  RxString countryCode = "".obs;
  RxString phoneNumber = "".obs;
  Country country = Country(
      phoneCode: "92",
      countryCode: "PK",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'Pakistan',
      example: 'Pakistan',
      displayName: 'Pakistan',
      displayNameNoCountryCode: 'PK',
      e164Key: "");

  //////////////////

  @override
  void onInit() {
    super.onInit();
    print(type);
    print("init");

    countryCode.value = country.phoneCode;
    countryFlag.value = country.flagEmoji;
  }

  getFromGallery(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      print('file picked: $pickedFile');

      print('Assigning Image file');
      imageFile = File(pickedFile.path);
      update();
    } else {}
  }

  getFromCamera(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      print('file picked: $pickedFile');
      // img = pickedFile as Image?;

      print('Assigning Image file');
      imageFile = File(pickedFile.path);
      update();
    } else {}
  }

  void togglePasswordView() {
    isHidden = !isHidden;
    update();
  }

  void handleSignUp(
      {required String firstName,
      required String lastName,
      required String cnic,
      required String address,
      required String mobileno,
      required String password,
      required File? file,
      required String type}) async {
    if (type == "Signup") {
      print("signup api call");
      loading.value = true;
      await signUpApi(
          firstName: firstName,
          lastName: lastName,
          cnic: cnic,
          address: address,
          mobileno: mobileno.trim(),
          password: password,
          file: file);
    } else if (type == 'AddFamilyMember') {
      print("add family member api call");
      final AddFamilyMemberController addFamilyMemberController = Get.find();
      loading.value = true;
      await addFamilyMemberController.addFamilyMemberApi(
          bearerToken: addFamilyMemberController.userdata.bearerToken!,
          firstName: addFamilyMemberController.firstnameController.text,
          lastName: addFamilyMemberController.lastnameController.text,
          cnic: addFamilyMemberController.cnicController.text,
          address: addFamilyMemberController.resident.houseaddress!,
          mobileno: mobileno.trim(),
          password: addFamilyMemberController.passwordController.text,
          file: addFamilyMemberController.imageFile,
          subadminid: addFamilyMemberController.resident.subadminid!,
          residentid: addFamilyMemberController.userdata.userId!);
    } else if (type == 'ForgetPassword') {
      print(mobileno.trim());

      await forgetPasswordApi(mobileno: mobileno.trim());
    }

    loading.value = false;
  }

  Future signUpApi(
      {required String firstName,
      required String lastName,
      required String cnic,
      required String address,
      required String mobileno,
      required String password,
      required File? file}) async {
    print("sinup user api call");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLoading = true;
    update();
    var request = Http.MultipartRequest('POST', Uri.parse(Api.signup));
    if (file != null) {
      request.files.add(await Http.MultipartFile.fromPath('image', file.path));
    }
    request.fields['firstname'] = firstName;
    request.fields['lastname'] = lastName;
    request.fields['cnic'] = cnic;
    request.fields['address'] = 'NA';
    request.fields['mobileno'] = mobileno;
    request.fields['roleid'] = 3.toString();
    request.fields['rolename'] = 'resident';
    request.fields['password'] = password;
    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);
    print(response.statusCode);

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data);
      print(response.body);
      resident = Resident(
          id: data['data']['id'],
          firstname: data['data']['firstname'],
          lastname: data['data']['lastname'],
          cnic: data['data']['cnic'],
          address: data['data']['address'],
          mobileno: data['data']['mobileno'],
          roleid: data['data']['roleid'],
          rolename: data['data']['rolename'],
          image: data['data']['image'],
          email: data['data']['emailb'],
          token: data['token']);
      preferences.setString("mobileno", resident!.mobileno ?? "");

      Get.toNamed(verificationCode, arguments: data['data']['id']);
      myToast(msg: 'Registration successfully');

      isLoading = false;
      update();
    } else if (response.statusCode == 403) {
      var data = jsonDecode(response.body.toString());

      (data['errors'] as List)
          .map((e) => myToast(msg: e.toString(), isNegative: true))
          .toList();
      isLoading = false;
      update();
    } else {
      myToast(msg: 'Failed to Register', isNegative: true);
      isLoading = false;
      update();
    }
  }

  /////// forgot passward api
  Future forgetPasswordApi({
    required String mobileno,
  }) async {
    print("forget passward api call");
    final response = await Http.post(
      Uri.parse(Api.forgetPassword),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "mobileno": mobileno,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      final userModel.User user = userModel.User(
          userId: data['data']['id'],
          subadminid: data['data']['subadminid'] ?? 0,
          residentid: data['data']['residentid'] ?? 0,
          firstName: data['data']['firstname'],
          lastName: data['data']['lastname'],
          cnic: data['data']['cnic'],
          roleId: data['data']['roleid'],
          roleName: data['data']['rolename'],
          address: data['data']['address'],
          bearerToken: data['Bearer']);

      myToast(msg: data['message'], isNegative: true);

      Get.to(() => VerificationCodeForForgetPass(), arguments: user);

      //
    } else if (response.statusCode == 403) {
      print(response.body);
      myToast(msg: 'No User Found', isNegative: true);
    } else {
      myToast(msg: 'Operation Failed,Something went Wrong.', isNegative: true);
    }
  }
}

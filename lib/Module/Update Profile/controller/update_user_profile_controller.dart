import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Module/HomeScreen/Controller/home_screen_controller.dart';
import 'package:userapp/Module/Update%20Profile/model/update_phone_model.dart';
import 'package:userapp/Module/Update%20Profile/model/update_user_profile_model.dart';
import 'package:userapp/Module/Update%20Profile/service/update_user_profile_service.dart';
import 'package:userapp/Module/Update%20Profile/view/otp_screen.dart';
import 'package:userapp/Module/Verification/model/verify_otp.dart';
import 'package:userapp/Module/Verification/service/verify_otp_service.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Services/Shared%20Preferences/MySharedPreferences.dart';
import 'package:userapp/utils/Constants/session_controller.dart';

import '../../Login/Model/User.dart';

class UpdateUserProfileController extends GetxController {
  var data = Get.arguments;
  late final User userdata;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();

  var updateProfileModel = UpdateUserProfileModel();
  var updatePhoneModel = UpdatePhoneModel();
  String otp = "";
  RxBool loading = false.obs;
  RxString error = "".obs;

  var imageFile = Rx<File?>(null);
  var imagePath = ''.obs;

  RxBool loading2 = false.obs;
  RxString error2 = "".obs;

  RxBool isLoading = false.obs;
  RxString error3 = "".obs;
  var verifyOtpModel = VarifyOtpModel();

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

  void onInit() {
    super.onInit();
    userdata = data;
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
      imageFile.value = File(pickedFile.path);
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
      imageFile.value = File(pickedFile.path);
      update();
    } else {}
  }

  void updateUserProfile(
      {String? fname, String? lname, int? residentId, File? image}) async {
    loading.value = true;
    error.value = "";

    var res = await UpdateUserProfileService.updateUserProfile(
        fname: fname,
        lastName: lname,
        residentId: residentId,
        image: image,
        bearerToken: SessionController().user.bearerToken ?? "");

    loading.value = false;

    if (res is UpdateUserProfileModel) {
      updateProfileModel = res;

      final User user = User(
        userId: updateProfileModel.data!.id,
        subadminid: updateProfileModel.data!.resident!.subadminid,
        residentid: updateProfileModel.data!.resident!.residentid,
        firstName: updateProfileModel.data!.firstname,
        lastName: updateProfileModel.data!.lastname,
        cnic: updateProfileModel.data!.cnic,
        roleId: updateProfileModel.data!.roleid,
        roleName: updateProfileModel.data!.rolename,
        address: updateProfileModel.data!.address,
        mobile: updateProfileModel.data!.mobileno,
        bearerToken: updateProfileModel.data!.fcmtoken,
        image: updateProfileModel.data!.image,
        email: updateProfileModel.data!.email,
      );

      Get.snackbar("Message", updateProfileModel.message.toString());
      Get.find<HomeScreenController>().updateUser(user);
      Get.offNamed(homescreen, arguments: user);
      MySharedPreferences.setUserData(user: user);
    } else {
      loading.value = false;
      error.value = res.toString();

      Get.snackbar("Error", error.value);
    }
  }

  ////////////////

  void updatePhone({int? userId, String? phone}) async {
    loading2.value = true;
    error.value = "";

    var res = await UpdateUserProfileService.updatePhone(
        userId: userId, phone: phone);

    loading2.value = false;

    if (res is UpdatePhoneModel) {
      updatePhoneModel = res;

      Get.snackbar("Message", updatePhoneModel.message.toString());
      Get.to(() => OtpScreen(
            userId: userdata.userId ?? 0,
          ));
    } else {
      loading2.value = false;
      error2.value = res.toString();
      Get.snackbar("Error", error2.value);
    }
  }

  ////////////////
  verifyUserOtp({String? otp, int? id}) async {
    error3.value = "";
    isLoading.value = true;

    var res = await VerifyOtp.verifyOtp(otp: otp, id: id);
    isLoading.value = false;
    if (res is VarifyOtpModel) {
      verifyOtpModel = res;
      if (verifyOtpModel.data?.isVerified == 1) {
        await FirebaseMessaging.instance.deleteToken();

        MySharedPreferences.deleteUserData();
        Get.offAllNamed(loginscreen);
      } else {
        Get.snackbar("Message", verifyOtpModel.message.toString());
      }

      Get.snackbar("Message", verifyOtpModel.message.toString());
    } else {
      isLoading.value = false;
      error3.value = res.toString();
      Get.snackbar("Error", error3.value);
    }
  }
}

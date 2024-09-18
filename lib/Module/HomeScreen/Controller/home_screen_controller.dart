import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';
import 'package:userapp/App%20Exceptions/app_exception.dart';
import 'package:userapp/Module/HomeScreen/Model/app_permissions_model.dart';
import 'package:userapp/Module/HomeScreen/Model/society_support_model.dart';
import 'package:userapp/Module/HomeScreen/service/home_screen_service.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/utils/Constants/session_controller.dart';
import 'package:userapp/Repo/Home%20Repository/home_repository.dart';
import '../../../Routes/set_routes.dart';
import '../../../Services/Notification Services/notification_services.dart';
import '../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../../Login/Model/User.dart';
import '../Model/DiscussionRoomModel.dart';
import '../Model/residents.dart';

class HomeScreenController extends GetxController {
  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    pageController.dispose();
  }

  late Future<Residents> future;

  final _repository = HomeRepository();
  var imageFile;
  var data = Get.arguments;
  User user = User();
  final pageController = PageController();
  var snapShot;
  RxInt selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final key = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  RxBool checkResidentVerified = false.obs;
  void onItemTapped(int index) {
    print(index);
    selectedIndex.value = index;
    update();
  }

  getFromCamera(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      print('file picked: $pickedFile');

      print('Assigning Image file');
      imageFile = File(pickedFile.path);
      update();
    }
  }

  @override
  void onInit() async {
    super.onInit();

    NotificationServices notificationServices = NotificationServices();
    notificationServices.requestNotification();
    notificationServices.fireBaseInit();
    notificationServices.setupInteractMessage();
    notificationServices.getDeviceToken();

    this.user = data;
    print(user.userId);
    print(user.bearerToken);

    print("User image is ${user.image}");

    future = user.roleName == "familymember"
        ? loginResidentDetails(
            userid: user.residentid!, token: user.bearerToken!)
        : loginResidentDetails(
            userid: user.residentid!, token: user.bearerToken!);

    socitySupportModel =
        await getSocietySupport(subadminId: user.subadminid ?? 0);
    appPermissionModel =
        await getAllAppPermission(societyId: user.societyId?.toString());
  }

  // Method to update user data
  void updateUser(User updatedUser) {
    SessionController().user = updatedUser;
  }

  Future<Residents> loginResidentDetails(
      {required int userid, required String token}) async {
    try {
      checkResidentVerified.value = true;
      final response = await Http.get(
        Uri.parse(Api.loginResidentDetails + "/" + userid.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );
      checkResidentVerified.value = false;
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());
      print(data);
      var e = data['data'];
      var societyData = data['data']['societydata'];
      var societyId = societyData[0]['societyid'];
      var superAdminId = societyData[0]['superadminid'];
      final Residents residents = Residents(
          id: e['id'],
          residentid: e['residentid'],
          subadminid: e['subadminid'],
          superadminid: superAdminId,
          societyid: societyId,
          country: e["country"],
          state: e["state"],
          city: e["city"],
          houseaddress: e["houseaddress"],
          vechileno: e["vechileno"],
          residenttype: e["residenttype"],
          propertytype: e["propertytype"],
          committeemember: e["committeemember"],
          status: e["status"],
          username: e["username"],
          createdAt: e["createdAt"],
          updatedAt: e["updatedAt"]);

      if (response.statusCode == 200) {
        checkResidentVerified.value = false;
        return residents;
      } else {
        checkResidentVerified.value = false;
        throw UnKnownException();
      }
    } on SocketException catch (e) {
      checkResidentVerified.value = false;
      myToast(msg: throw InternetException(e));
    }
  }

  logoutApi({required String token}) async {
    print(token);

    final response = await Http.post(
      Uri.parse(Api.logout),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print("logout successfully");

      MySharedPreferences.deleteUserData();

      Get.offAllNamed(loginscreen);
    } else {
      print(data);
    }
  }

  Future<DiscussionRoomModel> createChatRoomApi({
    required String token,
    required int subadminid,
  }) async {
    final response = await Http.post(
      Uri.parse(Api.createDiscussionRoom),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "subadminid": subadminid,
      }),
    );
    print(response.body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      return DiscussionRoomModel.fromJson(data);
    } else {
      return DiscussionRoomModel.fromJson(data);
    }
  }

  Future<void> refreshScreen() async {
    Future.delayed(Duration(seconds: 1));
    future = await user.roleName == "familymember"
        ? loginResidentDetails(
            userid: user.residentid!, token: user.bearerToken!)
        : // Login user Resident
        loginResidentDetails(userid: user.userId!, token: user.bearerToken!);

    update();
  }

  updateUserNameApi() async {
    isLoading.value = true;
    update();

    Map<String, String> data = <String, String>{
      'residentid': user.userId.toString(),
      'username': userNameController.text.toString()
    };
    _repository.updateUserNameApi(data, user.bearerToken).then((value) async {
      myToast(msg: 'User Name Updated Successfully');
      future = await user.roleId == 5
          ? loginResidentDetails(
              userid: user.residentid!, token: user.bearerToken!)
          : // Login user Resident
          loginResidentDetails(userid: user.userId!, token: user.bearerToken!);
      update();
      userNameController.clear();

      isLoading.value = false;
    }).onError((error, stackTrace) {
      isLoading.value = false;

      update();
      print(stackTrace);
      print(error);
      if (error.toString() == '403UnAuthorized') {
        myToast(msg: 'User Name Already Taken.', isNegative: true);
        userNameController.clear();
      } else {
        myToast(msg: error.toString(), isNegative: true);
      }
    });
  }

  /////////////////////////////

////////  SOCIETY SUPPORT DATA
  RxBool loading = false.obs;
  RxString error = "".obs;

  var socitySupportModel = SocietySupportModel();
  Future<SocietySupportModel> getSocietySupport({int? subadminId}) async {
    error.value = "";
    loading.value = true;

    var res = await HomeScreenService.getSocietySupport(subadminId: subadminId);
    loading.value = false;

    if (res is SocietySupportModel) {
      socitySupportModel = res;

      return socitySupportModel;
    } else {
      loading.value = false;
      error.value = res.toString();
      Get.snackbar("Error", error.value);
    }

    return socitySupportModel;
  }

  ///////////// APP PERMISSIONS
  var appPermissionModel = AppPermissionsModel();
  var error1 = "";

  Future<AppPermissionsModel> getAllAppPermission({String? societyId}) async {
    var res = await HomeScreenService.getAllPermissions(societyId: societyId);
    if (res is AppPermissionsModel) {
      appPermissionModel = res;
      return appPermissionModel;
    } else {
      error1 = res.toString();
      Get.snackbar("Error", error1);
    }

    return appPermissionModel;
  }
}

class QuickActions {
  final String? text;
  final String? iconPath;

  QuickActions({
    required this.text,
    required this.iconPath,
  });
}

class HomeScreenCardModel {
  final String? heading;

  final String? iconPath;
  final String? heading2;

  const HomeScreenCardModel({
    required this.heading,
    required this.iconPath,
    required this.heading2,
  });
}

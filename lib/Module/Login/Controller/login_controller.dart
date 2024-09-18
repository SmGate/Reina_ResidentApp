// ignore_for_file: unused_local_variable

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/Login/Model/fcm_refresh_model.dart';
import 'package:userapp/Module/Login/Model/user_model.dart';
import 'package:userapp/Module/Login/service/login_service.dart';
import 'package:userapp/utils/Constants/session_controller.dart';
import 'package:userapp/Services/Notification%20Services/notification_services.dart';
import '../../../Routes/set_routes.dart';
import '../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../Model/User.dart';

class LoginController extends GetxController {
  var isHidden = false.obs;
  TextEditingController userPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();
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

  /// LOGIN NEW FUNCTION DATA

  RxBool loading = false.obs;
  RxString errorWhileLogin = "".obs;
  var loginUserModel = UserModel();
  var fcmRefreshModel = FcmRefreshModel();

  void togglePasswordView() {
    isHidden.value = !isHidden.value;
    update();
  }

  bool isValidMobileNumber(String mobileNumber) {
    if (mobileNumber.length == 11 &&
        RegExp(r'^\d{11}$').hasMatch(mobileNumber)) {
      return true;
    } else {
      return false;
    }
  }

  // login user new function
  void loginUser({String? mobileNo, String? password}) async {
    loading.value = true;
    errorWhileLogin.value = "";
    var res =
        await LoginService.loginUser(mobileNo: mobileNo, password: password);
    loading.value = false;
    if (res is UserModel &&
        res.data?.rolename == "resident" &&
        res.success == true) {
      loginUserModel = res;
      User user = User(
        userId: loginUserModel.data?.id,
        subadminid: loginUserModel.data?.subadminid,
        residentid: loginUserModel.data?.residentid,
        firstName: loginUserModel.data?.firstname,
        lastName: loginUserModel.data?.lastname,
        cnic: loginUserModel.data?.cnic,
        roleId: loginUserModel.data?.roleid,
        roleName: loginUserModel.data?.rolename,
        address: loginUserModel.data?.address,
        mobile: loginUserModel.data?.mobileno,
        bearerToken: loginUserModel.bearer,
        image: loginUserModel.data?.image,
        email: loginUserModel.data?.email,
        societyId: loginUserModel.data?.societyId,
        hasCustomIntro: loginUserModel.data?.hasCustomIntro,
        slogan: loginUserModel.data?.slogan,
        logo: loginUserModel.data?.logo,
        societyName: loginUserModel.data?.name,
      );

      MySharedPreferences.setUserData(user: user);

      final NotificationServices notificationServices = NotificationServices();
      final String? token = await notificationServices.getDeviceToken();
      fcmtokenrefresh(user.userId!, token!, user.bearerToken!);

      User user2 = await MySharedPreferences.getUserData();
      SessionController().user = user2;

      Get.snackbar("Message", "Login Successfully");

      if (user.address == "NA" || user.address == null) {
        Get.offAndToNamed(residentaddressdetail, arguments: user2);
      } else {
        Get.offAndToNamed(homescreen, arguments: user2);
      }
    } else if (res is UserModel &&
        res.data?.rolename == "familymember" &&
        res.success == true) {
      loginUserModel = res;
      User user = User(
        userId: loginUserModel.data?.id,
        subadminid: loginUserModel.data?.subadminid,
        residentid: loginUserModel.data?.residentid,
        firstName: loginUserModel.data?.firstname,
        lastName: loginUserModel.data?.lastname,
        cnic: loginUserModel.data?.cnic,
        roleId: loginUserModel.data?.roleid,
        roleName: loginUserModel.data?.rolename,
        address: loginUserModel.data?.address,
        mobile: loginUserModel.data?.mobileno,
        bearerToken: loginUserModel.bearer,
        image: loginUserModel.data?.image,
        email: loginUserModel.data?.email,
        societyId: loginUserModel.data?.societyId,
        hasCustomIntro: loginUserModel.data?.hasCustomIntro,
        slogan: loginUserModel.data?.slogan,
        logo: loginUserModel.data?.logo,
        societyName: loginUserModel.data?.name,
      );

      MySharedPreferences.setUserData(user: user);
      final NotificationServices notificationServices = NotificationServices();
      final String? token = await notificationServices.getDeviceToken();
      User user2 = await MySharedPreferences.getUserData();

      SessionController().user = user2;
      fcmtokenrefresh(user.userId!, token!, user.bearerToken!);

      Get.snackbar("Message", "Login Successfully");
      if (user.address == "NA" || user.address == null) {
        Get.offAndToNamed(residentaddressdetail, arguments: user2);
      } else {
        Get.offAndToNamed(homescreen, arguments: user2);
      }

      // var cont = Get.find<HomeScreenController>();
      // cont.updateUser(user2);
    } else {
      loading.value = false;
      errorWhileLogin.value = res.toString();
      Get.snackbar("Error", errorWhileLogin.value);
    }
  }

  Future fcmtokenrefresh(int id, String fcmtoken, String bearertoken) async {
    print("Fcm token refresh Api   Hits ! ");

    try {
      var res1 = await LoginService.fcmRefresh(
          id: id, fcmtoken: fcmtoken, bearertoken: bearertoken);
      if (res1 is FcmRefreshModel) {
        fcmRefreshModel = res1;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    countryCode.value = country.phoneCode;
    countryFlag.value = country.flagEmoji;
  }
}

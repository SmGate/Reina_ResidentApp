// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/utils/Constants/constants.dart';

import '../../../../utils/Constants/api_routes.dart';
import '../../../../Routes/set_routes.dart';
import '../../../Login/Controller/login_controller.dart';
import '../../../Login/Model/User.dart';

class ForgetPasswordController extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  var data = Get.arguments;
  late final User userdata;
  var isHidden = false;
  var isLoading = false;
  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    userdata = data;
    super.onInit();
  }

  @override
  Future resetPasswordApi({
    required int userId,
    required String password,
  }) async {
    isLoading = true;
    update();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var request = Http.MultipartRequest('POST', Uri.parse(Api.resetPassword));
    request.headers.addAll(headers);

    request.fields['password'] = password;
    request.fields['id'] = userId.toString();
    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    if (response.statusCode == 200) {
      passwordController.clear();
      confirmPasswordController.clear();
      myToast(msg: 'Password Reset Successfully');

      isLoading = false;
      update();

      Get.offAllNamed(loginscreen);
      // Get.offAllNamed(homescreen, arguments: userdata);
    } else if (response.statusCode == 403) {
      isLoading = false;
      update();
      myToast(msg: 'Unauthorized User', isNegative: true);
    } else {
      isLoading = false;
      update();
      myToast(msg: 'Something went wrong', isNegative: true);
    }
  }

  void togglePasswordView() {
    isHidden = !isHidden;
    update();
  }
}

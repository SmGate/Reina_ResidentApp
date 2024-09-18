import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Routes/set_routes.dart';
import '../../../HomeScreen/Model/residents.dart';
import '../../../Login/Model/User.dart';
import '../../model/verify_otp.dart';
import '../../service/verify_otp_service.dart';

class VerificationCodeForFamilyMemberController extends GetxController {
  var data = Get.arguments;
  final otpCodeController = TextEditingController();
  RxString otpCode = "".obs;
  RxBool isLoading = false.obs;
  RxString error = "".obs;

  late final User userdata;
  late final Residents resident;

  var verifyOtpModel = VarifyOtpModel();

  @override
  void onInit() {
    super.onInit();

    userdata = data[0];
    resident = data[1];
  }

  verifyUserOtp({String? otp, int? id}) async {
    error.value = "";
    isLoading.value = true;

    var res = await VerifyOtp.verifyOtp(otp: otp, id: id);
    isLoading.value = false;
    if (res is VarifyOtpModel) {
      verifyOtpModel = res;
      if (verifyOtpModel.data?.isVerified == 1) {
        Get.offAllNamed(viewfamilymember, arguments: [userdata, resident]);
      } else {
        Get.snackbar("Message", verifyOtpModel.message.toString());
      }

      Get.snackbar("Message", verifyOtpModel.message.toString());
    } else {
      isLoading.value = false;
      error.value = res.toString();
      Get.snackbar("Error", error.value);
    }
  }
}

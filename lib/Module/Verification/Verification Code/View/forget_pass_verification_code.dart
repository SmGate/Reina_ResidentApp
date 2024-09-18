// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

import '../../../../utils/Constants/constants.dart';
import '../../../../Helpers/Validation Helper/validation_helper.dart';
import '../../../../Widgets/my_button.dart';
import '../Controller/forget_passward_verifcation_code_controller.dart';

class VerificationCodeForForgetPass extends StatelessWidget {
  final verificationCodeForForgetPass =
      Get.put(VerificationCodeForgetPassController());

  VerificationCodeForForgetPass({
    super.key,
  });

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: primaryColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outlined,
                    size: 80,
                    color: AppColors.appThem,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    "Verification Code",
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 25.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    "Enter your 6 digits verification code.",
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 14.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.normal),
                  ),
                  6.h.ph,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Pinput(
                      validator: ValidationHelper().otpValidator,
                      controller:
                          verificationCodeForForgetPass.otpCodeController,
                      length: 6,
                      defaultPinTheme: PinTheme(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.appThem),
                              borderRadius: BorderRadius.circular(12))),
                      onCompleted: (val) {
                        verificationCodeForForgetPass.otpCode.value = val;
                      },
                    ),
                  ),
                  6.h.ph,
                  Obx(() {
                    return verificationCodeForForgetPass.isLoading.value
                        ? CircularProgressIndicator(
                            color: AppColors.appThem,
                          )
                        : MyButton(
                            gradient: AppGradients.buttonGradient,
                            loading:
                                verificationCodeForForgetPass.isLoading.value,
                            name: 'Next',
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                verificationCodeForForgetPass.verifyUserOtp(
                                    otp: verificationCodeForForgetPass
                                        .otpCodeController.text,
                                    id: verificationCodeForForgetPass
                                        .userdata.residentid);
                              }
                            },
                          );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

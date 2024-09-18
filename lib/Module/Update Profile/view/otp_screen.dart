// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Module/Update%20Profile/controller/update_user_profile_controller.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

class OtpScreen extends StatelessWidget {
  int userId;
  OtpScreen({super.key, required this.userId});

  var c = Get.put(UpdateUserProfileController());

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyBackButton(
                text: 'Verification',
                onTap: () {
                  Get.offNamed(homescreen, arguments: c.userdata);
                },
              ),
              SizedBox(
                height: 100,
              ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Pinput(
                  validator: ValidationHelper().otpValidator,
                  controller: c.verificationCodeController,
                  length: 6,
                  defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.appThem,
                          ),
                          borderRadius: BorderRadius.circular(12))),
                  onCompleted: (val) {
                    c.otp = val;
                  },
                ),
              ),
              20.h.ph,
              Obx(() => MyButton(
                    gradient: AppGradients.buttonGradient,
                    loading: c.isLoading.value,
                    width: 173.w,
                    height: 43.w,
                    border: 16.0.r,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        c.verifyUserOtp(id: userId, otp: c.otp);
                      }
                    },
                    textColor: Colors.white,
                    color: AppColors.appThem,
                    name: 'Next',
                    outlinedBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/Module/Verification/Change%20Password/Controller/forget_password_controller.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/Widgets/my_password_textform_field.dart';
import 'package:userapp/utils/styles/colors.dart';

import '../../../../Helpers/Validation Helper/validation_helper.dart';

class ForgetPassword extends GetView {
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
        init: ForgetPasswordController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              body: Center(
                  child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Icon(
                        Icons.lock_outlined,
                        size: 80.w,
                        color: AppColors.appThem,
                      ),
                      13.h.ph,
                      Text(
                        "Change Password",
                        style: GoogleFonts.ubuntu(
                            fontSize: 30.sp, fontWeight: FontWeight.bold),
                      ),
                      13.h.ph,
                      MyPasswordTextFormField(
                        controller: controller.passwordController,
                        validator: ValidationHelper().passwordValidator,
                        obscureText: controller.isHidden,
                        hintText: 'Password',
                        togglePasswordView: controller.togglePasswordView,
                      ),
                      MyPasswordTextFormField(
                        controller: controller.confirmPasswordController,
                        validator: ValidationHelper().passwordValidator,
                        obscureText: controller.isHidden,
                        hintText: 'Confirm Password',
                        togglePasswordView: controller.togglePasswordView,
                      ),
                      13.h.ph,
                      MyButton(
                        loading: controller.isLoading,
                        gradient: AppGradients.buttonGradient,
                        name: 'Confirm',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (controller.passwordController.text ==
                                controller.confirmPasswordController.text) {
                              if (!controller.isLoading) {
                                controller.resetPasswordApi(
                                    userId: controller.userdata.userId ?? 0,
                                    password: controller
                                        .confirmPasswordController.text);
                              }
                            }
                          } else {
                            myToast(
                                msg: 'Password & Confirm Password Must match',
                                isNegative: true);
                          }
                        },
                      )
                    ],
                  ),
                ),
              )),
            ),
          );
        });
  }
}

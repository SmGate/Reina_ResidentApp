import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/Widgets/my_textform_field.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

import '../../../Signup/Resident Personal Detail/Controller/resident_personal_detail_controller.dart';

class AddPhoneForgetPassword extends StatelessWidget {
  const AddPhoneForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var residentPersonalDetailsController =
        Get.find<ResidentPersonalDetailController>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.updatePhone,
            color: AppColors.appThem,
            height: 150,
          ),
          SizedBox(
            height: 50,
          ),
          MyTextFormField(
            hintText: "Enter Phone Number",
            labelText: "Enter Phone Number",
            controller:
                residentPersonalDetailsController.addPhonephonenumController,
          ),
          SizedBox(
            height: 50,
          ),
          Obx(() => MyButton(
                loading: residentPersonalDetailsController.loading.value,
                name: "Done",
                onPressed: () {
                  residentPersonalDetailsController.handleSignUp(
                      firstName: "",
                      lastName: "",
                      cnic: "",
                      address: "",
                      mobileno: residentPersonalDetailsController
                          .addPhonephonenumController.text,
                      password: "",
                      file: null,
                      type: "ForgetPassword");
                },
                gradient: AppGradients.buttonGradient,
              )),
          25.h.ph,
          Wrap(
            children: [
              Text(
                "Have an Account ?",
                style: GoogleFonts.ubuntu(
                    color: Colors.grey,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400),
              ),
              10.w.pw,
              GestureDetector(
                  onTap: () {
                    Get.offAllNamed(loginscreen);
                  },
                  child: Text(
                    "Login",
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 16.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

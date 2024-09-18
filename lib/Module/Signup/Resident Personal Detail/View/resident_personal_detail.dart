// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';
import '../../../../utils/Constants/constants.dart';
import '../../../../Helpers/Validation Helper/validation_helper.dart';
import '../../../../Widgets/my_button.dart';
import '../../../../Widgets/my_password_textform_field.dart';
import '../../../../Widgets/my_textform_field.dart';
import '../Controller/resident_personal_detail_controller.dart';

class ResidentPersonalDetail extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(loginscreen);
        return true;
      },
      child: GetBuilder<ResidentPersonalDetailController>(
          init: ResidentPersonalDetailController(),
          builder: (controller) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        100.h.ph,
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 100.0.h,
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 20.h),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Choose Profile Photo',
                                          style: TextStyle(fontSize: 20.sp),
                                        ),
                                        20.h.ph,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.appThem),
                                              icon: Icon(
                                                Icons.camera,
                                                color: AppColors.yellow,
                                              ),
                                              onPressed: () {
                                                controller.getFromCamera(
                                                    ImageSource.camera);
                                              },
                                              label: Text(
                                                'Camera',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.appThem),
                                              icon: Icon(
                                                Icons.image,
                                                color: AppColors.yellow,
                                              ),
                                              onPressed: () {
                                                controller.getFromGallery(
                                                    ImageSource.gallery);
                                              },
                                              label: Text(
                                                'Gallery',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Stack(
                            children: <Widget>[
                              FittedBox(
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundColor: Colors.white,
                                  backgroundImage: controller.imageFile == null
                                      ? AssetImage(AppImages.addfamilymember)
                                          as ImageProvider
                                      : FileImage(
                                          File(controller.imageFile.path
                                              .toString()),
                                        ),
                                ),
                              ),
                              Positioned(
                                left: 80,
                                top: 80,
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: 100.0.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 20.h),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  'Choose Profile Photo',
                                                  style: TextStyle(
                                                      fontSize: 20.sp),
                                                ),
                                                20.h.ph,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    ElevatedButton.icon(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  AppColors
                                                                      .appThem),
                                                      icon: Icon(
                                                        Icons.camera,
                                                        color: AppColors.yellow,
                                                      ),
                                                      onPressed: () {
                                                        controller
                                                            .getFromCamera(
                                                                ImageSource
                                                                    .camera);
                                                      },
                                                      label: Text(
                                                        'Camera',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    ElevatedButton.icon(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  AppColors
                                                                      .appThem),
                                                      icon: Icon(
                                                        Icons.image,
                                                        color: AppColors.yellow,
                                                      ),
                                                      onPressed: () {
                                                        controller
                                                            .getFromGallery(
                                                                ImageSource
                                                                    .gallery);
                                                      },
                                                      label: Text(
                                                        'Gallery',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: AppColors.appThem,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        16.h.ph,
                        MyTextFormField(
                          controller: controller.firstnameController,
                          validator: ValidationHelper().emptyStringValidator,
                          hintText: 'First Name',
                          labelText: 'Enter First Name',
                        ),
                        MyTextFormField(
                          controller: controller.lastnameController,
                          validator: ValidationHelper().emptyStringValidator,
                          hintText: 'Last Name',
                          labelText: 'Enter Last Name',
                        ),
                        ////  mobel Number

                        MyTextFormField(
                          validator: ValidationHelper().validatePhoneNumber,
                          controller: controller.mobileNoController,
                          textInputType: TextInputType.number,
                          hintText: 'Phone Number',
                          labelText: 'Phone Number',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: GestureDetector(
                                onTap: () {
                                  showCountryPicker(
                                      context: context,
                                      countryListTheme: CountryListThemeData(
                                        flagSize: 30,
                                        backgroundColor: Colors.white,
                                        textStyle: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        bottomSheetHeight: 500,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                        inputDecoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primaryColor,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primaryColor,
                                            ),
                                          ),
                                          labelStyle: GoogleFonts.montserrat(
                                            color: HexColor('#B6B6B6'),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                          labelText: 'Search',
                                          hintText: 'Start typing to search',
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: primaryColor,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onSelect: (Country country) {
                                        controller.countryFlag.value =
                                            country.flagEmoji;
                                        controller.countryCode.value =
                                            country.phoneCode;
                                      });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 16, 8, 0),
                                  child: Obx(() {
                                    return Text(
                                      "${controller.countryFlag} + ${controller.countryCode}",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    );
                                  }),
                                )),
                          ),
                          onTap: () {},
                        ),

                        ////////
                        MyPasswordTextFormField(
                          controller: controller.passwordController,
                          obscureText: controller.isHidden,
                          togglePasswordView: controller.togglePasswordView,
                          validator: ValidationHelper().emptyStringValidator,
                          hintText: 'Password',
                          labelText: 'Password',
                        ),
                        17.h.ph,
                        Obx(() => controller.loading.value
                            ? CircularProgressIndicator(
                                color: AppColors.appThem,
                              )
                            : MyButton(
                                gradient: AppGradients.buttonGradient,
                                width: 173.w,
                                height: 43.w,
                                border: 16.0.r,
                                loading: controller.loading.value,
                                onPressed: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.handleSignUp(
                                        firstName:
                                            controller.firstnameController.text,
                                        lastName:
                                            controller.lastnameController.text,
                                        cnic: "",
                                        address: "",
                                        mobileno:
                                            "+${controller.countryCode}${controller.mobileNoController.text}",
                                        password:
                                            controller.passwordController.text,
                                        file: controller.imageFile,
                                        type: "Signup");
                                  }
                                },
                                textColor: Colors.white,
                                color: AppColors.appThem,
                                name: 'Next',
                                outlinedBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
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
                        25.h.ph,
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

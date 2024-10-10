// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Module/Family%20Member/Add%20Family%20Member/Controller/add_family_member_controller.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';

import '../../../../utils/Constants/constants.dart';
import '../../../../Routes/set_routes.dart';
import '../../../../Widgets/my_back_button.dart';
import '../../../../Widgets/my_button.dart';
import '../../../../Widgets/my_password_textform_field.dart';
import '../../../../Widgets/my_textform_field.dart';
import '../../../Signup/Resident Personal Detail/Controller/resident_personal_detail_controller.dart';

class AddFamilyMember extends GetView {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var residentPersonalDetailController =
        Get.find<ResidentPersonalDetailController>();
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.background,
          body: GetBuilder<AddFamilyMemberController>(
              init: AddFamilyMemberController(),
              builder: (controller) {
                return WillPopScope(
                  onWillPop: () async {
                    return await Get.offNamed(viewfamilymember,
                        arguments: [controller.userdata, controller.resident]);
                  },
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          MyBackButton(
                            text: 'Family Members',
                            onTap: () {
                              Get.offNamed(viewfamilymember, arguments: [
                                controller.userdata,
                                controller.resident
                              ]);
                            },
                          ),
                          60.h.ph,
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 100.0,
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'Choose Profile Photo',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(height: 20),
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
                                                      color: AppColors
                                                          .globalWhite),
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
                                                      color: AppColors
                                                          .globalWhite),
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
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        controller.imageFile == null
                                            ? AssetImage(
                                                AppImages.addfamilymember,
                                              ) as ImageProvider
                                            : FileImage(
                                                File(
                                                  controller.imageFile!.path,
                                                ),
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
                                              height: 100.0,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 20),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    'Choose Profile Photo',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(height: 20),
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
                                                          color:
                                                              AppColors.yellow,
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
                                                              color: AppColors
                                                                  .globalWhite),
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
                                                          color:
                                                              AppColors.yellow,
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
                                                              color: AppColors
                                                                  .globalWhite),
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
                            maxLines: 1,
                            validator: ValidationHelper().emptyStringValidator,
                            hintText: 'First Name',
                            labelText: 'First Name',
                          ),
                          MyTextFormField(
                            controller: controller.lastnameController,
                            validator: ValidationHelper().emptyStringValidator,
                            hintText: 'Last Name',
                            labelText: 'Last Name',
                          ),

                          ////  mobel Number

                          MyTextFormField(
                            validator: ValidationHelper().validatePhoneNumber,
                            controller: controller.mobileNoController,
                            textInputType: TextInputType.number,
                            hintText: 'Phone Number',
                            labelText: 'Phone Number',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 18),
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
                                                color: AppColors.appThem,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.appThem,
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
                                              color: AppColors.appThem,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.appThem,
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
                            maxLines: 1,
                            controller: controller.passwordController,
                            obscureText: controller.isHidden,
                            togglePasswordView: controller.togglePasswordView,
                            validator: ValidationHelper().emptyStringValidator,
                            hintText: 'Password',
                            labelText: 'Password',
                          ),
                          17.h.ph,
                          Obx(() => MyButton(
                                loading: residentPersonalDetailController
                                    .loading.value,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    residentPersonalDetailController.handleSignUp(
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
                                        type: "AddFamilyMember");
                                  }
                                },
                                textColor: Colors.white,
                                gradient: AppGradients.buttonGradient,
                                name: 'Next',
                                width: 300,
                                outlinedBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              )),
                          25.h.ph,
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

import '../../../Widgets/my_back_button.dart';
import '../../../Widgets/my_button.dart';
import '../Controller/sell_products_controller.dart';

class SellProductsScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SellProductsController>(
        init: SellProductsController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offNamed(marketPlaceScreen,
                  arguments: [controller.userdata, controller.resident]);
              return true;
            },
            child: Scaffold(
                backgroundColor: HexColor('#FFFFFF'),
                body: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      MyBackButton(
                        text: 'Product Detail',
                        onTap: () {
                          Get.offNamed(marketPlaceScreen, arguments: [
                            controller.userdata,
                            controller.resident
                          ]);
                        },
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              40.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              backgroundColor:
                                                  AppColors.globalWhite,
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  height: 100.0,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Text(
                                                        'Choose Photo',
                                                        style: TextStyle(
                                                            fontSize: 20),
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
                                                              color: AppColors
                                                                  .yellow,
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .takePictureWithCamera();

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            label: Text(
                                                              'Camera',
                                                              style: reusableTextStyle(
                                                                  textStyle:
                                                                      GoogleFonts
                                                                          .dmSans(),
                                                                  fontSize:
                                                                      18.0,
                                                                  color: AppColors
                                                                      .globalWhite,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
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
                                                              color: AppColors
                                                                  .yellow,
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .pickImageFromGallery();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            label: Text(
                                                              'Gallery',
                                                              style: reusableTextStyle(
                                                                  textStyle:
                                                                      GoogleFonts
                                                                          .dmSans(),
                                                                  fontSize:
                                                                      18.0,
                                                                  color: AppColors
                                                                      .globalWhite,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  AppImages.addfamilymember,
                                                  width: 90,
                                                  height: 90,
                                                ),
                                                Text(
                                                  "Add Image",
                                                  style: reusableTextStyle(
                                                      textStyle:
                                                          GoogleFonts.dmSans(),
                                                      fontSize: 16.0,
                                                      color:
                                                          AppColors.textBlack,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            width: 319.w,
                                            height: 160.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors.appThem,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        6.r))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              20.h.ph,
                              Obx(
                                () => controller.selectedImages.length == 0
                                    ? Container()
                                    : Container(
                                        margin: EdgeInsets.only(
                                            left: 30, right: 30),
                                        height: 120,
                                        child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 4.0,
                                          ),
                                          itemCount:
                                              controller.selectedImages.length,
                                          itemBuilder: (context, index) {
                                            return Image.file(
                                              File(controller
                                                  .selectedImages[index].path),
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )),
                              ),
                              20.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: MarketplaceTextFormField(
                                    hintText: 'Product Name',
                                    validator:
                                        ValidationHelper().emptyStringValidator,
                                    controller:
                                        controller.productNameController),
                              ),
                              20.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: MarketplaceTextFormField(
                                    hintText: 'Description',
                                    validator:
                                        ValidationHelper().emptyStringValidator,
                                    controller:
                                        controller.descriptionController),
                              ),
                              20.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: MarketplaceTextFormField(
                                    hintText: 'Price',
                                    keyboardType: TextInputType.number,
                                    validator:
                                        ValidationHelper().emptyStringValidator,
                                    controller:
                                        controller.productPriceController),
                              ),
                              20.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: MarketplaceTextFormField(
                                    keyboardType: TextInputType.phone,
                                    hintText: 'Contact',
                                    validator:
                                        ValidationHelper().validateMobileNumber,
                                    controller: controller.contactController),
                              ),
                              20.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: Text(
                                  "Condition",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 14.0,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: DropdownButton(
                                  dropdownColor: AppColors.globalWhite,
                                  isExpanded: true,
                                  style: GoogleFonts.ubuntu(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14.sp,
                                      color: HexColor('#4D4D4D')),
                                  value: controller.conditionTypeDropDownValue,
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: AppColors.appThem,
                                    size: 24.w,
                                  ),
                                  items: controller.conditionTypeList
                                      .map((String? items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items!,
                                        style: reusableTextStyle(
                                            textStyle: GoogleFonts.dmSans(),
                                            fontSize: 14.0,
                                            color: AppColors.textBlack,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    controller.setConditionTypeDropDownValue(
                                        newValue);
                                  },
                                ),
                              ),
                              20.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: Text(
                                  "Category",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 14.0,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: DropdownButton(
                                  dropdownColor: AppColors.globalWhite,
                                  isExpanded: true,
                                  style: GoogleFonts.ubuntu(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14.sp,
                                      color: HexColor('#4D4D4D')),
                                  value: controller.categoryTypeDropDownValue,
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                    color: AppColors.appThem,
                                    size: 24.w,
                                  ),
                                  items: controller.categoryTypeList
                                      .map((String? items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items!,
                                        style: reusableTextStyle(
                                            textStyle: GoogleFonts.dmSans(),
                                            fontSize: 14.0,
                                            color: AppColors.textBlack,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    controller
                                        .setCategoryTypeDropDownValue(newValue);
                                  },
                                ),
                              ),
                              43.h.ph,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w),
                                child: Obx(() => MyButton(
                                    loading: controller.isLoading.value,
                                    gradient: AppGradients.buttonGradient,
                                    width: 319.w,
                                    height: 45.w,
                                    name: 'Save',
                                    onPressed: () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        if (controller.selectedImages.length ==
                                            0) {
                                          myToast(
                                              msg: 'Please Select Image',
                                              isNegative: true,
                                              gravity: ToastGravity.CENTER);
                                        } else {
                                          controller.addProductDetailApi(
                                              societyid: controller
                                                  .resident.societyid!,
                                              subadminid: controller
                                                  .resident.subadminid!,
                                              token: controller
                                                  .userdata.bearerToken!,
                                              residentid: controller
                                                  .resident.residentid!,
                                              productname: controller
                                                  .productNameController.text,
                                              description: controller
                                                  .descriptionController.text,
                                              productprice: controller
                                                  .productPriceController.text,
                                              images: controller
                                                  .base64ImagesWithPrefix,
                                              condition: controller
                                                      .conditionTypeDropDownValue ??
                                                  "N/A",
                                              category: controller
                                                      .categoryTypeDropDownValue ??
                                                  "N/A",
                                              contact: controller
                                                  .contactController.text);
                                        }
                                      }
                                    })),
                              ),
                              34.h.ph
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}

class MarketplaceTextFormField extends StatelessWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  MarketplaceTextFormField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      cursorColor: AppColors.appThem,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.appThem,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.appThem,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.appThem,
          ),
        ),
        hintText: hintText ?? "",
        hintStyle: reusableTextStyle(
          textStyle: GoogleFonts.dmSans(),
          fontSize: 14.0,
          color: AppColors.textBlack,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

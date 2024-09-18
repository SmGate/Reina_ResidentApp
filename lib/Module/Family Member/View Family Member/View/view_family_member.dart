// ignore_for_file: must_be_immutable, deprecated_member_use, unused_field

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Module/Family%20Member/View%20Family%20Member/Controller/reset_password_controller.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/Module/Family%20Member/View%20Family%20Member/Controller/view_family_member_controller.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/empty_list.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';
import '../../../../Helpers/Validation Helper/validation_helper.dart';
import '../../../../Widgets/my_password_textform_field.dart';
import '../../../../utils/Constants/api_routes.dart';
import '../../../../Widgets/my_back_button.dart';
import '../../../../Widgets/my_button.dart';

class ViewFamilyMember extends GetView {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewFamilyMemberController>(
        init: ViewFamilyMemberController(),
        builder: (controller) => SafeArea(
              child: WillPopScope(
                onWillPop: () async {
                  await Get.offNamed(homescreen,
                      arguments: controller.userdata);

                  return false;
                },
                child: Scaffold(
                  backgroundColor: AppColors.background,
                  body: Column(
                    children: [
                      MyBackButton(
                        text: 'Family Members',
                        onTap: () {
                          Get.offNamed(homescreen,
                              arguments: controller.userdata);
                        },
                      ),
                      34.h.ph,
                      Expanded(
                        child: FutureBuilder(
                            future: controller.viewResidentsApi(
                                controller.resident.subadminid!,
                                controller.userdata.userId!,
                                controller.userdata.bearerToken!),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data.data != null &&
                                    snapshot.data.data!.length != 0) {
                                  controller.familyMemberCount =
                                      snapshot.data.data!.length;

                                  controller.checkFamilyMemberCount(
                                      count: controller.familyMemberCount);

                                  return Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 14.h),
                                                child: CustomCard(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  width: double.infinity,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Center(
                                                              child: Container(
                                                                height: 60,
                                                                width: 60,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              300),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    imageUrl: Api
                                                                            .imageBaseUrl +
                                                                        snapshot
                                                                            .data!
                                                                            .data[index]
                                                                            .image
                                                                            .toString(),
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        color: AppColors
                                                                            .appThem,
                                                                      ),
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              "${snapshot.data!.data[index].firstname.toString()} ${snapshot.data!.data[index].lastname.toString()}",
                                                              style: reusableTextStyle(
                                                                  textStyle:
                                                                      GoogleFonts
                                                                          .dmSans(),
                                                                  fontSize:
                                                                      18.0,
                                                                  color: AppColors
                                                                      .textBlack,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Spacer(),
                                                            Container(
                                                              height: 30,
                                                              width: 60,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .greyTransparent,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              300)),
                                                              child: Center(
                                                                child:
                                                                    PopupMenuButton(
                                                                        surfaceTintColor:
                                                                            AppColors
                                                                                .globalWhite,
                                                                        shadowColor:
                                                                            AppColors
                                                                                .globalWhite,
                                                                        onSelected:
                                                                            (val) {
                                                                          if (val ==
                                                                              'reset') {
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) => AlertDialog(
                                                                                    backgroundColor: AppColors.globalWhite,
                                                                                    surfaceTintColor: AppColors.globalWhite,
                                                                                    content: GetBuilder<ResetPasswordController>(
                                                                                        init: ResetPasswordController(),
                                                                                        builder: (resetPasswordController) {
                                                                                          return Form(
                                                                                            key: _formKey,
                                                                                            child: SingleChildScrollView(
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  Text(
                                                                                                    "Reset Passward",
                                                                                                    style: reusableTextStyle(textStyle: GoogleFonts.dmSans(), fontSize: 18.0, color: AppColors.textBlack, fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    height: 20,
                                                                                                  ),
                                                                                                  SvgPicture.asset(
                                                                                                    'assets/new_icons/reset_password_icon.svg',
                                                                                                    width: 100.w,
                                                                                                  ),
                                                                                                  20.h.ph,
                                                                                                  MyPasswordTextFormField(validator: ValidationHelper().emptyStringValidator, labelText: 'New Password', hintText: 'New Password', togglePasswordView: resetPasswordController.togglePasswordView, controller: resetPasswordController.passwordController, obscureText: resetPasswordController.isHidden),
                                                                                                  20.h.ph,
                                                                                                  MyButton(
                                                                                                    gradient: AppGradients.buttonGradient,
                                                                                                    loading: resetPasswordController.isLoading,
                                                                                                    name: 'Reset Password',
                                                                                                    onPressed: () {
                                                                                                      if (_formKey.currentState!.validate()) {
                                                                                                        if (!resetPasswordController.isLoading) {
                                                                                                          resetPasswordController.resetPasswordApi(familymemberid: snapshot.data.data[index].familymemberid, bearerToken: controller.userdata.bearerToken!, password: resetPasswordController.passwordController.text);
                                                                                                        }
                                                                                                      }
                                                                                                    },
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        })));
                                                                          }
                                                                        },
                                                                        itemBuilder:
                                                                            (context) {
                                                                          return [
                                                                            PopupMenuItem(
                                                                                value: 'reset',
                                                                                child: Text('Reset Password')),
                                                                          ];
                                                                        }),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Image.asset(
                                                              AppImages.call2,
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              "Phone Number",
                                                              style: reusableTextStyle(
                                                                  textStyle:
                                                                      GoogleFonts
                                                                          .dmSans(),
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColors
                                                                      .textBlack,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "${snapshot.data!.data[index].mobileno.toString()}",
                                                              style: reusableTextStyle(
                                                                  textStyle:
                                                                      GoogleFonts
                                                                          .dmSans(),
                                                                  fontSize:
                                                                      16.0,
                                                                  color: AppColors
                                                                      .textBlack,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount:
                                                snapshot.data.data.length),
                                      ),
                                      MyButton(
                                        width: 340.w,
                                        name: 'Add',
                                        gradient: AppGradients.buttonGradient,
                                        onPressed: () {
                                          if (controller
                                              .familyMemberCountExceed) {
                                            myToast(
                                                msg:
                                                    "You have successfully added three family members previously, and the system restricts adding more than three at this time.");
                                          } else {
                                            Get.offNamed(addfamilymember,
                                                arguments: [
                                                  controller.userdata,
                                                  controller.resident
                                                ]);
                                          }
                                        },
                                      ),
                                      20.h.ph
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 300),
                                        child: EmptyList(
                                          name: 'No Family Member',
                                        ),
                                      ),
                                      Spacer(),
                                      MyButton(
                                        gradient: AppGradients.buttonGradient,
                                        width: 340.w,
                                        name: 'Add',
                                        onPressed: () {
                                          if (controller
                                              .familyMemberCountExceed) {
                                            myToast(
                                                msg:
                                                    "You have successfully added three family members previously, and the system restricts adding more than three at this time.");
                                          } else {
                                            Get.offNamed(addfamilymember,
                                                arguments: [
                                                  controller.userdata,
                                                  controller.resident
                                                ]);
                                          }
                                        },
                                      ),
                                      10.h.ph
                                    ],
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return Icon(Icons.error_outline);
                              } else {
                                return Center(
                                    child: CircularIndicatorUnderWhiteBox());
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

import '../../../Helpers/Validation Helper/validation_helper.dart';
import '../Controller/emergency_controller.dart';
import '../../../Widgets/my_textform_field.dart';

class EmergencyCard extends GetView {
  final AddEmergencyController controller;
  final AllEmergencies emergencies;
  final _formKey = new GlobalKey<FormState>();

  EmergencyCard(
      {super.key, required this.controller, required this.emergencies});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CustomCard(
        margin: EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        height: 60,
        onTap: () {
          if (emergencies.emergencyTypes == EmergencyTypes.Other) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // ignore: deprecated_member_use
                return WillPopScope(
                  onWillPop: () async {
                    controller.descriptionController.clear();
                    Navigator.of(context).pop();
                    return true;
                  },
                  child: AlertDialog(
                    backgroundColor: AppColors.globalWhite,
                    surfaceTintColor: AppColors.globalWhite,
                    title: Text(
                      'Emergency ( ${emergencies.emergencyTypes!.name} )',
                      style: GoogleFonts.quicksand(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyTextFormField(
                            width: 328.w,
                            height: 78.w,
                            maxLength: 40,
                            padding: EdgeInsets.zero,
                            validator: ValidationHelper().emptyStringValidator,
                            maxLines: 4,
                            fillColor: Colors.white,
                            controller: controller.descriptionController,
                            hintText: 'Describe Problem',
                            labelText: 'Describe Problem',
                          ),
                          Obx(() {
                            return SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (!controller.isLoading.value) {
                                      controller.addEmergencyApi(
                                        residentid: controller.userdata.userId!,
                                        societyid:
                                            controller.resident.societyid!,
                                        subadminid:
                                            controller.resident.subadminid!,
                                        problem:
                                            emergencies.emergencyTypes!.name,
                                        description: controller
                                            .descriptionController.text,
                                      );
                                    }
                                  }
                                },
                                child: controller.isLoading.value
                                    ? CircularProgressIndicator(
                                        strokeWidth: 1,
                                        color: AppColors.appThem,
                                      )
                                    : Text(
                                        'Submit',
                                        style: reusableTextStyle(
                                          textStyle: GoogleFonts.dmSans(),
                                          fontSize: 16.0,
                                          color: AppColors.appThem,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            );
                          }),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                controller.descriptionController.clear();
                              },
                              child: Text(
                                'Cancel',
                                style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 16.0,
                                  color: AppColors.appThem,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: AppColors.globalWhite,
                  surfaceTintColor: AppColors.globalWhite,
                  title: Text(
                    'Emergency ( ${emergencies.emergencyTypes!.name} )',
                    style: GoogleFonts.quicksand(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Would you like to submit your individual emergency report to the authorities?",
                          style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              return SizedBox(
                                width: 100.w,
                                child: TextButton(
                                  onPressed: () {
                                    if (!controller.isLoading.value) {
                                      controller.addEmergencyApi(
                                        residentid: controller.userdata.userId!,
                                        societyid:
                                            controller.resident.societyid!,
                                        subadminid:
                                            controller.resident.subadminid!,
                                        problem:
                                            emergencies.emergencyTypes!.name,
                                        description: controller
                                            .descriptionController.text,
                                      );
                                      Navigator.of(context)
                                          .pop(); // Close the dialog after submission
                                    }
                                  },
                                  child: controller.isLoading.value
                                      ? CircularProgressIndicator(
                                          strokeWidth: 1,
                                          color: AppColors.appThem,
                                        )
                                      : Text(
                                          'Yes',
                                          style: reusableTextStyle(
                                            textStyle: GoogleFonts.dmSans(),
                                            fontSize: 16.0,
                                            color: AppColors.appThem,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              );
                            }),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 16.0,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emergencies.title.toString(),
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 14.0,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            10.h.ph,
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                  color: AppColors.appThem.withOpacity(0.2),
                  shape: BoxShape.circle),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(emergencies.icon ?? ""),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

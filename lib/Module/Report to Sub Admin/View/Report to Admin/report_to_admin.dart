// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/Helpers/Validation%20Helper/validation_helper.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/Widgets/my_textform_field.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';

import '../../../../Routes/set_routes.dart';
import '../../Controller/Report to Admin Controller/report_to_admin_controller.dart';

class ReportToAdmin extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.globalWhite,
        body: GetBuilder<AddReportToAdminController>(
            init: AddReportToAdminController(),
            builder: (controller) {
              return WillPopScope(
                onWillPop: () async {
                  Get.offNamed(adminreports,
                      arguments: [controller.userdata, controller.resident]);
                  return true;
                },
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MyBackButton(
                          text: 'Complaint to Admin ',
                          onTap: () {
                            Get.offNamed(adminreports, arguments: [
                              controller.userdata,
                              controller.resident
                            ]);
                          },
                        ),

                        20.h.ph,
                        Image.asset(
                          AppImages.adminComplaint,
                          height: 200,
                        ),
                        74.h.ph,
                        MyTextFormField(
                          controller: controller.reportTitleController,
                          validator: ValidationHelper().emptyStringValidator,
                          hintText: 'Complaint Title',
                          labelText: 'Complaint Title',
                        ),

                        MyTextFormField(
                          width: null,
                          maxLines: 5,
                          controller: controller.reportDescriptionController,
                          validator: ValidationHelper().emptyStringValidator,
                          hintText: 'Complaint Description',
                          labelText: 'Complaint Description',
                        ),

                        76.h.ph,

                        MyButton(
                          loading: controller.isLoading,
                          gradient: AppGradients.buttonGradient,
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              if (!controller.isLoading) {
                                controller.reportToAdminApi(
                                    token: controller.userdata.bearerToken!,
                                    subadminid:
                                        controller.resident!.subadminid!,
                                    userid: controller.userdata.userId!,
                                    title:
                                        controller.reportTitleController.text,
                                    description: controller
                                        .reportDescriptionController.text);
                              }
                            }
                          },
                          name: 'Submit',
                        ),
                        20.h.ph,

                        // sixth Element
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

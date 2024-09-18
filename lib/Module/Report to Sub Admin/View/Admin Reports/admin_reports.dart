// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/Module/Report%20to%20Sub%20Admin/Controller/Admin%20Reports%20Controller/admin_reports_controller.dart';
import 'package:userapp/Module/Report%20to%20Sub%20Admin/Model/Reports.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/empty_list.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';

import '../../../../Helpers/Date Helper/date_helper.dart';
import '../../../../utils/styles/reuseable_textstyle.dart';
import '../component/complaint_card.dart';

class AdminReports extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminReportsController>(
      init: AdminReportsController(),
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          Get.offNamed(homescreen, arguments: controller.user);

          return true;
        },
        child: SafeArea(
            child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              MyBackButton(
                text: 'Complaint',
                onTap: () {
                  Get.offNamed(homescreen, arguments: controller.user);
                },
              ),
              32.h.ph,
              Expanded(
                child: PagedListView(
                  shrinkWrap: true,
                  primary: false,
                  pagingController: controller.pagingController,
                  addAutomaticKeepAlives: false,
                  builderDelegate: PagedChildBuilderDelegate(
                    firstPageProgressIndicatorBuilder: (context) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 250),
                        child: Center(child: CircularIndicatorUnderWhiteBox()),
                      ));
                    },
                    newPageProgressIndicatorBuilder: (context) {
                      return Center(
                        child:
                            CircularProgressIndicator(color: AppColors.appThem),
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 300),
                        child: EmptyList(
                          name: 'No Complains',
                        ),
                      );
                    },
                    itemBuilder: (context, item, index) {
                      final Reports reports = item as Reports;

                      return ComplainCard(
                        index: index,
                        controller: controller,
                        id: reports.id,
                        title: reports.title,
                        description: reports.description,
                        userId: reports.userid,
                        subAdminId: reports.subadminid,
                        createdAt: reports.createdAt,
                        status: reports.status,
                        statusDescription: reports.statusdescription,
                        updatedAat: reports.updatedAt,
                        icon: AppImages.complaints,
                        onpressesd: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    backgroundColor: AppColors.globalWhite,
                                    surfaceTintColor: AppColors.globalWhite,
                                    content: ComplaintDialog(
                                      userId: reports.userid,
                                      statusDescription:
                                          reports.statusdescription,
                                      status: reports.status,
                                      index: index,
                                      id: reports.id,
                                      controller: controller,
                                      title: reports.title,
                                      description: reports.description,
                                      updatedAt: reports.updatedAt,
                                      createdAt: reports.createdAt,
                                      dialogTitle: 'Complaint',
                                    ),
                                  ));
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  gradient: AppGradients.floatingbuttonGradient,
                  shape: BoxShape.circle),
              child: IconButton(
                  onPressed: () {
                    Get.offNamed(reporttoadmin,
                        arguments: [controller.user, controller.resident]);
                  },
                  icon: Icon(
                    Icons.add,
                    color: AppColors.globalWhite,
                    weight: 20.0,
                    size: 40,
                  ))),
        )),
      ),
    );
  }
}

class ComplaintDialog extends StatelessWidget {
  final String? dialogTitle;
  final String? title;
  final String? description;
  final String? updatedAt;
  final String? createdAt;
  final int? index;
  final int? id;
  final int? userId;
  final int? status;
  final String? statusDescription;
  final AdminReportsController controller;

  ComplaintDialog(
      {super.key,
      required this.status,
      required this.statusDescription,
      required this.title,
      required this.userId,
      required this.description,
      required this.updatedAt,
      required this.createdAt,
      required this.controller,
      required this.index,
      required this.id,
      this.dialogTitle});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              dialogTitle ?? "",
              style: GoogleFonts.montserrat(
                color: HexColor('#4D4D4D'),
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
          ),
          16.h.ph,
          Text(
            'Title',
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 16.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          4.h.ph,
          Text(
            title ?? "",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.dark,
                fontWeight: FontWeight.normal),
          ),
          8.h.ph,
          Text(
            'Description',
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 16.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          4.h.ph,
          Text(
            description ?? "",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.dark,
                fontWeight: FontWeight.normal),
          ),
          8.h.ph,
          Text(
            'Submitted At',
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 16.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          14.h.ph,
          Row(
            children: [
              Image.asset(
                AppImages.date2,
                height: 16,
              ),
              11.w.pw,
              Text(
                DateHelper.formatDate(createdAt!),
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.normal),
              ),
              11.w.pw,
              Image.asset(
                AppImages.timer,
                height: 16,
              ),
              11.w.pw,
              Text(
                DateHelper.convertTo12HourFormatFromTimeStamp(createdAt!),
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          14.h.ph,
          Text(
            'Accepted At',
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 16.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          14.h.ph,
          Row(
            children: [
              Image.asset(
                AppImages.date2,
                height: 16,
              ),
              11.w.pw,
              Text(
                DateHelper.formatDate(updatedAt!),
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.normal),
              ),
              11.w.pw,
              Image.asset(
                AppImages.timer,
                height: 16,
              ),
              11.w.pw,
              Text(
                DateHelper.convertTo12HourFormatFromTimeStamp(updatedAt!),
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          14.h.ph,
          Row(
            children: [
              Text(
                'Status',
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 18.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.normal),
              ),
              11.w.pw,
              if (status == 0) ...[
                ComplainStatusCard(
                  statusDescription: statusDescription,
                  color: AppColors.greyTransparent,
                )
              ] else if (status == 2) ...[
                ComplainStatusCard(
                  statusDescription: statusDescription,
                  color: AppColors.yellow,
                )
              ],
            ],
          ),
          80.h.ph,
          if (status == 2) ...[
            Center(
              child: MyButton(
                gradient: AppGradients.buttonGradient,
                width: 300.w,
                color: Colors.green.shade700,
                name: 'Problem Solved',
                onPressed: () {
                  Get.defaultDialog(
                    title: '',
                    titlePadding: EdgeInsets.zero,
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          if (!controller.isLoading) {
                            controller.ProblemSolvedButtonApi(
                                id: id!,
                                token: controller.user.bearerToken!,
                                userId: userId!,
                                index: index!);
                          } else {
                            Get.back();
                          }
                        },
                        child: Container(
                          width: 80.w,
                          height: 25.w,
                          child: controller.isSolved
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: AppColors.appThem,
                                ))
                              : Center(
                                  child: Text(
                                    'Yes',
                                    style: GoogleFonts.ubuntu(
                                      color: HexColor(
                                        '#FFFFFF',
                                      ),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                          decoration: BoxDecoration(
                              color: HexColor('#5AE244'),
                              borderRadius: BorderRadius.circular(4.r)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 80.w,
                          height: 25.w,
                          child: Center(
                            child: Text(
                              'No',
                              style: GoogleFonts.ubuntu(
                                color: HexColor(
                                  '#FFFFFF',
                                ),
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: HexColor('#FF3232'),
                              borderRadius: BorderRadius.circular(4.r)),
                        ),
                      ),
                    ],
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // 16.h.ph,
                        // SvgPicture.asset(
                        //     'assets/new_icons/complaint_problem _solved_icon.svg'),

                        Text(
                          'Complaint',
                          style: GoogleFonts.montserrat(
                              color: HexColor(
                                '#4D4D4D',
                              ),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        16.h.ph,
                        Text(
                          'Has your Problem been Resolved ?',
                          style: GoogleFonts.ubuntu(
                            color: HexColor(
                              '#4D4D4D',
                            ),
                            fontSize: 14.sp,
                          ),
                        ),
                        20.h.ph
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ],
      ),
    );
  }
}

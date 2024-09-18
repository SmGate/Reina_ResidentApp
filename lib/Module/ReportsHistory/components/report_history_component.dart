import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/utils/Constants/images_strings.dart';

import '../../../Helpers/Date Helper/date_helper.dart';
import '../../../utils/styles/colors.dart';
import '../../../utils/styles/reuseable_textstyle.dart';
import '../../Report to Sub Admin/View/component/complaint_card.dart';
import '../Controller/admin_reports_history_controller.dart';

Widget MyStatusWidget({required status, required color, Color? textColor}) {
  return Container(
    width: 64,
    height: 18,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(4.r)),
    child: Center(
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10.sp,
          color: textColor ?? HexColor('#FFFFFF'),
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}

class ComplaintHistoryDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final int? status;
  final String? statusDescription;
  final String? updatedAat;
  final String? createdAt;

  const ComplaintHistoryDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.status,
      required this.statusDescription,
      required this.updatedAat,
      required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 307.w,
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            "Complain History",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 18.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
        ),
        16.h.ph,
        Text(
          'Title',
          style: reusableTextStyle(
              textStyle: GoogleFonts.dmSans(),
              fontSize: 14.0,
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
              fontSize: 14.0,
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
              fontSize: 14.0,
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
              fontSize: 14.0,
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
              DateHelper.formatDate(updatedAat!),
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
              DateHelper.convertTo12HourFormatFromTimeStamp(updatedAat!),
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
                  fontSize: 14.0,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.bold),
            ),
            20.w.pw,
            if (status == 3) ...[
              ComplainStatusCard(
                statusDescription: 'Rejected',
                color: HexColor('#F53932'),
              )
            ] else if (status == 4) ...[
              ComplainStatusCard(
                statusDescription: statusDescription,
                color: HexColor('#3BB651'),
              )
            ],
          ],
        ),
        14.h.ph,
        if (status == 3) ...[
          Text(
            'Reason of Rejection',
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          4.h.ph,
          Text(
            statusDescription ?? "",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.dark,
                fontWeight: FontWeight.normal),
          ),
        ]
      ])),
    );
  }
}

class ComplainDialogBorderWidget extends StatelessWidget {
  final String? text;

  const ComplainDialogBorderWidget({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82.w,
      height: 25.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.r),
          border: Border.all(color: primaryColor)),
      child: Center(
        child: Text(
          text ?? "",
          style: GoogleFonts.ubuntu(
            color: HexColor('#535353'),
            fontSize: 10.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

class ReportHistoryCard extends StatelessWidget {
  final int? id;
  final int? userId;
  final int? subAdminId;
  final String? title;
  final String? description;
  final int? status;
  final String? statusDescription;
  final String? updatedAat;
  final String? createdAt;
  final ReportHistoryController controller;
  final Function? ontap;
  ReportHistoryCard(
      {super.key,
      required this.id,
      required this.userId,
      required this.subAdminId,
      required this.title,
      required this.description,
      required this.status,
      required this.statusDescription,
      required this.updatedAat,
      required this.createdAt,
      this.ontap,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: CustomCard(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ontap!();
        },
        width: double.infinity,
        // height: 72.w,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? "",
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 16.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.date,
                            height: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            DateHelper
                                .convertLaravelDateFormatToDayMonthYearDateFormat(
                                    createdAt!),
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (status == 3) ...[
                    Padding(
                      padding: EdgeInsets.only(right: 19.w),
                      child: ReportHistoryCardStatus(
                        color: AppColors.dark.withOpacity(0.2),
                        text: 'Rejected',
                      ),
                    )
                  ] else if (status == 4) ...[
                    Padding(
                      padding: EdgeInsets.only(right: 19.w),
                      child: ReportHistoryCardStatus(
                        color: AppColors.tintGreen,
                        text: 'Completed',
                      ),
                    )
                  ],
                ],
              ),
              SizedBox(
                height: 30,
              ),
              ReadMoreText(
                description ?? "",
                trimMode: TrimMode.Line,
                trimLines: 2,
                colorClickableText: AppColors.appThem,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
                moreStyle: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.appThem,
                    fontWeight: FontWeight.bold),
                lessStyle: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.appThem,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReportHistoryCardStatus extends StatelessWidget {
  final String? text;
  final Color? color;

  const ReportHistoryCardStatus(
      {super.key, required this.text, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          child: Text(
            text ?? "",
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 13.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300.r), color: color!),
    );
  }
}

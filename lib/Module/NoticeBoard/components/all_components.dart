import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

class NoticeBoardDialogCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final int? status;

  const NoticeBoardDialogCard(
      {super.key,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  AppImages.notice,
                  height: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    title ?? "",
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 18.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            14.h.ph,
            Text(
              description ?? "",
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 14.0,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.dark.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(300),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Text(
                    DateHelper.convertDateFormatToDayMonthYearDateFormat(
                        startDate!),
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 14.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: MyButton(
                width: double.infinity,
                name: "Okay",
                gradient: AppGradients.buttonGradient,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ]),
    );
  }
}

class NoticeboardCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? startDate;
  final Function? onpressed;

  const NoticeboardCard(
      {super.key,
      required this.title,
      this.onpressed,
      required this.description,
      required this.startDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 14.51.h, 16.w, 0),
      child: CustomCard(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            onpressed!();
          },
          width: double.infinity,
          // height: 72.w,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "",
                  style: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 16.0,
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
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
                      color: AppColors.dark,
                      fontWeight: FontWeight.normal),
                  moreStyle: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.appThem,
                      fontWeight: FontWeight.normal),
                  lessStyle: reusableTextStyle(
                      textStyle: GoogleFonts.dmSans(),
                      fontSize: 14.0,
                      color: AppColors.appThem,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          )),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/utils/styles/colors.dart';

import '../../../utils/Constants/images_strings.dart';
import '../../../utils/styles/reuseable_textstyle.dart';

class EventDialog extends StatelessWidget {
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;

  const EventDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.startTime,
      required this.endTime});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Events",
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 18.0,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.bold),
            ),
          ),
          14.h.ph,
          Text(
            'Title',
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          4.h.ph,
          Text(title ?? "",
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: HexColor('#606470'))),
          14.h.ph,
          Text(
            'Description',
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
          4.h.ph,
          Text(description ?? "",
              style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: HexColor('#606470'))),
          20.h.ph,
          Row(
            children: [
              Text(
                'From',
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
              82.w.pw,
              Text(
                'To',
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          10.h.ph,
          Row(
            children: [
              Image.asset(
                AppImages.date2,
                height: 14,
              ),
              11.w.pw,
              Text(
                DateHelper.convertDateFormatToDayMonthYearDateFormat(
                    startDate!),
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: HexColor('#606470')),
              ),
              11.w.pw,
              Image.asset(
                AppImages.date2,
                height: 14,
              ),
              11.w.pw,
              Text(
                  DateHelper.convertDateFormatToDayMonthYearDateFormat(
                      endDate!),
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: HexColor('#606470')))
            ],
          ),
          20.h.ph,
          Row(
            children: [
              Text(
                'From',
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
              82.w.pw,
              Text(
                'To',
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          10.h.ph,
          Row(
            children: [
              Image.asset(
                AppImages.timer,
                height: 14,
              ),
              11.w.pw,
              Text(DateHelper.formatTimeToAMPM(startTime!),
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: HexColor('#606470'))),
              36.w.pw,
              Image.asset(
                AppImages.timer,
                height: 14,
              ),
              11.w.pw,
              Text(DateHelper.formatTimeToAMPM(endTime!),
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: HexColor('#606470'))),
            ],
          ),
          40.h.ph,
          Center(
            child: MyButton(
              gradient: AppGradients.buttonGradient,
              width: 300.w,
              name: 'Okay',
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? startDate;
  final int? index;
  String? image;
  final Function? onTap;

  EventCard(
      {super.key,
      required this.title,
      required this.description,
      required this.startDate,
      required this.index,
      this.onTap,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(14.w, 13.h, 18.w, 0),
        child: CustomCard(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            onTap!();
          },
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        ),
                        Text(
                          DateHelper.convertDateFormatToDayMonthYearDateFormat(
                              startDate!),
                          style: reusableTextStyle(
                              textStyle: GoogleFonts.dmSans(),
                              fontSize: 14.0,
                              color: AppColors.dark,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        showImageDialog(context, image ?? "");
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: image ?? "",
                            width: 50.w,
                            height: 50.w,
                            placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                              color: AppColors.appThem,
                            )),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ],
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
                      fontWeight: FontWeight.normal),
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
        ));
  }

  void showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                alignment: Alignment.topRight,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl, // Small image URL

                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: AppColors.appThem,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

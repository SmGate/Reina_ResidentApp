import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

class PreApproveEntryDialog extends StatelessWidget {
  final String? name;
  final String? description;
  final String? visitortype;
  final String? vechileno;
  final String? mobileno;
  final String? arrivaldate;
  final String? expiryDate;
  final String? arrivaltime;
  final String? cnic;

  const PreApproveEntryDialog(
      {super.key,
      required this.name,
      required this.description,
      required this.visitortype,
      required this.vechileno,
      required this.mobileno,
      required this.arrivaldate,
      required this.arrivaltime,
      this.expiryDate,
      required this.cnic});

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.greyTransparent,
                  borderRadius: BorderRadius.circular(300)),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                child: Text(
                  formatDate(arrivaldate ?? ""),
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
          Row(
            children: [
              Image.asset(
                AppImages.person,
                height: 20,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? "",
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 16.0,
                        color: AppColors.textBlack,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "Vehicle No   ",
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.dark,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        vechileno ?? "",
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                AppImages.cnic,
                height: 16,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "CNIC",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 14,
              ),
              Text(
                cnic ?? "",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                AppImages.call,
                height: 16,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Phone",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 14,
              ),
              Text(
                mobileno ?? "",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                AppImages.timer,
                height: 16,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Arrival Time",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 14,
              ),
              Text(
                arrivaltime ?? "",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                AppImages.date2,
                height: 16,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Arrival Date",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 14,
              ),
              Text(
                formatDate(arrivaldate ?? ""),
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                AppImages.date2,
                height: 16,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Expiry Date",
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 14,
              ),
              Text(
                formatDate(expiryDate ?? ""),
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 14.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: MyButton(
              width: double.infinity,
              onPressed: () {
                Navigator.pop(context);
              },
              name: "Okay",
              gradient: AppGradients.buttonGradient,
            ),
          )
        ],
      ),
    );
  }
}

///////////////
///
Widget MyStatusWidget(
    {required status, required color, double? width, double? height}) {
  return Padding(
    padding: EdgeInsets.only(right: 14.w),
    child: Text(
      status,
      style: reusableTextStyle(
          textStyle: GoogleFonts.dmSans(),
          fontSize: 12.0,
          color: color,
          fontWeight: FontWeight.bold),
    ),
  );
}

String formatDate(String? date) {
  if (date == null || date.isEmpty) return "";
  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  } catch (e) {
    return date;
  }
}

Widget PreApproveEntryCard(
    {required name,
    required checkInTime,
    required checkOutTime,
    required createdAt,
    required updatedAt,
    required arrivalDate,
    required visitorType,
    required status,
    Function? onTap,
    required statusDescription}) {
  return Padding(
      padding: EdgeInsets.fromLTRB(10.w, 13.h, 10.2.w, 0),
      child: CustomCard(
          onTap: () {
            onTap!();
          },
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.greyTransparent,
                        borderRadius: BorderRadius.circular(300)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 5),
                      child: Text(
                        DateHelper
                            .convertLaravelDateFormatToDayMonthYearDateFormat(
                                arrivalDate),
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.person,
                      height: 18,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: reusableTextStyle(
                              textStyle: GoogleFonts.dmSans(),
                              fontSize: 16.0,
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          visitorType,
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
                Row(
                  children: [
                    Image.asset(
                      AppImages.timer,
                      height: 18,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    if (status == 0) ...[
                      PreApproveEntryCardText(
                          heading: 'Created At : ',
                          text: DateHelper.convertTo12HourFormatFromTimeStamp(
                              createdAt)),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: MyStatusWidget(
                            status: statusDescription,
                            color: HexColor('#E85C5C')),
                      )
                    ] else if (status == 1) ...[
                      PreApproveEntryCardText(
                          heading: 'Approved At : ',
                          text: DateHelper.convertTo12HourFormatFromTimeStamp(
                              updatedAt)),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: MyStatusWidget(
                          status: statusDescription,
                          color: HexColor('#48CA46'),
                        ),
                      )
                    ] else if (status == 2) ...[
                      PreApproveEntryCardText(
                          heading: 'Checkin Time : ',
                          text: DateHelper.Hour12formatTime(checkInTime)),
                      Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: MyStatusWidget(
                            status: 'Arrived', color: HexColor('#5DD4B1')),
                      )
                    ] else ...[
                      PreApproveEntryCardText(
                          heading: 'Checkout Time : ',
                          text: DateHelper.Hour12formatTime(checkOutTime)),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: MyStatusWidget(
                          status: 'Departed',
                          color: HexColor('#5A8CED'),
                        ),
                      )
                    ],
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )));
}

class DialogBoxText extends StatelessWidget {
  final String? text;

  const DialogBoxText({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w),
      child: Text(
        text ?? "",
        style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.w300,
            fontSize: 16.sp,
            color: HexColor('#1A1A1A')),
      ),
    );
  }
}

class PreApproveEntryCardText extends StatelessWidget {
  final String? heading;
  final String? text;

  const PreApproveEntryCardText(
      {super.key, required this.heading, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text: heading,
          style: GoogleFonts.ubuntu(
            color: HexColor('#A5AAB7'),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
        TextSpan(
          text: text,
          style: GoogleFonts.ubuntu(
            color: HexColor('#606470'),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import '../../../../Helpers/Date Helper/date_helper.dart';
import '../../../../Widgets/gradient_icon.dart';
import '../../../../utils/styles/colors.dart';
import '../../../../utils/styles/reuseable_textstyle.dart';
import '../../Controller/Admin Reports Controller/admin_reports_controller.dart';

class ComplainCard extends StatelessWidget {
  final int? id;
  final int? index;
  final int? userId;
  final int? subAdminId;
  final String? title;
  final String? icon;
  final String? description;
  final int? status;
  final String? statusDescription;
  final String? updatedAat;
  final String? createdAt;
  final AdminReportsController controller;
  final Function? onpressesd;

  const ComplainCard(
      {super.key,
      required this.id,
      required this.index,
      required this.userId,
      required this.subAdminId,
      required this.title,
      required this.description,
      required this.status,
      required this.statusDescription,
      required this.updatedAat,
      this.icon,
      this.onpressesd,
      required this.createdAt,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        onTap: () {
          onpressesd!();
        },
        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        borderRadius: BorderRadius.circular(12),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientIcon(
                    img: icon ?? "",
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          "$title",
                          style: reusableTextStyle(
                              textStyle: GoogleFonts.dmSans(),
                              fontSize: 16.0,
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImages.date2,
                            height: 16,
                          ),
                          6.w.pw,
                          Text(
                            DateHelper.formatDate(updatedAat!),
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 12.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            width: 30,
                          ),
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
                          ]
                        ],
                      ),
                    ],
                  ),
                ],
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
        ));
  }
}

class ComplainStatusCard extends StatelessWidget {
  final String? statusDescription;
  final Color? color;

  const ComplainStatusCard(
      {super.key, required this.statusDescription, required this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 22.w),
      child: Container(
        child: Center(
            child: Padding(
          padding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          child: Text(
            statusDescription!,
            style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 13.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold),
          ),
        )),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8), color: color),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import '../../../Helpers/Date Helper/date_helper.dart';
import '../../../utils/styles/reuseable_textstyle.dart';
import '../Controller/guest_history_controller.dart';

Widget PreApproveEntryHistoryCard(
    {required String name,
    required int id,
    required String checkOutTime,
    required String updatedAt,
    required String checkInTime,
    required String? cnic,
    required String? vehicleNo,
    final Function? onpressed,
    required GuestHistoryController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: CustomCard(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onpressed!(),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    child: Text(
                      DateHelper
                          .convertLaravelDateFormatToDayMonthYearDateFormat(
                        updatedAt,
                      ),
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
                    height: 20,
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
                            fontSize: 14.0,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            "Vehicle No",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            vehicleNo ?? "",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.cnic,
                    height: 14,
                  ),
                  SizedBox(
                    width: 20,
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
                    width: 10,
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
            ],
          ),
        )),
  );
}

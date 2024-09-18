// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/Module/visitor_details/controller/visitor_details_controller.dart';
import 'package:userapp/Module/visitor_details/model/visitor_details_model.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

class AllVisitors extends StatelessWidget {
  VisitorDetailsController visitorDetailsController;
  AllVisitors({super.key, required this.visitorDetailsController});

  @override
  Widget build(BuildContext context) {
    // var controller = Get.find<VisitorDetailsController>();
    return FutureBuilder<GetAllVisitors>(
      future: visitorDetailsController.getAllVisitors(
          subadminId: visitorDetailsController.user.subadminid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularIndicatorUnderWhiteBox(),
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
              itemCount:
                  visitorDetailsController.visitorDetailsModel.data?.length,
              itemBuilder: (context, index) {
                int lastIndex =
                    visitorDetailsController.visitorDetailsModel.data!.length -
                        1;
                return CustomCard(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    margin: EdgeInsets.only(
                        top: index == 0 ? 20 : 20,
                        left: 20,
                        right: 20,
                        bottom: index == lastIndex ? 20 : 0),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.demoUser,
                                height: 40,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      "${visitorDetailsController.visitorDetailsModel.data![index].name ?? ""}",
                                      style: reusableTextStyle(
                                          textStyle: GoogleFonts.dmSans(),
                                          fontSize: 18.0,
                                          color: AppColors.textBlack,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "CNIC",
                                        style: reusableTextStyle(
                                            textStyle: GoogleFonts.dmSans(),
                                            fontSize: 14.0,
                                            color: AppColors.textBlack,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "${visitorDetailsController.visitorDetailsModel.data![index].cnic ?? ""}",
                                        style: reusableTextStyle(
                                            textStyle: GoogleFonts.dmSans(),
                                            fontSize: 14.0,
                                            color: AppColors.dark,
                                            fontWeight: FontWeight.normal),
                                        overflow: TextOverflow.ellipsis,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                AppImages.house,
                                height: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Address",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 180,
                                child: Text(
                                  "${visitorDetailsController.visitorDetailsModel.data![index].houseaddress ?? ""}",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 14.0,
                                      color: AppColors.dark,
                                      fontWeight: FontWeight.normal),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.person,
                                height: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Visitor Type",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${visitorDetailsController.visitorDetailsModel.data![index].visitortype ?? ""}",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.call2,
                                height: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Mobile",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${visitorDetailsController.visitorDetailsModel.data![index].mobileno ?? ""}",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.stacked_bar_chart_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Status",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${visitorDetailsController.visitorDetailsModel.data![index].statusdescription ?? ""}",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.date_range),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Visit Date",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                DateHelper
                                    .convertDateFormatToDayMonthYearDateFormat(
                                        visitorDetailsController
                                                .visitorDetailsModel
                                                .data![index]
                                                .arrivaldate ??
                                            ""),
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.dark,
                                    fontWeight: FontWeight.normal),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ));
              });
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        } else {
          return Center(child: Text("No Data"));
        }
      },
    );
  }
}

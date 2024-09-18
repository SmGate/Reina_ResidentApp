// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Module/All_Bills/Controller/monthly_bills_controller.dart';
import 'package:userapp/Module/All_Bills/Model/BillModel.dart';
import 'package:userapp/Module/All_Bills/components/paid_bill_details.dart';
import 'package:userapp/Module/All_Bills/components/partially_paid_bill.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

import '../components/unpaid_bill_details.dart';

class AllBills extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MonthlyBillsController>(
        init: MonthlyBillsController(),
        builder: (controller) {
          return SafeArea(
              child: WillPopScope(
            onWillPop: () async {
              Get.offNamed(homescreen, arguments: controller.userdata);

              return true;
            },
            child: Scaffold(
                backgroundColor: AppColors.background,
                body: Column(
                  children: [
                    MyBackButton(
                      text: 'Bills',
                      onTap: () {
                        Get.offNamed(homescreen,
                            arguments: controller.userdata);
                      },
                    ),
                    Expanded(
                        child: FutureBuilder<BillModel>(
                      future: controller.monthlyBillsApi(
                          residentId: controller.resident.residentid!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularIndicatorUnderWhiteBox(),
                          );
                        } else if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: ListView(
                              children: [
                                /////////////  unpaid
                                SizedBox(
                                    height: 400,
                                    child: Container(
                                      // color: Colors.red,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: headings(
                                                  text: "Unpaid Bills")),
                                          snapshot.data?.data?.unpaid?.length ==
                                                  0
                                              ? Center(
                                                  child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 140),
                                                    child: Text(
                                                      "No Unpaid Bills Found",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                ))
                                              : Expanded(
                                                  child: ListView.builder(
                                                      itemCount: controller
                                                          .billModel
                                                          .data
                                                          ?.unpaid
                                                          ?.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return CustomCard(
                                                          boxShadow:
                                                              BoxShadow(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top:
                                                                      index == 0
                                                                          ? 10
                                                                          : 10,
                                                                  left: 10,
                                                                  right: 10,
                                                                  bottom: 10),
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 20,
                                                                        bottom:
                                                                            20,
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                child: Row(
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Specific Type",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.textBlack,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          "Description",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.textBlack,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          "Status",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.textBlack,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width: 60,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          controller.billModel.data?.unpaid![index].specificType ??
                                                                              "",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.dark,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Text(
                                                                          controller.billModel.data?.unpaid![index].description ??
                                                                              "",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.dark,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Text(
                                                                          controller.billModel.data?.unpaid![index].status ??
                                                                              "",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.dark,
                                                                              fontWeight: FontWeight.normal),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            10),
                                                                child: Divider(
                                                                  color: AppColors
                                                                      .yellow,
                                                                  thickness: 2,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            20,
                                                                        bottom:
                                                                            20),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomRight,
                                                                  child:
                                                                      MyButton(
                                                                    width: 100,
                                                                    fontSize:
                                                                        10,
                                                                    border: 8,
                                                                    name:
                                                                        "Details",
                                                                    gradient:
                                                                        AppGradients
                                                                            .buttonGradient,
                                                                    onPressed:
                                                                        () {
                                                                      controller.billId = controller
                                                                          .billModel
                                                                          .data
                                                                          ?.unpaid![
                                                                              index]
                                                                          .id;

                                                                      controller.payableAmount = controller
                                                                          .billModel
                                                                          .data
                                                                          ?.unpaid![
                                                                              index]
                                                                          .balance;

                                                                      print(
                                                                          "bill id is${controller.billId}");
                                                                      Get.to(() => UnpaidPaidBillDetails(
                                                                          user: controller
                                                                              .userdata,
                                                                          title:
                                                                              "Unpaid Bill Detail",
                                                                          model: controller
                                                                              .billModel,
                                                                          index:
                                                                              index));
                                                                    },
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      }))
                                        ],
                                      ),
                                    )),

                                /////////////  paid
                                Divider(),
                                SizedBox(
                                    height: 400,
                                    child: Container(
                                      // color: Colors.blue,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: headings(
                                                  text: "Paid Bills History")),
                                          snapshot.data?.data?.paid?.length == 0
                                              ? Center(
                                                  child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 140),
                                                    child: Text(
                                                      "No Paid Bills Found",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                ))
                                              : Expanded(
                                                  child: ListView.builder(
                                                      itemCount: controller
                                                          .billModel
                                                          .data
                                                          ?.paid
                                                          ?.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return CustomCard(
                                                          boxShadow:
                                                              BoxShadow(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top:
                                                                      index == 0
                                                                          ? 10
                                                                          : 10,
                                                                  left: 10,
                                                                  right: 10,
                                                                  bottom: 10),
                                                          width:
                                                              double.infinity,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 20,
                                                                    bottom: 20,
                                                                    left: 20,
                                                                    right: 20),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Bill Specific Type",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.textBlack,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          "Description",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.textBlack,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          "Status",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.textBlack,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width: 60,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          controller.billModel.data?.paid![index].specificType ??
                                                                              "",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.dark,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Text(
                                                                          controller.billModel.data?.paid![index].description ??
                                                                              "",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.dark,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Text(
                                                                          controller.billModel.data?.paid![index].status ??
                                                                              "",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.dark,
                                                                              fontWeight: FontWeight.normal),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      bottom:
                                                                          10),
                                                                  child:
                                                                      Divider(
                                                                    color: AppColors
                                                                        .yellow,
                                                                    thickness:
                                                                        2,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              20,
                                                                          top:
                                                                              10),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child:
                                                                        MyButton(
                                                                      border: 8,
                                                                      width:
                                                                          120,
                                                                      name:
                                                                          "Details",
                                                                      gradient:
                                                                          AppGradients
                                                                              .buttonGradient,
                                                                      onPressed:
                                                                          () {
                                                                        Get.to(() => PaidBillDetails(
                                                                            user: controller
                                                                                .userdata,
                                                                            title:
                                                                                "Paid Bill Detail",
                                                                            model:
                                                                                controller.billModel,
                                                                            index: index));
                                                                      },
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }))
                                        ],
                                      ),
                                    )),

////////// PARTIALLY PAID
                                Divider(),

                                SizedBox(
                                    height: 400,
                                    child: Container(
                                      // color: Colors.red,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: headings(
                                                  text:
                                                      "Partially Paid Bills")),
                                          snapshot.data?.data?.partiallypaid
                                                      ?.length ==
                                                  0
                                              ? Center(
                                                  child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 140),
                                                    child: Text(
                                                      "No Partially Bills Found",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                ))
                                              : Expanded(
                                                  child: ListView.builder(
                                                      itemCount: controller
                                                          .billModel
                                                          .data
                                                          ?.partiallypaid
                                                          ?.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return CustomCard(
                                                          boxShadow:
                                                              BoxShadow(),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top:
                                                                      index == 0
                                                                          ? 10
                                                                          : 10,
                                                                  left: 10,
                                                                  right: 10,
                                                                  bottom: 10),
                                                          color: AppColors
                                                              .globalWhite,
                                                          width:
                                                              double.infinity,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 20,
                                                                    bottom: 20,
                                                                    left: 20,
                                                                    right: 20),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Specific Type",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.textBlack,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          "Description",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.textBlack,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Text(
                                                                          "Status",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.textBlack,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width: 60,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          controller.billModel.data?.partiallypaid![index].specificType ??
                                                                              "",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.dark,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Text(
                                                                          controller.billModel.data?.partiallypaid![index].description ??
                                                                              "",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.dark,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Text(
                                                                          controller.billModel.data?.partiallypaid![index].status ??
                                                                              "",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 14.0,
                                                                              color: AppColors.dark,
                                                                              fontWeight: FontWeight.normal),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      bottom:
                                                                          10),
                                                                  child:
                                                                      Divider(
                                                                    color: AppColors
                                                                        .yellow,
                                                                    thickness:
                                                                        2,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              20,
                                                                          top:
                                                                              10),
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child:
                                                                        MyButton(
                                                                      border: 8,
                                                                      width:
                                                                          120,
                                                                      name:
                                                                          "Details",
                                                                      gradient:
                                                                          AppGradients
                                                                              .buttonGradient,
                                                                      onPressed:
                                                                          () {
                                                                        Get.to(() => PartiallyPaidBill(
                                                                            user: controller
                                                                                .userdata,
                                                                            title:
                                                                                "Partially Paid Bill Detail",
                                                                            model:
                                                                                controller.billModel,
                                                                            index: index));
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }))
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text("${snapshot.error}"));
                        } else {
                          return Center(child: Text("No Data"));
                        }
                      },
                    ))
                  ],
                )),
          ));
        });
  }
}

class MyBillWidget extends StatelessWidget {
  final String name;
  final String description;

  const MyBillWidget({required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textAlign: TextAlign.start,
                name,
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 16.0,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                textAlign: TextAlign.start,
                description,
                style: reusableTextStyle(
                    textStyle: GoogleFonts.dmSans(),
                    fontSize: 16.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget headings({String? text}) {
  return Padding(
    padding: EdgeInsets.only(left: 10.w),
    child: Column(
      children: [
        Text(
          text ?? "",
          style: reusableTextStyle(
              textStyle: GoogleFonts.dmSans(),
              fontSize: 18.0,
              color: AppColors.textBlack,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/Module/Gatekeepers/controller/all_gatekeepers_controller.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';
import '../../../utils/Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/my_back_button.dart';

class AllGatekeeprs extends StatelessWidget {
  const AllGatekeeprs({super.key});

  @override
  Widget build(BuildContext context) {
    var allGatekeepersController = Get.find<AllGatekeeperController>();
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: allGatekeepersController.userdata);

        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.background,
            body: FutureBuilder(
              future: allGatekeepersController.getGateKeepers(
                  subadminId: allGatekeepersController.userdata.subadminid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularIndicatorUnderWhiteBox());
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      MyBackButton(
                        text: 'Gate Keepers',
                        onTap: () {
                          Get.offNamed(homescreen,
                              arguments: allGatekeepersController.userdata);
                        },
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: allGatekeepersController
                                  .getAllGateKeepersModel.data?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: index == 0 ? 20 : 10),
                                  child: CustomCard(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            300),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          "${Api.imageBaseUrl}${allGatekeepersController.getAllGateKeepersModel.data![index].image ?? ""}",
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              AppColors.appThem,
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "${allGatekeepersController.getAllGateKeepersModel.data![index].firstname ?? ""} ${allGatekeepersController.getAllGateKeepersModel.data![index].lastname ?? ""}",
                                                  style: reusableTextStyle(
                                                      textStyle:
                                                          GoogleFonts.dmSans(),
                                                      fontSize: 16.0,
                                                      color:
                                                          AppColors.textBlack,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: () async {
                                                    final phoneNumber =
                                                        allGatekeepersController
                                                                .getAllGateKeepersModel
                                                                .data![index]
                                                                .mobileno ??
                                                            "";

                                                    allGatekeepersController
                                                            .uri =
                                                        Uri.parse(
                                                            "tel://${phoneNumber}");

                                                    try {
                                                      await launchUrl(
                                                          allGatekeepersController
                                                              .uri!);
                                                      allGatekeepersController
                                                          .uri = null;
                                                    } catch (e) {
                                                      myToast(
                                                          msg: e.toString(),
                                                          isNegative: true);
                                                    }
                                                  },
                                                  child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: AppColors
                                                              .greyTransparent),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Image.asset(
                                                          AppImages.call,
                                                        ),
                                                      )),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Image.asset(
                                                      AppImages.call2,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Image.asset(
                                                      AppImages.cnic,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Image.asset(
                                                      AppImages.gateNo,
                                                      height: 20,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Phone Number",
                                                      style: reusableTextStyle(
                                                          textStyle: GoogleFonts
                                                              .dmSans(),
                                                          fontSize: 14.0,
                                                          color: AppColors
                                                              .textBlack,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "CNIC",
                                                      style: reusableTextStyle(
                                                          textStyle: GoogleFonts
                                                              .dmSans(),
                                                          fontSize: 14.0,
                                                          color: AppColors
                                                              .textBlack,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Gate No",
                                                      style: reusableTextStyle(
                                                          textStyle: GoogleFonts
                                                              .dmSans(),
                                                          fontSize: 14.0,
                                                          color: AppColors
                                                              .textBlack,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      allGatekeepersController
                                                              .getAllGateKeepersModel
                                                              .data![index]
                                                              .mobileno ??
                                                          "",
                                                      style: reusableTextStyle(
                                                          textStyle: GoogleFonts
                                                              .dmSans(),
                                                          fontSize: 14.0,
                                                          color: AppColors
                                                              .textBlack,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      allGatekeepersController
                                                              .getAllGateKeepersModel
                                                              .data![index]
                                                              .cnic ??
                                                          "",
                                                      style: reusableTextStyle(
                                                          textStyle: GoogleFonts
                                                              .dmSans(),
                                                          fontSize: 14.0,
                                                          color: AppColors
                                                              .textBlack,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      allGatekeepersController
                                                              .getAllGateKeepersModel
                                                              .data![index]
                                                              .gateno ??
                                                          "",
                                                      style: reusableTextStyle(
                                                          textStyle: GoogleFonts
                                                              .dmSans(),
                                                          fontSize: 14.0,
                                                          color: AppColors
                                                              .textBlack,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                );
                              }))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else {
                  return Center(child: Text("No Data"));
                }
              },
            )),
      ),
    );
  }
}

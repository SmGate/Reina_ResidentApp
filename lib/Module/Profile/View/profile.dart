// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Module/Profile/Controller/profile_controller.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

import '../../../utils/Constants/api_routes.dart';
import '../../../utils/Constants/constants.dart';
import '../../../Helpers/Date Helper/date_helper.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/my_back_button.dart';
import '../../Chat Screens/Neighbour Chat Screen/Controller/neighbour_chat_screen_controller.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              await Get.offNamed(neighbourchatscreen, arguments: [
                controller.userdata,
                //Login User
                controller.resident,
                // Resident Details
                controller.chatNeighbours,
                controller.chatRoomId,
                ChatTypes.NeighbourChat.toString().split('.').last,
                // Chat User
              ]);

              return false;
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.background,
                body: Column(
                  children: [
                    MyBackButton(
                        text: 'Profile',
                        onTap: () {
                          if (controller.chatType == "NeighbourChat") {
                            Get.offNamed(neighbourchatscreen, arguments: [
                              controller.userdata,
                              //Login User
                              controller.resident,
                              // Resident Details
                              controller.chatNeighbours,
                              controller.chatRoomId,
                              ChatTypes.NeighbourChat.toString()
                                  .split('.')
                                  .last,
                              // Chat User
                            ]);
                          } else if (controller.chatType == "MarketPlaceChat") {
                            Get.offNamed(neighbourchatscreen, arguments: [
                              controller.userdata,
                              //Login User
                              controller.resident,
                              // Resident Details
                              controller.chatNeighbours,
                              // chat room id
                              controller.chatRoomId,
                              ChatTypes.MarketPlaceChat.toString()
                                  .split('.')
                                  .last, // Chat User
                            ]);
                          }
                        }),
                    20.h.ph,
                    CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                            width: 200.w,
                            height: 200.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.appThem),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain),
                            )),
                        imageUrl: Api.imageBaseUrl +
                            controller.chatNeighbours.image.toString(),
                        placeholder: (context, url) => Column(
                              children: [
                                CircularProgressIndicator(
                                  color: AppColors.appThem,
                                ),
                              ],
                            ),
                        errorWidget: (context, url, error) => Container(
                            width: 200.w,
                            height: 200.w,
                            child: Icon(Icons.error),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.appThem),
                              shape: BoxShape.circle,
                            ))),
                    20.h.ph,
                    Text(
                      "${controller.chatNeighbours.firstname.toString()} ${controller.chatNeighbours.lastname.toString()}",
                      style: reusableTextStyle(
                          textStyle: GoogleFonts.dmSans(),
                          fontSize: 20.0,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, top: 10.h),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.timer,
                            height: 20,
                          ),
                          20.w.pw,
                          Text(
                            "Joined At",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.bold),
                          ),
                          5.w.pw,
                          Text(
                            "${DateHelper.laravelDateToFormattedDate(controller.chatNeighbours.createdAt.toString())}",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, top: 10.h),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.person,
                            height: 20,
                          ),
                          20.w.pw,
                          Text(
                            "Username",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.bold),
                          ),
                          5.w.pw,
                          Text(
                            "${controller.chatNeighbours.username}",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, top: 10.h),
                      child: Row(
                        children: [
                          Icon(Icons.home_work_outlined,
                              color: AppColors.textBlack),
                          20.w.pw,
                          Text(
                            "Property Type",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.bold),
                          ),
                          5.w.pw,
                          Text(
                            "${controller.chatNeighbours.propertytype}",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, top: 10.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_history_outlined,
                            color: AppColors.textBlack,
                          ),
                          20.w.pw,
                          Text(
                            "Residental Type",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.bold),
                          ),
                          5.w.pw,
                          Text(
                            "${controller.chatNeighbours.residenttype}",
                            style: reusableTextStyle(
                                textStyle: GoogleFonts.dmSans(),
                                fontSize: 14.0,
                                color: AppColors.dark,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    20.h.ph,
                    if (controller.isLoading == false) ...[
                      if (controller.blockedUser.data == null) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: MyButton(
                            width: double.infinity,
                            gradient: AppGradients.buttonGradient,
                            name: 'Block',
                            loading: controller.isLoading,
                            onPressed: () {
                              if (!controller.isLoading) {
                                controller.blockUserApi(
                                    userId: controller.userdata.userId,
                                    token: controller.userdata.bearerToken!,
                                    chatRoomId: controller.chatRoomId,
                                    blockedUserid:
                                        controller.chatNeighbours.residentid);
                              }
                            },
                          ),
                        ),
                      ] else if (controller.blockedUser.data!.blockeduserid ==
                          controller.userdata.userId) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: MyButton(
                            gradient: AppGradients.buttonGradient,
                            width: double.infinity,
                            name: 'Block',
                            loading: controller.isLoading,
                            onPressed: () {
                              if (!controller.isLoading) {
                                controller.blockUserApi(
                                    userId: controller.userdata.userId,
                                    token: controller.userdata.bearerToken!,
                                    chatRoomId: controller.chatRoomId,
                                    blockedUserid:
                                        controller.chatNeighbours.residentid);
                              }
                            },
                          ),
                        ),
                      ] else if (controller.blockedUser.data!.userid ==
                          controller.userdata.userId) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: MyButton(
                            gradient: AppGradients.buttonGradient,
                            width: double.infinity,
                            name: 'Unblock',
                            onPressed: () {
                              controller.unBlockUserApi(
                                  token: controller.userdata.bearerToken!,
                                  chatRoomId: controller.chatRoomId,
                                  blockedUserid: controller
                                      .blockedUser.data!.blockeduserid);
                            },
                          ),
                        )
                      ]
                    ],
                    30.h.ph,
                  ],
                ),
              ),
            ),
          );
        });
  }
}

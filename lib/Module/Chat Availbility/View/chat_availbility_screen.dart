// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';

import '../../../utils/Constants/constants.dart';
import '../../../Helpers/Date Helper/date_helper.dart';
import '../../../Widgets/empty_list.dart';
import '../../../utils/styles/reuseable_textstyle.dart';
import '../../Chat Screens/Neighbour Chat Screen/Controller/neighbour_chat_screen_controller.dart';
import '../Controller/chat_availibility_controller.dart';

class ChatAvailbilityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatAvailbilityController>(
        init: ChatAvailbilityController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              Get.offNamed(homescreen, arguments: controller.userdata);
              return true;
            },
            child: Center(
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: AppColors.background,
                  body: Column(
                    children: [
                      MyBackButton(
                        text: 'Community Members',
                        widget: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: PopupMenuButton<String>(
                            color: AppColors.globalWhite,
                            surfaceTintColor: AppColors.globalWhite,
                            itemBuilder: (BuildContext context) {
                              return <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          backgroundColor:
                                              AppColors.globalWhite,
                                          surfaceTintColor:
                                              AppColors.globalWhite,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          child: Container(
                                            width: 300.0,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20, bottom: 10),
                                                  child: Text(
                                                    "Chat Visibility",
                                                    style: reusableTextStyle(
                                                        textStyle: GoogleFonts
                                                            .dmSans(),
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColors.textBlack,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Obx(() {
                                                    return CheckboxListTile(
                                                      activeColor: AppColors
                                                          .appThem, // Use your primary color here
                                                      title: Text(
                                                        "Anonymous",
                                                        style: reusableTextStyle(
                                                            textStyle:
                                                                GoogleFonts
                                                                    .dmSans(),
                                                            fontSize: 16.0,
                                                            color: AppColors
                                                                .textBlack,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      value: controller
                                                          .chatAvailibilityStatus
                                                          .value,
                                                      onChanged: (val) {
                                                        controller
                                                            .chatAvailibilityStatus
                                                            .value = val!;

                                                        controller.visibility =
                                                            val
                                                                ? "anonymous"
                                                                : "none";

                                                        controller
                                                            .updateChatVisibilityApi(
                                                          residentId: controller
                                                              .userdata.userId,
                                                          token: controller
                                                              .userdata
                                                              .bearerToken!,
                                                          visibility: controller
                                                              .visibility,
                                                        );
                                                      },
                                                    );
                                                  }),
                                                ),
                                                // Add any other dialog buttons or actions here if needed
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  value: 'Visibility',
                                  child: Text('Visibility'),
                                ),
                              ];
                            },
                          ),
                        ),
                        onTap: () {
                          Get.offNamed(homescreen,
                              arguments: controller.userdata);
                        },
                      ),
                      20.h.ph,
                      Expanded(
                        child: FutureBuilder(
                            future: controller.viewChatNeighbours(
                                subadminid: controller.resident.subadminid),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.data.length > 1) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return (snapshot.data.data[index]
                                                  .residentid ==
                                              controller.userdata.userId)
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: 10,
                                                  bottom: 10),
                                              child: CustomCard(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                width: double.infinity,
                                                color: AppColors.globalWhite,
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .globalWhite,
                                                                surfaceTintColor:
                                                                    AppColors
                                                                        .globalWhite,
                                                                content: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        CachedNetworkImage(
                                                                          imageBuilder: (context, imageProvider) =>
                                                                              Container(
                                                                            width:
                                                                                50.w,
                                                                            height:
                                                                                50.w,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                                            ),
                                                                          ),
                                                                          imageUrl:
                                                                              Api.imageBaseUrl + snapshot.data.data[index].image.toString(),
                                                                          placeholder: (context, url) =>
                                                                              CircularProgressIndicator(
                                                                            color:
                                                                                AppColors.appThem,
                                                                          ),
                                                                          errorWidget: (context, url, error) =>
                                                                              Container(
                                                                            width:
                                                                                50.w,
                                                                            height:
                                                                                50.w,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: AppColors.appThem,
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              20,
                                                                        ),
                                                                        Text(
                                                                          "${snapshot.data!.data[index].firstname.toString()} ${snapshot.data!.data[index].lastname.toString()}",
                                                                          style: reusableTextStyle(
                                                                              textStyle: GoogleFonts.dmSans(),
                                                                              fontSize: 16.0,
                                                                              color: AppColors.textBlack,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "Property Type",
                                                                              style: reusableTextStyle(textStyle: GoogleFonts.dmSans(), fontSize: 16.0, color: AppColors.textBlack, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              "Role",
                                                                              style: reusableTextStyle(textStyle: GoogleFonts.dmSans(), fontSize: 16.0, color: AppColors.textBlack, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              "Join",
                                                                              style: reusableTextStyle(textStyle: GoogleFonts.dmSans(), fontSize: 16.0, color: AppColors.textBlack, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              30,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              snapshot.data!.data[index].propertytype.toString(),
                                                                              style: reusableTextStyle(textStyle: GoogleFonts.dmSans(), fontSize: 16.0, color: AppColors.textBlack, fontWeight: FontWeight.normal),
                                                                            ),
                                                                            Text(
                                                                              snapshot.data!.data[index].rolename.toString(),
                                                                              style: reusableTextStyle(textStyle: GoogleFonts.dmSans(), fontSize: 16.0, color: AppColors.textBlack, fontWeight: FontWeight.normal),
                                                                            ),
                                                                            Text(
                                                                              DateHelper.laravelDateToFormattedDate(snapshot.data!.data[index].createdAt.toString()),
                                                                              style: reusableTextStyle(textStyle: GoogleFonts.dmSans(), fontSize: 16.0, color: AppColors.textBlack, fontWeight: FontWeight.normal),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Center(
                                                                      child:
                                                                          MyButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        name:
                                                                            "Okay",
                                                                        gradient:
                                                                            AppGradients.buttonGradient,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ));
                                                },
                                                child: ListTile(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: index == 0
                                                              ? 10
                                                              : 5,
                                                          bottom: 5),
                                                  leading: CachedNetworkImage(
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      width: 60.w,
                                                      height: 60.w,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    imageUrl: Api.imageBaseUrl +
                                                        snapshot.data
                                                            .data[index].image
                                                            .toString(),
                                                    placeholder:
                                                        (context, url) =>
                                                            Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            AppColors.appThem,
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Container(
                                                      width: 60.w,
                                                      height: 60.w,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.appThem,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ),
                                                  title: Text(
                                                    snapshot.data.data[index]
                                                            .firstname +
                                                        ' ' +
                                                        snapshot
                                                            .data
                                                            .data[index]
                                                            .lastname,
                                                    style: reusableTextStyle(
                                                        textStyle: GoogleFonts
                                                            .dmSans(),
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColors.textBlack,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  trailing: GestureDetector(
                                                    onTap: () async {
                                                      if (snapshot
                                                              .data
                                                              .data[index]
                                                              .visibility ==
                                                          'anonymous') {
                                                        myToast(
                                                            msg:
                                                                "You can't chat with this user because their chat privacy is set to private");
                                                      } else {
                                                        final chatRoomModel = await controller
                                                            .createChatRoomApi(
                                                                token: controller
                                                                    .userdata
                                                                    .bearerToken!,
                                                                userid: controller
                                                                    .userdata
                                                                    .userId!,
                                                                chatUserId: snapshot
                                                                    .data
                                                                    .data[index]
                                                                    .residentid);

                                                        Get.offNamed(
                                                            neighbourchatscreen,
                                                            arguments: [
                                                              controller
                                                                  .userdata,
                                                              //Login User
                                                              controller
                                                                  .resident,
                                                              // Resident Details
                                                              snapshot.data
                                                                  .data[index],

                                                              // chat room id
                                                              chatRoomModel
                                                                  .data!
                                                                  .first
                                                                  .id,
                                                              ChatTypes.NeighbourChat
                                                                      .toString()
                                                                  .split('.')
                                                                  .last,
                                                              // Chat User
                                                            ]);
                                                      }
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 20),
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .greyTransparent,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Image.asset(
                                                          AppImages.message,
                                                          height: 20,
                                                          // color: (snapshot
                                                          //             .data
                                                          //             .data[
                                                          //                 index]
                                                          //             .visibility ==
                                                          //         'anonymous')
                                                          //     ? Colors.grey
                                                          //     : primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ));
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: EmptyList(
                                      name: 'No Neighbour Exists.',
                                    ),
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return Icon(Icons.error_outline);
                              } else {
                                return Center(
                                    child: CircularIndicatorUnderWhiteBox());
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';
import '../../../../Routes/set_routes.dart';
import '../../../../Widgets/empty_list.dart';
import '../../../../Widgets/my_button.dart';
import '../Controller/neighbour_chat_screen_controller.dart';

class NeighbourChatScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NeighbourChatScreenController>(
        init: NeighbourChatScreenController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              if (controller.chatType == "NeighbourChat") {
                Get.offNamed(chatavailbilityscreen,
                    arguments: [controller.user, controller.resident]);
              } else if (controller.chatType == "MarketPlaceChat") {
                Get.offNamed(marketPlaceScreen,
                    arguments: [controller.user, controller.resident]);
              }
              return true;
            },
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.background,
                body: Column(
                  children: [
                    Container(
                      height: 70.h,
                      // color: primaryColor,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        AppColors.globalWhite,
                        AppColors.gradientDark
                      ])),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Row(
                          children: [
                            15.w.pw,
                            Container(
                              margin:
                                  EdgeInsets.only(left: 14, top: 5, bottom: 5),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: AppColors.gradientDark,
                                  borderRadius: BorderRadius.circular(12)),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                  ),
                                  color: AppColors.textBlack,
                                  onPressed: () {
                                    if (controller.chatType ==
                                        "NeighbourChat") {
                                      Get.offNamed(chatavailbilityscreen,
                                          arguments: [
                                            controller.user,
                                            controller.resident
                                          ]);
                                    } else if (controller.chatType ==
                                        "MarketPlaceChat") {
                                      Get.offNamed(marketPlaceScreen,
                                          arguments: [
                                            controller.user,
                                            controller.resident
                                          ]);
                                    }
                                  }),
                            ),
                            15.w.pw,
                            CachedNetworkImage(
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                        width: 36.w,
                                        height: 36.w,
                                        decoration: BoxDecoration(
                                            image:
                                                DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.contain),
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 1.5))),
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
                                    width: 30.w,
                                    height: 30.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.appThem,
                                        border: Border.all(
                                            color: AppColors.appThem,
                                            width: 1.5)))),
                            10.w.pw,
                            Text(
                              controller.chatNeighbours.firstname.toString() +
                                  ' ' +
                                  controller.chatNeighbours.lastname.toString(),
                              style: reusableTextStyle(
                                  textStyle: GoogleFonts.dmSans(),
                                  fontSize: 20.0,
                                  color: AppColors.textBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            10.w.pw,
                            Spacer(),
                            PopupMenuButton<String>(
                              color: AppColors.globalWhite,
                              surfaceTintColor: AppColors.globalWhite,
                              onSelected: (value) {
                                // Handle menu item selection here
                                if (value == 'profile') {
                                  Get.offNamed(profile, arguments: [
                                    controller.user,
                                    controller.resident,
                                    controller.chatNeighbours,
                                    controller.chatRoomId,
                                    controller.chatType
                                  ]);
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: 'profile',
                                    child: Text('Profile'),
                                  ),
                                ];
                              },
                            ),
                            10.w.pw,
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('chats')
                                .where('chatroomid',
                                    isEqualTo: controller.chatRoomId)
                                .orderBy('timestamp', descending: true)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!.docs;

                                if (data.length == 0) {
                                  return Center(
                                    child: EmptyList(
                                        name:
                                            "Chat away! Your conversation starts here.. 😊 ."),
                                  );
                                }
                                return ListView.builder(
                                  reverse: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    bool isSameDate = false;
                                    String newDate = '';

                                    if (index == 0 && data.length == 1) {
                                      newDate =
                                          DateHelper.groupMessageDateAndTime(
                                                  data[index]['timestamp']
                                                      .toString())
                                              .toString();
                                    } else if (index == data.length - 1) {
                                      newDate =
                                          DateHelper.groupMessageDateAndTime(
                                                  data[index]['timestamp']
                                                      .toString())
                                              .toString();
                                    } else {
                                      final DateTime date =
                                          DateHelper.returnDateAndTimeFormat(
                                              data[index + 1]['timestamp']
                                                  .toString());

                                      final DateTime prevDate =
                                          DateHelper.returnDateAndTimeFormat(
                                              data[index]['timestamp']
                                                  .toString());

                                      isSameDate =
                                          date.isAtSameMomentAs(prevDate);

                                      if (kDebugMode) {
                                        print("$date $prevDate $isSameDate");
                                      }

                                      newDate = isSameDate
                                          ? ''
                                          : DateHelper.groupMessageDateAndTime(
                                                  data[index]['timestamp']
                                                      .toString())
                                              .toString();
                                    }
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      child: Column(
                                        crossAxisAlignment: data[index]
                                                    ['residentid']! ==
                                                controller.user.userId
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                        children: [
                                          if (newDate.isNotEmpty)
                                            Center(
                                                child: Column(
                                              children: [
                                                10.h.ph,
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .greyTransparent
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        newDate,
                                                        style: reusableTextStyle(
                                                            textStyle:
                                                                GoogleFonts
                                                                    .dmSans(),
                                                            fontSize: 14.0,
                                                            color: AppColors
                                                                .textBlack,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )),
                                              ],
                                            )),
                                          Container(
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 10.w,
                                                  right: 10.w,
                                                ),
                                                child: Column(
                                                  children: [
                                                    10.h.ph,
                                                    Text(
                                                      data[index]['message']
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        letterSpacing: 0.4,
                                                        color: data[index][
                                                                    'residentid']! ==
                                                                controller
                                                                    .user.userId
                                                            ? Colors.black
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                    4.h.ph,
                                                    Text(
                                                      DateHelper.messageTime(
                                                          data[index]
                                                                  ['timestamp']
                                                              .toString()),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 10.sp,
                                                          color: Colors.black),
                                                    ),
                                                    4.h.ph,
                                                  ],
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                )),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                color: data[index]
                                                            ['residentid']! ==
                                                        controller.user.userId
                                                    ? AppColors.chat
                                                    : AppColors.globalWhite),
                                            margin: EdgeInsets.all(4),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text(snapshot.stackTrace.toString());
                              } else {
                                return CircularIndicatorUnderWhiteBox();
                              }
                            })),
                    10.h.ph,
                    if (controller.isLoading == false) ...[
                      if (controller.blockedUser.data == null) ...[
                        Row(
                          children: [
                            7.w.pw,
                            SizedBox(
                              width: 24.w,
                              height: 24.w,
                            ),
                            7.w.pw,
                            SizedBox(
                              width: 292.w,
                              height: 52.w,
                              child: TextFormField(
                                maxLines: null,
                                controller: controller.msg,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 16.13.w,
                                    ),
                                    hintText: "Type your message",
                                    hintStyle: reusableTextStyle(
                                        textStyle: GoogleFonts.dmSans(),
                                        fontSize: 14.0,
                                        color: AppColors.textBlack,
                                        fontWeight: FontWeight.bold),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.appThem),
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.appThem),
                                        borderRadius:
                                            BorderRadius.circular(8.r))),
                              ),
                            ),
                            7.w.pw,
                            GestureDetector(
                                onTap: () async {
                                  if (controller.msg.text.isNotEmpty) {
                                    try {
                                      // Get a reference to the Firestore collection
                                      CollectionReference chats =
                                          FirebaseFirestore.instance
                                              .collection('chats');

                                      // Add a new document with a generated ID
                                      chats.add({
                                        'residentid':
                                            controller.resident.residentid!,
                                        'message': controller.msg.text,
                                        'chatroomid': controller.chatRoomId,
                                        "type": "message",
                                        'timestamp': DateTime.now()
                                            .microsecondsSinceEpoch,
                                      });

                                      print('Data added successfully');
// 'data': {'type': chatType, 'data': myData, 'chatroomid': chatRoomId},
                                      controller.sendNotification(
                                          chatType: controller.chatType,
                                          chatRoomId: controller.chatRoomId,
                                          myData: controller.chatNeighbours
                                              .toJson(),
                                          message:
                                              controller.msg.text.toString(),
                                          name: controller.user.firstName
                                                  .toString() +
                                              ' ' +
                                              controller.user.lastName
                                                  .toString(),
                                          fcmToken: controller
                                              .chatNeighbours.fcmtoken);
                                      controller.msg.clear();
                                    } catch (error) {
                                      print('Error adding data: $error');
                                    }
                                  }
                                },
                                child: Icon(
                                  Icons.send,
                                  color: AppColors.appThem,
                                )),
                            5.22.w.pw
                          ],
                        )
                      ] else if (controller.blockedUser.data!.blockeduserid ==
                          controller.user.userId) ...[
                        Text(
                          "Communication with ${controller.chatNeighbours.firstname.toString() + ' ' + controller.chatNeighbours.lastname.toString()} is no longer possible.",
                          style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: HexColor('#4D4D4D')),
                        )
                      ] else if (controller.blockedUser.data!.userid ==
                          controller.user.userId) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: MyButton(
                            width: double.infinity,
                            name: 'Unblock',
                            onPressed: () {
                              controller.unBlockUserApi(
                                  chatRoomId: controller.chatRoomId,
                                  token: controller.user.bearerToken!,
                                  blockedUserid: controller
                                      .blockedUser.data!.blockeduserid);
                            },
                          ),
                        )
                      ] else ...[
                        Row(
                          children: [
                            7.w.pw,
                            SizedBox(
                              width: 24.w,
                              height: 24.w,
                            ),
                            7.w.pw,
                            SizedBox(
                              width: 292.w,
                              height: 52.w,
                              child: TextFormField(
                                maxLines: null,
                                controller: controller.msg,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 16.13.w,
                                    ),
                                    hintText: "Type your message",
                                    hintStyle: reusableTextStyle(
                                        textStyle: GoogleFonts.dmSans(),
                                        fontSize: 14.0,
                                        color: AppColors.textBlack,
                                        fontWeight: FontWeight.bold),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.appThem),
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.appThem),
                                        borderRadius:
                                            BorderRadius.circular(8.r))),
                              ),
                            ),
                            7.w.pw,
                            GestureDetector(
                              onTap: () async {
                                if (controller.msg.text.isNotEmpty) {
                                  try {
                                    // Get a reference to the Firestore collection
                                    CollectionReference chats =
                                        FirebaseFirestore.instance
                                            .collection('chats');

                                    // Add a new document with a generated ID
                                    chats.add({
                                      'residentid':
                                          controller.resident.residentid!,
                                      'message': controller.msg.text,
                                      'chatroomid': controller.chatRoomId,
                                      "type": "message",
                                      'timestamp':
                                          DateTime.now().microsecondsSinceEpoch,
                                    });

                                    print('Data added successfully');

                                    controller.sendNotification(
                                        chatType: controller.chatType,
                                        chatRoomId: controller.chatRoomId,
                                        myData:
                                            controller.chatNeighbours.toJson(),
                                        message: controller.msg.text.toString(),
                                        name: controller
                                                .chatNeighbours.firstname
                                                .toString() +
                                            ' ' +
                                            controller.chatNeighbours.lastname
                                                .toString(),
                                        fcmToken:
                                            controller.chatNeighbours.fcmtoken);
                                    controller.msg.clear();
                                  } catch (error) {
                                    print('Error adding data: $error');
                                  }
                                }
                              },
                              child: Icon(
                                Icons.send,
                                color: AppColors.appThem,
                                size: 20,
                              ),
                            ),
                            5.22.w.pw
                          ],
                        )
                      ]
                    ],
                    10.h.ph,
                    Container(
                      child: Center(
                        child: Container(
                            width: 134.w,
                            height: 5.w,
                            decoration: BoxDecoration(
                                color: AppColors.appThem,
                                borderRadius: BorderRadius.circular(100.r))),
                      ),
                    ),
                    8.h.ph,
                  ],
                ),
              ),
            ),
          );
        });
  }
}

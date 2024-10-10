// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/loading.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';
import '../../../utils/Constants/constants.dart';
import '../../../Routes/set_routes.dart';
import '../../../Widgets/empty_list.dart';
import '../../../Widgets/my_back_button.dart';
import '../../../Widgets/my_button.dart';
import '../../../utils/styles/reuseable_textstyle.dart';
import '../Controller/discussion_form_controller.dart';

class DiscussionForm extends StatefulWidget {
  @override
  State<DiscussionForm> createState() => _DiscussionFormState();
}

class _DiscussionFormState extends State<DiscussionForm> {
  @override
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<DiscussionFormController>();
    return WillPopScope(
      onWillPop: () async {
        await Get.offAllNamed(homescreen, arguments: controller.user);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              Obx(
                () => MyBackButton(
                  widget: Padding(
                      padding: EdgeInsets.only(left: 50.w),
                      child: GestureDetector(
                          onTap: () {
                            controller.isModeratorVal.value == 1
                                ? Get.offNamed(allResidents,
                                    arguments: controller.user)
                                : showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                            backgroundColor:
                                                AppColors.globalWhite,
                                            surfaceTintColor:
                                                AppColors.globalWhite,
                                            content: SizedBox(
                                              width: 347.w,
                                              child: SingleChildScrollView(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                    Text(
                                                      'Discussion Forum is a vibrant space for community members to engage in meaningful conversations about pressing societal issues and explore avenues for positive change. Within this module, you can connect with like-minded individuals who share your passion for making the world a better place.',
                                                      style: GoogleFonts.ubuntu(
                                                        color:
                                                            HexColor('#4D4D4D'),
                                                        fontSize: 12.sp,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    30.h.ph,
                                                    Center(
                                                      child: MyButton(
                                                        gradient: AppGradients
                                                            .buttonGradient,
                                                        name: 'Ok',
                                                        width: 96.w,
                                                        height: 31.w,
                                                        border: 7.r,
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                      ),
                                                    )
                                                  ])),
                                            )));
                          },
                          child: Image.asset(
                            controller.isModeratorVal.value == 1
                                ? AppImages.block
                                : AppImages.disscussion_forum,
                            color: AppColors.appThem,
                            height:
                                controller.isModeratorVal.value == 1 ? 30 : 30,
                          ))),
                  text: 'Discussion Forum',
                  onTap: () {
                    Get.offAllNamed(homescreen, arguments: controller.user);
                  },
                ),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('discussionchats')
                        .where('discussionroomid',
                            isEqualTo:
                                controller.discussionRoomModel.data?.first.id)
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data!.docs;

                        if (data.length == 0) {
                          return EmptyList(
                              name:
                                  "Join the discussion Forum 😊 \n and share your thoughts with the community.");
                        }
                        return ListView.builder(
                          reverse: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            bool isSameDate = false;
                            String newDate = '';

                            if (index == 0 && data.length == 1) {
                              newDate = DateHelper.groupMessageDateAndTime(
                                      data[index]['timestamp'].toString())
                                  .toString();
                            } else if (index == data.length - 1) {
                              newDate = DateHelper.groupMessageDateAndTime(
                                      data[index]['timestamp'].toString())
                                  .toString();
                            } else {
                              final DateTime date =
                                  DateHelper.returnDateAndTimeFormat(
                                      data[index + 1]['timestamp'].toString());

                              final DateTime prevDate =
                                  DateHelper.returnDateAndTimeFormat(
                                      data[index]['timestamp'].toString());

                              isSameDate = date.isAtSameMomentAs(prevDate);

                              if (kDebugMode) {
                                print("$date $prevDate $isSameDate");
                              }

                              newDate = isSameDate
                                  ? ''
                                  : DateHelper.groupMessageDateAndTime(
                                          data[index]['timestamp'].toString())
                                      .toString();
                            }
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                                                color: AppColors.greyTransparent
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                newDate,
                                                style: reusableTextStyle(
                                                    textStyle:
                                                        GoogleFonts.dmSans(),
                                                    fontSize: 14.0,
                                                    color: AppColors.textBlack,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                            6.h.ph,
                                            data[index]['residentid']! ==
                                                    controller.user.userId
                                                ? SizedBox()
                                                : Text(
                                                    data[index]['user']
                                                            ['username']
                                                        .toString(),
                                                    style: reusableTextStyle(
                                                        textStyle: GoogleFonts
                                                            .dmSans(),
                                                        fontSize: 14.0,
                                                        color:
                                                            AppColors.textBlack,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                            Text(
                                              data[index]['message'].toString(),
                                              textAlign: TextAlign.start,
                                              style: reusableTextStyle(
                                                  textStyle:
                                                      GoogleFonts.dmSans(),
                                                  fontSize: 14.0,
                                                  color: AppColors.textBlack,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            4.h.ph,
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: Text(
                                                DateHelper.messageTime(
                                                    data[index]['timestamp']
                                                        .toString()),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10.sp,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            4.h.ph,
                                          ],
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        )),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        color: data[index]['residentid']! ==
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
                      } else if (snapshot.connectionState ==
                          ConnectionState.active) {
                        return CircularIndicatorUnderWhiteBox();
                      } else {
                        return CircularIndicatorUnderWhiteBox();
                      }
                    }),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  child: Obx(
                    () => controller.isForumBlockedVal.value == 1
                        ? Text("you are blocked!. you can chat right now")
                        : Row(
                            children: [
                              7.w.pw,
                              SizedBox(
                                width: 24.w,
                                height: 24.w,
                              ),
                              7.w.pw,
                              Container(
                                width: 292.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.globalWhite,
                                ),
                                child: TextFormField(
                                  maxLines: null,
                                  controller: controller.msg,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        left: 16.13.w,
                                      ),
                                      hintText: "Type your message",
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor('#D0D0D0')),
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
                                  onTap: () {
                                    if (controller.msg.text.isNotEmpty) {
                                      try {
                                        // Get a reference to the Firestore collection
                                        CollectionReference chats =
                                            FirebaseFirestore.instance
                                                .collection('discussionchats');

                                        var user = {
                                          'firstname':
                                              controller.user.firstName,
                                          'lastname': controller.user.lastName,
                                          'username':
                                              controller.resident.username,
                                          'address': controller.user.address,
                                          'rolename': controller.user.roleName,
                                          'roleid': controller.user.roleId,
                                        };
                                        // Add a new document with a generated ID
                                        chats.add({
                                          'residentid':
                                              controller.resident.residentid!,
                                          'message': controller.msg.text,
                                          'discussionroomid': controller
                                              .discussionRoomModel
                                              .data
                                              ?.first
                                              .id,
                                          'timestamp': DateTime.now()
                                              .microsecondsSinceEpoch,
                                          'user': user,
                                          'type': 'message',
                                        });

                                        controller.msg.clear();
                                        print('Data added successfully');
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
                          ),
                  )),
              10.h.ph,
              Center(
                child: Container(
                    width: 134.w,
                    height: 5.w,
                    decoration: BoxDecoration(
                        color: AppColors.appThem,
                        borderRadius: BorderRadius.circular(100.r))),
              ),
              8.h.ph,
            ],
          ),
        ),
      ),
    );
  }
}

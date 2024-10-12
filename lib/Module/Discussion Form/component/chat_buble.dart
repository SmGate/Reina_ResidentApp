import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Helpers/Date%20Helper/date_helper.dart';
import 'package:userapp/Module/Discussion%20Form/Controller/discussion_form_controller.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

Widget chatBuble(List<QueryDocumentSnapshot<Object?>> data, int index,
    DiscussionFormController controller) {
  // Get the message text
  String message = data[index]['message'].toString();

  TextPainter textPainter = TextPainter(
    text: TextSpan(
      text: message,
      style: reusableTextStyle(
        textStyle: GoogleFonts.openSans(),
        fontSize: 14.0,
        color: AppColors.textBlack,
        fontWeight: FontWeight.normal,
      ),
    ),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  );

  textPainter.layout();

  double messageWidth = textPainter.size.width;
  // Check if the message width is greater than 150
  bool isExpanded = messageWidth > 150;

  return isExpanded
      ? Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: data[index]['residentid']! == controller.user.userId
                  ? AppColors.chat
                  : AppColors.globalWhite,
            ),
            margin: EdgeInsets.all(4),
            child: _buildMessageContent(data, index, controller),
          ),
        )
      : Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: data[index]['residentid']! == controller.user.userId
                ? AppColors.chat
                : AppColors.globalWhite,
          ),
          margin: EdgeInsets.all(4),
          child: _buildMessageContent(data, index, controller),
        );
}

Widget _buildMessageContent(List<QueryDocumentSnapshot<Object?>> data,
    int index, DiscussionFormController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 6.h),
      data[index]['residentid']! == controller.user.userId
          ? SizedBox()
          : Text(
              data[index]['user']['username'].toString(),
              style: reusableTextStyle(
                textStyle: GoogleFonts.dmSans(),
                fontSize: 14.0,
                color: AppColors.textBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
      Text(
        data[index]['message'].toString(),
        textAlign: TextAlign.start,
        style: reusableTextStyle(
          textStyle: GoogleFonts.openSans(),
          fontSize: 14.0,
          color: AppColors.textBlack,
          fontWeight: FontWeight.normal,
        ),
        maxLines: null, // Allows the text to wrap to the next line
        overflow: TextOverflow.visible,
      ),
      SizedBox(height: 4.h),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          DateHelper.messageTime(data[index]['timestamp'].toString()),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10.sp,
            color: Colors.black,
          ),
        ),
      ),
      SizedBox(height: 4.h),
    ],
  );
}

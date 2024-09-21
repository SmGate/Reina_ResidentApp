// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:userapp/Module/Login/Model/User.dart';

import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/utils/styles/colors.dart';

class UserQrData extends StatelessWidget {
  String fname;
  String lastName;
  String profileImg;
  User user;
  UserQrData(
      {super.key,
      required this.fname,
      required this.lastName,
      required this.profileImg,
      required this.user});

  @override
  Widget build(BuildContext context) {
    String jsonData = jsonEncode(user.toJson());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Builder(builder: (context) {
          return Column(
            children: [
              MyBackButton(
                text: 'Your Qr',
                onTap: () {
                  Get.offNamed(homescreen, arguments: user);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 150),
                child: Center(
                  child: QrImageView(
                    backgroundColor: AppColors.globalWhite,
                    padding: EdgeInsets.all(20),
                    data: jsonData,
                    version: QrVersions.auto,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  String customUserToJson(User user) {
    return jsonEncode({
      'userId': user.userId,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'cnic': user.cnic,
      'address': user.address,
      'roleId': user.roleId,
      'subadminid': user.subadminid,
      'familyMemberId': user.familyMemberId,
      'residentid': user.residentid,
      'roleName': user.roleName,
      'bearerToken': user.bearerToken,
      'mobile': user.mobile,
      'image': user.image,
      'societyId': user.societyId,
      'email': user.email,
    });
  }
}

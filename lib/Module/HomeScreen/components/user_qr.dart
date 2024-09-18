// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:userapp/Module/Login/Model/User.dart';

import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/Widgets/my_back_button.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

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
    String jsonData = customUserToJson(user);

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
                padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Card(
                        surfaceTintColor: AppColors.globalWhite,
                        elevation: 10,
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Text(
                                  "${fname} ${lastName}",
                                  style: reusableTextStyle(
                                      textStyle: GoogleFonts.dmSans(),
                                      fontSize: 16.0,
                                      color: AppColors.textBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "Resident Contact",
                                style: reusableTextStyle(
                                    textStyle: GoogleFonts.dmSans(),
                                    fontSize: 14.0,
                                    color: AppColors.textBlack,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              QrImageView(
                                backgroundColor: AppColors.globalWhite,
                                padding: EdgeInsets.all(20),
                                data: jsonData,
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 50),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: AppColors.appThem, shape: BoxShape.circle),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(300),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: "${Api.imageBaseUrl}${profileImg}",
                            placeholder: (context, url) => SizedBox(
                                height: 60,
                                width: 60,
                                child: CircularProgressIndicator(
                                  color: AppColors.appThem,
                                )),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
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

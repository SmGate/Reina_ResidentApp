// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Module/HomeScreen/Controller/home_screen_controller.dart';
import 'package:userapp/Module/HomeScreen/components/user_qr.dart';
import 'package:userapp/Module/Update%20Profile/view/update_phone.dart';
import 'package:userapp/Module/Update%20Profile/view/update_user_profile.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

import '../../Login/Model/User.dart';

class MyDrawer extends StatelessWidget {
  String img;
  String fname;
  String lastname;
  User userdata;
  MyDrawer(
      {super.key,
      required this.img,
      required this.fname,
      required this.userdata,
      required this.lastname});

  @override
  Widget build(BuildContext context) {
    var homeScreenController = Get.find<HomeScreenController>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 200,
            child: DrawerHeader(
                decoration: BoxDecoration(color: AppColors.appThem),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.globalWhite),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "${Api.imageBaseUrl}${img}",
                          placeholder: (context, url) => SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(
                                color: AppColors.appThem,
                              )),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "${fname} ${lastname}",
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 20.0,
                            color: AppColors.globalWhite,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        userdata.mobile ?? "",
                        style: reusableTextStyle(
                            textStyle: GoogleFonts.dmSans(),
                            fontSize: 14.0,
                            color: AppColors.globalWhite,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyTransparent),
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.person_3_sharp,
                    size: 30,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    weight: 0.4,
                    fill: 0.1,
                    color: AppColors.greyTransparent,
                    size: 20,
                  ),
                  title: Text(
                    "Update Profile",
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 14.0,
                        color: AppColors.dark,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.to(
                        () => UpdateUserProfile(
                              fname: fname,
                              lastName: lastname,
                              profileImg: img,
                            ),
                        arguments: userdata);
                    // Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    color: AppColors.greyTransparent,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.phone_android_rounded,
                    size: 30,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    weight: 1.0,
                    color: AppColors.greyTransparent,
                    size: 20,
                  ),
                  title: Text(
                    "Update Phone",
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 14.0,
                        color: AppColors.dark,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.to(
                        () => UpdatePhone(
                              phone: userdata.mobile ?? "",
                              userId: userdata.userId ?? 0,
                            ),
                        arguments: userdata);
                  },
                ),
                //////////////
                ///
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    color: AppColors.greyTransparent,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.qr_code_2,
                    size: 30,
                    color: AppColors.dark,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    weight: 0.4,
                    fill: 0.1,
                    color: AppColors.greyTransparent,
                    size: 20,
                  ),
                  title: Text(
                    "Your Qr",
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 14.0,
                        color: AppColors.dark,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Get.to(
                      () => UserQrData(
                        fname: fname,
                        lastName: lastname,
                        profileImg: img,
                        user: userdata,
                      ),
                    );
                    // Navigator.pop(context);
                  },
                ),
                //////////////
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    color: AppColors.greyTransparent,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    size: 30,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    weight: 1.0,
                    size: 20,
                    color: AppColors.greyTransparent,
                  ),
                  title: Text(
                    "Logout",
                    style: reusableTextStyle(
                        textStyle: GoogleFonts.dmSans(),
                        fontSize: 14.0,
                        color: AppColors.dark,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () async {
                    // await authController.logout();
                    // await FirebaseMessaging.instance.deleteToken();
                    homeScreenController.logoutApi(
                        token: homeScreenController.user.bearerToken!);

                    Get.offAllNamed(loginscreen);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/constants.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/Constants/session_controller.dart';
import '../../../Services/Shared Preferences/MySharedPreferences.dart';
import '../../Login/Model/User.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User user = User();

  String splashImage = "";

  int isCustomSplashScreen = 1;
  bool hasInternetConnection = true;
  @override
  void initState() {
    super.initState();

    _checkInternetConnection();
  }

  void getSharedPreferencesData() async {
    user = await MySharedPreferences.getUserData();
    SessionController().user = user;

    print(user.bearerToken);
    print(user.address);
    print(user.email);
    setState(() {
      isCustomSplashScreen = user.hasCustomIntro ?? 0;
    });
    print("has custom intro ${user.hasCustomIntro}");

    if (user.bearerToken == "") {
      Timer(Duration(seconds: 3), () => Get.offNamed(loginscreen));
    } else if (user.address == 'NA') {
      Timer(Duration(seconds: 3), () => Get.offNamed(residentaddressdetail));
    } else {
      Timer(Duration(seconds: 3),
          () => Get.offNamed(homescreen, arguments: user));
    }
  }

  void _checkInternetConnection() async {
    print("is this function call");
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasInternetConnection = false;
        Get.offNamed(
          noInternetConnection,
        );
      });
    } else {
      setState(() {
        hasInternetConnection = true;
      });

      getSharedPreferencesData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isCustomSplashScreen == 1
            ? _buildCustomSplashScreen()
            : _buildDefaultSplashScreen(),
      ),
    );
  }

  Widget _buildDefaultSplashScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(138.w, 116.h, 138.w, 0),
          child: SvgPicture.asset(AppImages.splashSvg),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(67.01.w, 18.h, 67.87.w, 0),
          child: SvgPicture.asset(AppImages.smartgate),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(67.w, 7.h, 68.w, 0),
          child: Container(
              height: 3,
              width: 240,
              child: SvgPicture.asset(AppImages.spalshDivider)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(88.w, 4.h, 89.w, 0),
          child: Text(
            'SMART WAY OF LIVING',
            textAlign: TextAlign.center,
            style: GoogleFonts.inriaSerif(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
                color: primaryColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(56.w, 79.h, 56.w, 0),
          child: SvgPicture.asset(AppImages.splashSvg2),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.h, 46.h, 0.h, 0),
            child: Container(
              width: double.infinity,
              height: 237.h,
              child: SvgPicture.asset(
                AppImages.splashSvg3,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomSplashScreen() {
    // Define your custom splash screen UI here
    return Center(
        child: CachedNetworkImage(
      height: double.infinity,
      width: double.infinity,
      imageUrl: "${Api.imageBaseUrl}${splashImage = user.splashImage ?? ""}",
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
    ));
  }
}

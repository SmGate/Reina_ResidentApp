import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/Module/HomeScreen/Controller/home_screen_controller.dart';
import 'package:userapp/Widgets/app_gradient.dart';
import 'package:userapp/Widgets/my_button.dart';
import 'package:userapp/utils/Constants/constants.dart';

class HomeVerificationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var homeScreenController = Get.find<HomeScreenController>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/check.png',
            height: 200,
            width: 200,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Please Be Patient !",
            style: GoogleFonts.ubuntu(
                color: HexColor('#A5AAB7'),
                fontSize: 38.sp,
                fontWeight: FontWeight.w600),
          ),
          10.h.ph,
          Text(
            "We are verifying your details.",
            style: GoogleFonts.ubuntu(
                color: HexColor('#A5AAB7'),
                fontSize: 20.sp,
                fontWeight: FontWeight.w500),
          ),
          20.h.ph,
          MyButton(
            name: "Refresh ",
            gradient: AppGradients.buttonGradient,
            onPressed: () async {
              await homeScreenController.refreshScreen();
            },
          )
        ],
      ),
    );
  }
}

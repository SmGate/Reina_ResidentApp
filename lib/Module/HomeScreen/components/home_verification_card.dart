import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/utils/Constants/constants.dart';

class HomeVerificationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/new_icons/verification.svg',
            width: 300,
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
        ],
      ),
    );
  }
}

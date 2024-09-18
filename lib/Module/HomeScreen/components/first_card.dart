// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/utils/Constants/constants.dart';

class FirstCard extends StatefulWidget {
  String? phone;
  String? email;
  FirstCard({super.key, this.phone, this.email});

  @override
  State<FirstCard> createState() => _FirstCardState();
}

class _FirstCardState extends State<FirstCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 162.w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffFF9900), Color(0xffD83030)],
          ),
          borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              11.51.h.ph,
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "For any service support",
                          style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.sp,
                              color: Color(0xffFFFFFF)),
                        ),
                        Text(
                          "call us on ${widget.phone}",
                          style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Color(0xff000000)),
                        ),
                        6.h.ph,
                        Text(
                          "Or",
                          style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Color(0xff433F3F)),
                        ),
                        6.h.ph,
                        Text(
                          "Email us",
                          style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Color(0xffFFFFFF)),
                        ),
                        Text(
                          widget.email ?? "",
                          style: GoogleFonts.ubuntu(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Color(0xff000000)),
                        ),
                      ],
                    ),
                    // SvgPicture.asset(
                    //   "assets/home_vector.svg",
                    //   width: 127.73.w,
                    //   height: 79.w,
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

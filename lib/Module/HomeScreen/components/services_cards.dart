import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:userapp/utils/Constants/constants.dart';

class ServiceCards extends StatelessWidget {
  final String? heading;
  final String? description;
  final String? iconPath;

  final void Function()? onTap;

  const ServiceCards(
      {super.key,
      required this.description,
      required this.heading,
      required this.iconPath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: 150.63.w,
        height: 200,
        child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Column(
            children: [
              12.h.ph,
              Container(
                height: 50.w,
                width: 50.w,
                margin: EdgeInsets.only(
                  left: 48.w,
                  right: 47.63.w,
                ),
                child: Center(
                  child: Image.asset(
                    iconPath!.trim().toString(),
                    width: 50.w,
                    height: 50.67.w,
                  ),
                ),
              ),
              10.h.ph,
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  heading!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: HexColor("#262F71")),
                ),
              ),
              2.h.ph,
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.sp,
                      color: HexColor('#8A8A8A')),
                ),
              ),
              12.h.ph,
            ],
          ),
          //elevation: 1.6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ),
    );
  }
}

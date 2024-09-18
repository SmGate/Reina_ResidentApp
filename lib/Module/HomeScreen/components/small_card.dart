import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SmallCard extends StatelessWidget {
  final String? text;
  final String? iconPath;
  final double? iconWidth;
  final void Function()? onTap;

  const SmallCard({
    Key? key,
    required this.text,
    required this.iconPath,
    this.iconWidth,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Introduce a delay of 200 milliseconds before executing onTap function
        Future.delayed(
          Duration(milliseconds: 200),
        );
      },
      child: Container(
        height: 47.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0, 3),
              blurRadius: 4.r,
              spreadRadius: 0.3,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.grey.withOpacity(0.5), // Define splash color
            borderRadius: BorderRadius.circular(28.r),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(13.w, 12.h, 0, 13.h),
                    child: Text(
                      text!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: HexColor("#262F71"),
                      ),
                    ),
                  ),
                  SizedBox(width: 17.w),
                  Image.asset(
                    iconPath!,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:userapp/Widgets/custom_card.dart';
import 'package:userapp/utils/styles/colors.dart';
import 'package:userapp/utils/styles/reuseable_textstyle.dart';

class MenuItems extends StatelessWidget {
  String image;
  String title;
  String? secondTitle;
  Function ontap;
  MenuItems(
      {super.key,
      required this.image,
      required this.title,
      required this.ontap,
      required this.secondTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomCard(
            width: 60,
            height: 60,
            boxShadow: BoxShadow(),
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              ontap();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                image,
              ),
            )),
        SizedBox(
          height: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 12.0,
                  color: AppColors.boldHeading,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              secondTitle ?? "",
              style: reusableTextStyle(
                  textStyle: GoogleFonts.dmSans(),
                  fontSize: 12.0,
                  color: AppColors.boldHeading,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ],
    );
  }
}

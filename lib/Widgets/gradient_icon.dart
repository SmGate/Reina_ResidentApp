// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:userapp/Widgets/app_gradient.dart';

class GradientIcon extends StatelessWidget {
  String? img;
  GradientIcon({super.key, this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          gradient: AppGradients.horizontalGradient,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.all(10.0), child: Image.asset(img ?? "")),
    );
  }
}

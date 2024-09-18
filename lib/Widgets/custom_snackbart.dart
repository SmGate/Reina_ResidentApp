import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Widgets/app_gradient.dart';

class CustomSnackbar {
  static void show(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      colorText: Colors.white,
      backgroundGradient: AppGradients.horizontalGradient,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}

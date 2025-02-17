import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static throwErrorSnackBar(String content,
      {Duration duration = const Duration(seconds: 3)}) {
    content = content.replaceAll("Exception: ", "");
    Get.rawSnackbar(
      messageText: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      duration: duration,
      backgroundColor: AppColors.red,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void throwSuccessSnackBar(String content,
      {Duration duration = const Duration(seconds: 3)}) {
    Get.rawSnackbar(
      messageText: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      duration: duration,
      backgroundColor: AppColors.green,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

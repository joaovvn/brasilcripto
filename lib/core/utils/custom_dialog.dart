import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static void showConfirmationDialog(String title, Function() confirm) {
    Get.defaultDialog(
        backgroundColor: AppColors.primary,
        title: title,
        content: SizedBox(),
        textConfirm: "Yes",
        textCancel: "No",
        buttonColor: AppColors.secondary,
        confirmTextColor: AppColors.primary,
        cancelTextColor: AppColors.secondary,
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          confirm();
          Get.back();
        });
  }
}

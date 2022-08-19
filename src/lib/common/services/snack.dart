import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Misc {
  Future<void> snackbar({String? title, String? message, Color? color}) async {
    Get.snackbar(
      title ?? '-',
      message ?? '-',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color ?? Colors.red,
      colorText: Colors.white,
    );
  }
}

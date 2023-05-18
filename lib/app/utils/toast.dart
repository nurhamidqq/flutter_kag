import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastUtil {
  static Future<void> showSnackBar(String title, String message,
      [ToastStatus? ts]) async {
    if (Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
    }
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
        backgroundColor: getColorbyStatus(ts).bgcolor,
        colorText: getColorbyStatus(ts).textcolor,
        duration: const Duration(milliseconds: 2000),
        isDismissible: true);
  }

  static Future<void> showSnackBarError(String title, String message) async {
    if (Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
    }
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
        backgroundColor: getColorbyStatus(ToastStatus.error).bgcolor,
        colorText: getColorbyStatus(ToastStatus.error).textcolor,
        duration: const Duration(milliseconds: 2000),
        isDismissible: true);
  }

  static ToastColor getColorbyStatus(ToastStatus? ts) {
    switch (ts) {
      case ToastStatus.success:
        return ToastColor(bgcolor: Colors.green, textcolor: Colors.white);
      case ToastStatus.error:
        return ToastColor(bgcolor: Colors.red, textcolor: Colors.white);
      case ToastStatus.warning:
        return ToastColor(bgcolor: Colors.orange, textcolor: Colors.white);
      case ToastStatus.info:
        return ToastColor(bgcolor: Colors.blue, textcolor: Colors.white);
      default:
        return ToastColor(bgcolor: null, textcolor: Colors.black);
    }
  }
}

enum ToastStatus { success, error, warning, info }

class ToastColor {
  Color? bgcolor;
  Color? textcolor;
  ToastColor({
    this.bgcolor,
    this.textcolor,
  });
}

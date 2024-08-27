import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import 'colors.dart';

class Warnings{

  static SnackbarController onError(String title){
    return Get.snackbar("Alert",
        title,
        icon: Icon(Icons.dangerous, color: AppColors.errorColor),
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING);
  }
  static SnackbarController onSuccess(String title){
    return Get.snackbar("Success",
        title,
        icon: const Icon(Icons.gpp_good, color: AppColors.successColor),
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING);
  }
}

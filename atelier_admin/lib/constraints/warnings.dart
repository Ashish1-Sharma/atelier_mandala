import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

class Warnings{

  static SnackbarController onError(String title){
    return Get.snackbar("Alert",
        title,
        icon: const Icon(Icons.dangerous, color: AppColors.errorColor),
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING);
  }
  static SnackbarController onSuccess(String title){
    return  Get.snackbar("Success",
        title,
        icon: const Icon(Icons.gpp_good, color: AppColors.successColor),
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING);
  }
}
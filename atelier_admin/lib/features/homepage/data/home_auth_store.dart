import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constraints/colors.dart';
import '../../../global_firebase.dart';

class HomeAuthStore{
  static Future<void> logOut() async {
    await GlobalFirebase.auth.signOut().then((value) {
      Get.snackbar("Success", "Successfully logged out",
          icon: Icon(Icons.gpp_good, color: AppColors.successColor),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
      Get.offAndToNamed("/login");
    },);
  }
}
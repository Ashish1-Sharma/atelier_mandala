import 'package:atelier_admin/features/homepage/data/HomePageController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/fonts.dart';
import '../../data/home_auth_store.dart';

Future<void> showCustomDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(
        "ALERT",
        style: AppTextStyles.bodyMain18(color: Colors.black),
      ),
      actions: [
        TextButton(
            onPressed: () {
              HomeAuthStore.logOut().then(
                (value) {
                  Get.offAndToNamed('/login');
                },
              );
            },
            child: Text("Yes")),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("No")),
      ],
      content: Text(
        "Are you sure want to logout ?",
        style: AppTextStyles.bodyMain16(color: Colors.black),
      ),
    ),
  );
}

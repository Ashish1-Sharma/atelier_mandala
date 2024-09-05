
import 'package:atelier_user/features/profile/data/profile_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/fonts.dart';

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
              ProfileServices.logOut().then(
                    (value) {
                  Get.offAllNamed('/login');
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

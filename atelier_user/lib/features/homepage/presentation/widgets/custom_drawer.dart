import 'package:atelier_user/constraints/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_firebase.dart';
import '../../../authentication/presentation/screens/log_in.dart';
import '../../../checkout/presentation/screens/cart_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: Get.width * 0.5,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8),
      color: AppColors.black6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Space.spacer(0.04),
          GestureDetector(
            onTap: () {
              Get.toNamed("/edit_profile");
            },
            child: Container(
              width: double.infinity,
              child: Text(
                'Log out',
                style: AppTextStyles.bodyMain16(color: Colors.black),
              ),
            ),
          ),
          Space.spacer(0.01),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              child: Text(
                'Help',
                style: AppTextStyles.bodyMain16(color: Colors.black),
              ),
            ),
          ),
          Space.spacer(0.01),
          GestureDetector(
            onTap: () {
              GlobalFirebase.auth.signOut().then(
                (value) {
                  Get.offAll(LogIn());
                },
              );
            },
            child: Container(
              width: double.infinity,
              child: Text(
                'Log out',
                style: AppTextStyles.bodyMain16(color: Colors.black),
              ),
            ),
          ),
          Space.spacer(0.01),
          GestureDetector(
            onTap: () {
              print(GlobalFirebase.auth.currentUser!.uid);
              Get.to(() => CartPage());
            },
            child: Container(
              height: 50,
              width: double.infinity,
              child: Text(
                'Cart',
                style: AppTextStyles.bodyMain16(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

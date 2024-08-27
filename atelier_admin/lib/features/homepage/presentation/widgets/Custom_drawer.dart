import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/homepage/data/HomePageController.dart';
import 'package:atelier_admin/features/homepage/data/home_auth_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../global_firebase.dart';
import 'alert_box.dart';

class CustomDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomDrawer({super.key, required this.scaffoldKey});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final List<String> drawerText = [
    'Dashboard',
    'Workshop',
    'User',
    'Payment',
    'Manage Takeaway',
    'Publish Gift Card',
    'Manage Store',
    'Change Password',
    'Logout'
  ];

  final List<String> icons = [
    'dashboard',
    'workshop',
    'user',
    'payment',
    'takeaway',
    'gift_card',
    'store',
    'change_password',
    'logout'
  ];

  final List<String> pageNames = [
    '/dashboard',
    '/workshop',
    '/users',
    '/payment',
    '/takeaway',
    '/gift',
    '/store'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: Get.height * 0.02),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Image.asset('assets/logo.png', width: 40),
                  SizedBox(width: 10),
                  Text(
                    "Atelier Mandala.",
                    style: AppTextStyles.h3(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.04),
              ListView.builder(
                shrinkWrap: true,
                itemCount: drawerText.length + 2, // Adjust the count to include dividers
                itemBuilder: (context, index) {
                  if (index == 4 || index == 7) { // Insert Divider after Payment (index 4) and Manage Store (index 7)
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: AppColors.brandColor,
                        thickness: 1.0,
                        height: 1.0,
                      ),
                    );
                  }
                  final adjustedIndex = (index > 4 && index <= 7) ? index - 1 : index > 7 ? index - 2 : index;

                  return GestureDetector(
                    onTap: () async {
                      if (drawerText[adjustedIndex] == 'Logout') {
                        await showCustomDialog(context);
                      } else {
                        HomePageController.currScreen.value = adjustedIndex;
                        HomePageController.isScreenSelected.setAll(
                            0, List.filled(
                            HomePageController.isScreenSelected.length, false));
                        HomePageController.isScreenSelected[adjustedIndex] = true;
                        HomePageController.checkScreen();
                        widget.scaffoldKey.currentState!.closeDrawer();
                      }
                    },
                    child: Obx(
                          () => ListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/drawer_icons/${icons[adjustedIndex]}.svg',
                          fit: BoxFit.contain,
                          color: HomePageController.isScreenSelected[adjustedIndex]
                              ? AppColors.brandColor
                              : AppColors.black1,
                        ),
                        title: Text(
                          drawerText[adjustedIndex],
                          style: AppTextStyles.bodySmall(
                              color: HomePageController.isScreenSelected[adjustedIndex]
                                  ? AppColors.brandColor
                                  : AppColors.black1),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future showCustomDialog(BuildContext context) {
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
              HomeAuthStore.logOut().then((value) {
                HomePageController.isScreenSelected.setAll(
                    0, List.filled(
                    HomePageController.isScreenSelected.length, false));
                Get.offAndToNamed('/login');
              });
            },
            child: Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("No"),
          ),
        ],
        content: Text(
          "Are you sure you want to logout?",
          style: AppTextStyles.bodyMain16(color: Colors.black),
        ),
      ),
    );
  }
}

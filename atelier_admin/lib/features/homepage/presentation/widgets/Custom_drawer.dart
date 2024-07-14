import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/homepage/data/HomePageController.dart';
import 'package:atelier_admin/features/homepage/data/home_auth_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
    'Publish Gift Card  ',
    'Manage Store ',
    'Edit Profile',
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
    'edit_profile',
    'change_password',
    'logout'
  ];

  List<String> pageNames = [
    '/dashboard',
    '/workshop',
    '/users',
    '/payment',
    '/takeaway',
    '/gift',
    '/store',
    '/edit_profile'
  ];

  @override
  Widget build(BuildContext context) {
    // if(HomePageController.currIndex.value == 9) {
    //   Future.delayed(Duration.zero, () {
    //     showDialog(
    //       barrierDismissible: false,
    //       context: context, builder: (context) =>
    //         CupertinoAlertDialog(
    //           title: Text(
    //             "ALERT", style: AppTextStyles.bodyMain18(color: Colors.black),),
    //           actions: [
    //             TextButton(onPressed: () {
    //               HomeAuthStore.logOut().then((value) {
    //                 Get.offAndToNamed('/login');
    //               },);
    //             }, child: Text("Yes")),
    //             TextButton(onPressed: () {
    //               Get.back();
    //             }, child: Text("No")),
    //           ],
    //           content: Text("Are you sure want to logout ?",
    //             style: AppTextStyles.bodyMain16(color: Colors.black),),),);
    //   });
    // }
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                'assets/logo.png',
                width: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Atelier Mandala.",
                style: AppTextStyles.h3(color: Colors.black),
              )
            ],
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: drawerText.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  if (index != 9) {
                    HomePageController.currScreen.value = index;
                    HomePageController.isScreenSelected.setAll(
                        0,
                        List.filled(
                            HomePageController.isScreenSelected.length, false));
                    HomePageController.isScreenSelected[index] = true;
                    HomePageController.checkScreen();
                    widget.scaffoldKey.currentState!.closeDrawer();
                  } else {
                    HomeAuthStore.logOut();
                  }

                  print(HomePageController.currIndex.value);
                },
                child: Obx(
                  () => ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/drawer_icons/${icons[index]}.svg',
                      fit: BoxFit.contain,
                      color: HomePageController.isScreenSelected[index]
                          ? AppColors.brandColor
                          : AppColors.black1,
                    ),
                    title: Text(
                      drawerText[index],
                      style: AppTextStyles.bodySmall(
                          color: HomePageController.isScreenSelected[index]
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
                HomeAuthStore.logOut().then(
                  (value) {
                    HomePageController.isScreenSelected.setAll(
                        0,
                        List.filled(
                            HomePageController.isScreenSelected.length, false));
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
}

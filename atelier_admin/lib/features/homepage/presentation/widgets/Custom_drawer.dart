import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/homepage/data/HomePageController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomDrawer({super.key,required this.scaffoldKey});

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
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: Get.height*0.02,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10,),
              Image.asset('assets/logo.png',width: 40,),
              SizedBox(width: 10,),
              Text("Atelier Mandala." , style: AppTextStyles.h3(color: Colors.black), )
            ],
          ),
              SizedBox(height: Get.height*0.04,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: drawerText.length,
            itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                HomePageController.currScreen.value = index ;
                HomePageController.isScreenSelected.setAll(0, List.filled(HomePageController.isScreenSelected.length, false));
                HomePageController.isScreenSelected[index] = true;
                HomePageController.checkScreen();
                widget.scaffoldKey.currentState!.closeDrawer();
              },
              child: Obx(
                ()=> ListTile(
                  leading: SvgPicture.asset('assets/icons/drawer_icons/${icons[index]}.svg'
                    ,fit: BoxFit.contain
                    ,color: HomePageController.isScreenSelected[index] ? AppColors.brandColor : AppColors.black1,),
                  title: Text(drawerText[index],style: AppTextStyles.bodySmall(color: HomePageController.isScreenSelected[index] ? AppColors.brandColor : AppColors.black1),),
                ),
              ),
            );
          },)
        ],
      ),
    );
  }
}

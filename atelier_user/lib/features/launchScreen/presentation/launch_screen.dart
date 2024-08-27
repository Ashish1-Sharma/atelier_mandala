
import 'dart:async';

import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/launchScreen/data/launch_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swipeable_button/swipeable_button.dart';

import '../../../constraints/space.dart';
import '../../splash/data/splash_service.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () async {
      await LaunchService.checkUser().then((value) {
        if(value){
          Get.offAndToNamed('/home');
        } else{
          Get.offAndToNamed('/login');
        }
      },);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
       color: AppColors.tertiaryColor,
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SvgPicture.asset("assets/logo.svg",width: 200,),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text("Atelier Mandala",style: AppTextStyles.h3500(color: AppColors.black4),))),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: SwipeableButton.simple(
                  label: const Center(
                    child: Text(
                      "Swipe to start",
                      style: TextStyle(
                        color: AppColors.black3,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  height: 50.0,
                  minThumbWidth: 40.0,
                  oneTime: true,
                  color: AppColors.black6,
                  thumbColor: AppColors.brandColor,
                  thumbIconColor: Colors.black,

                  borderRadius: BorderRadius.circular(30),
                  onSwipe: () async {
                    // Perform delete action.
                    await LaunchService.checkUser().then((value) {
        if(value){
          Get.offAndToNamed('/home');
        } else{
          Get.offAndToNamed('/login');
        }
      },);
                  },
                ),
              ),
              Space.spacer(0.01),
            ],
          ),
        ),
      ),
    );
  }


}

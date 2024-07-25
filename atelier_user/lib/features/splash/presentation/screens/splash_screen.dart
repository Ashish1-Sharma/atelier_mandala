import 'dart:async';

import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/splash/data/splash_service.dart';
import 'package:atelier_user/features/splash/presentation/widgets/custom_splash_widget.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/space.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          CustomSplashWidget(txt: "Events at your fingertips", idx: 0,pageController: pageController,),
          CustomSplashWidget(txt: "Make your life eventful", idx: 1,pageController: pageController,),
          const CustomSplashWidget(txt: "Welcome", idx: 2),
        ],
      ),
    );
  }
}


import 'dart:async';

import 'package:atelier_user/features/launchScreen/data/launch_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
    Timer(Duration(seconds: 2), () async {
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
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFFFFDED5),
                  Color(0xFFACB3FF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter

            )
        ),
        child: Center(
          child: Image.asset("assets/logo.png"),
        ),
      ),
    );
  }


}

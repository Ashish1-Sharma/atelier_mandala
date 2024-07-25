import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Space{
  // final h1 = Get.height * 0.015;
  // final h2 = Get.height * 0.008;

  // static final h1 = SizedBox(
  //   height: Get.height*0.02,
  // );
  //
  // static final h2 = SizedBox(
  //   height: Get.height*0.015,
  // );
  //
  // static final h3 = SizedBox(
  //   height: Get.height*0.008,
  // );

  static Widget spacer(double value){
    return SizedBox(
      height: Get.height*value,
    );
  }
  static Widget width(double value){
    return SizedBox(
      width: Get.width*value,
    );
  }
}
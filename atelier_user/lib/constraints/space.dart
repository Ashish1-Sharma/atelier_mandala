import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Space{
  static Widget spacer(double value){
    return SizedBox(
      height: Get.height*value,
    );
  }
}
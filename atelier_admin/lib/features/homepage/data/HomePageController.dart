import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashboard/presentation/screens/dashboard_screen.dart';

class HomePageController extends GetxController{
  static RxInt currScreen = 0.obs;
  static List<bool> isScreenSelected = List.generate(9, (index) => false,).obs;
  static RxBool showFloat = false.obs;
  static RxInt currIndex = 0.obs;

  static void checkScreen() {
    int idx = HomePageController.currScreen.value;
    if (idx == 1 || idx == 4 || idx == 5 || idx == 6) {
      print("checked ==========================================================");
      showFloat.value = true;
      print(HomePageController.showFloat);
    }else{
      showFloat.value = false;
    }
  }
}
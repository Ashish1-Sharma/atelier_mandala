import 'package:get/get.dart';

class WorkshopController extends GetxController{
  static RxBool isProcessing = false.obs;

  static RxList imageLinks = [].obs;

  static RxBool isButtonSelected = true.obs;
}
import 'package:get/get.dart';

class GiftCardController extends GetxController{
  static RxBool isProcessing = false.obs;
  static RxBool showImagePicker = true.obs;
  static RxList imageLinks = [].obs;

  static RxBool isButtonSelected = false.obs;
}
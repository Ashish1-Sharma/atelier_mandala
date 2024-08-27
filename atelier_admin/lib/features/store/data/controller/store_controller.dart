import 'package:get/get.dart';

class StoreController extends GetxController{
  static RxList tags = [
    'Rice',
    'Cheese',
    'Lentils',
    'Pizza',
    'Bread'
  ].obs;
  static RxList isTagSelected = List.generate(5, (index) => false,).obs;
  static RxBool isProcessing = false.obs;
  static RxBool showImagePicker = true.obs;

  static RxList imageLinks = [].obs;

  static RxBool isButtonSelected = false.obs;
}

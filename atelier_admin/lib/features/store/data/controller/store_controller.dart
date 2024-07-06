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
}

import 'package:get/get.dart';

class TakeawayController extends GetxController{
  static final List<String> categories = ["Art", "Indian", "Breakfast"].obs;
  static RxString selectedValue = categories[0].obs;
}
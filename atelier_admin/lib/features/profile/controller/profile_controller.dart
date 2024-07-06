import 'package:get/get.dart';

class ProfileController extends GetxController{
  static final List<String> genders = ["Male", "Female"].obs;
  static RxString selectedValue = genders[0].obs;
}
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GlobalController extends GetxController{
  static RxString link = "".obs;
  static File image = File('');
  static XFile? pickedImage = null;
  static RxString path = ''.obs;
}
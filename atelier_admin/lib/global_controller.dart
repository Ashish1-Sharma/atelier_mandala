import 'dart:io';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class GlobalController extends GetxController{
  static RxString link = "".obs;
  static File image = File('');
  static XFile? pickedImage = null;
  static RxString path = ''.obs;
  static Rx cropImage = ImageCropper().obs;
  static Rx croppedImage = ''.obs;
  static RxString choosenImageLink = "".obs;
static RxString downloadUrl = "".obs;


  static RxList isPickedImageSelected = [].obs;

  static String extractName(String link){
    final regex = link.substring(link.indexOf("%2F")+3,link.indexOf("?"));
    return regex;
  }
}
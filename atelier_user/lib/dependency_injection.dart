import 'package:atelier_user/global/global_controller.dart';
import 'package:get/get.dart';

class DependencyInjection{
  static void init(){
    Get.put<GlobalController>(GlobalController(),permanent: true);
  }
}
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController{
  final Connectivity connectivity = Connectivity();
  static RxBool isConnect = true.obs;
  @override
  void onInit(){
    super.onInit();
    connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  void _updateConnectivityStatus(List<ConnectivityResult> connectivityResult){
    print(connectivityResult);
    if(connectivityResult.first == ConnectivityResult.none){
      print(isConnect.value);
      print("kslfjalkasdjfklasfjlaskjflasj00000000000000000000000000000000000000000000000000");
      isConnect.value = false;
    } else{
      isConnect.value = true;
      Get.back(closeOverlays: true);
    }

  }

}
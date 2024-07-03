import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

enum DeviceType { Mobile, Tablet, Desktop, Unknown }

class ResponsiveUtil {
  static DeviceType getDeviceType() {
    final double screenWidth = Get.width;
    if (screenWidth < 600) {
      return DeviceType.Mobile;
    } else if (screenWidth >= 600 && screenWidth < 1200) {
      return DeviceType.Tablet;
    } else {
      return DeviceType.Desktop;
    }
  }
}
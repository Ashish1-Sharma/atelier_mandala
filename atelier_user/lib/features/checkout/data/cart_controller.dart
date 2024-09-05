import 'package:get/get.dart';

class CartController extends GetxController{
  static RxDouble totalPrice = 0.0.obs;
  static RxInt totalItems = 0.obs;
  static RxBool isClicked = false.obs;

  static RxBool isCouponUsed = false.obs;
  static RxInt couponValue = 0.obs;
  static RxInt tabIdx = 0.obs;
  static void updateTotalItems(int items) {
    totalItems.value = items;
  }

  // Method to update total price
 static void updateTotalPrice(double price) {
    totalPrice.value = price;
  }

}
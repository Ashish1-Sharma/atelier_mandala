import 'package:atelier_admin/features/giftCards/data/models/coupon_codes_model.dart';
import 'package:atelier_admin/features/giftCards/data/models/gift_card_model.dart';

import '../../../../global_firebase.dart';

class Add{
  static Future<void> giftCard(GiftCardModel model, String id) async {
    await GlobalFirebase.cloud.collection("gift_cards").doc(id).set(model.toMap()).then((value) {
      print("successfully uploaded");
    },);
  }
  static Future<void> couponCode(CouponCodesModel model, String pId,String code) async {
    await GlobalFirebase.cloud.collection("gift_cards").doc(pId).collection("Coupon_codes").doc(code).set(model.toJson()).then((value) {
      print("successfully uploaded");
    },);
  }
}
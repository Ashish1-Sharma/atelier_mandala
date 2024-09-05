import 'package:atelier_user/global/global_models/gift_card_model.dart';

import '../../../global/global_firebase.dart';

class GiftCardServices{
  static Future<List<GiftCardModel>> fetchGiftCards() async {
    final snapshot = await GlobalFirebase.cloud.collection('gift_cards').where('isPublic',isEqualTo: true).where('isPurchased',isEqualTo: false).get();
    final documents = snapshot.docs;
    return List.generate(documents.length, (index) {
      final docSnapshot = documents[index];
      final model = GiftCardModel.fromMap(docSnapshot.data());
      return model;
    });
  }

  static Future<List> findCode(String id,int quantity) async {
    print(quantity);
    print('-----------------------------------------');
    print(id);
    final response = await GlobalFirebase.cloud
        .collection("gift_cards")
        .doc(id)
        .collection("Coupon_codes")
        .where("usedOrNot", isEqualTo: false)
        .limit(quantity)
        .get();
    final value = response.docs.first.data()["code"];
    List<dynamic> codes = [];
    codes.add(value);
    print(codes);
    return codes;
  }

  // static Future<int> fetchQuantity(String id) async {
  //   final snapshot = await GlobalFirebase.cloud
  //       .collection("gift_cards")
  //       .doc(id)
  //       .get();
  //   final document = snapshot.data();
  //   return int.parse(document?['quantity']);
  // }
}
import 'package:atelier_admin/features/giftCards/data/models/gift_card_model.dart';

import '../../../../global_firebase.dart';

class AddGiftCard{
  static Future<void> pushData(GiftCardModel model) async {
    await GlobalFirebase.cloud.collection("gift_cards").doc(DateTime.now().millisecondsSinceEpoch.toString()).set(model.toMap()).then((value) {
      print("successfully uploaded");
    },);
  }
}
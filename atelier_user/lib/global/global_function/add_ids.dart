import 'package:atelier_user/global/global_firebase.dart';

class AddIds {
  static Future<void> toWorkshop(String id) async {
    await GlobalFirebase.cloud
        .collection("Users")
        .doc(GlobalFirebase.auth.currentUser!.uid)
        .collection("cart")
        .doc(GlobalFirebase.auth.currentUser!.uid)
        .collection("workshop")
        .doc(id)
        .set({'wId': id});
  }

  static Future<void> toTakeaway(String id) async {
    await GlobalFirebase.cloud
        .collection("Users")
        .doc(GlobalFirebase.auth.currentUser!.uid)
        .collection("cart")
        .doc(GlobalFirebase.auth.currentUser!.uid)
        .collection("takeaway")
        .doc(id)
        .set({
      'tId': id,
    });
  }

  static Future<void> toStore(String id) async {
    await GlobalFirebase.cloud
        .collection("Users")
        .doc(GlobalFirebase.auth.currentUser!.uid)
        .collection("cart")
        .doc(GlobalFirebase.auth.currentUser!.uid)
        .collection("store")
        .doc(id)
        .set({
      'sId': id,
    });
  }

  static Future<void> toGiftCard(String id) async {
    // final str = "$id/$code";
    await GlobalFirebase.cloud
        .collection("Users")
        .doc(GlobalFirebase.auth.currentUser!.uid)
        .collection("cart")
        .doc(GlobalFirebase.auth.currentUser!.uid)
        .collection("gift_cards")
        .doc(id)
        .set({
      'gId': id,
    });
  }
}

import 'package:atelier_user/constraints/fonts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../global/global_firebase.dart';
import '../../../global/global_models/takeaway_model.dart';
import '../../../global/global_models/workshop_model.dart';

class CartServices{
  static final cart = GlobalFirebase.cloud.collection("Users").doc(GlobalFirebase.auth.currentUser!.uid).collection("cart");
  static final purchased = GlobalFirebase.cloud.collection("Users").doc(GlobalFirebase.auth.currentUser!.uid).collection("purchasedItems");
  static final uId = GlobalFirebase.auth.currentUser!.uid;

  static Future<List<WorkshopModel>> fetchWorkshops(String id) async {
    final snapshot = await GlobalFirebase.cloud.collection('workshops').where('wId' , isEqualTo: id).get();
    final documents = snapshot.docs;
    return List.generate(documents.length, (index) {
      final docSnapshot = documents[index];
      final model = WorkshopModel.fromMap(docSnapshot.data());
      return model;
    });
  }

  static Future<List<TakeawayModel>> fetchTakeaways(String id) async {
    final snapshot = await GlobalFirebase.cloud.collection('takeaway').where('tId' , isEqualTo: id).get();
    final documents = snapshot.docs;
    return List.generate(documents.length, (index) {
      final docSnapshot = documents[index];
      final model = TakeawayModel.fromMap(docSnapshot.data());
      return model;
    });
  }
  
  static Future<void> addPurchaseItems(Map<String, List<Map<String, dynamic>>> data)async {
    final workshopItems = await cart.doc(uId).collection("workshop").get();
    for (var item in workshopItems.docs) {
      await purchased.doc(uId).collection("workshop").doc(item.id).set(item.data());
      await cart.doc(uId).collection("workshop").doc(item.id).delete();
    }

    final storeItems = await cart.doc(uId).collection("store").get();
    for (var item in storeItems.docs) {
      await purchased.doc(uId).collection("store").doc(item.id).set(item.data());
      await cart.doc(uId).collection("store").doc(item.id).delete();
    }

    final takeawayItems = await cart.doc(uId).collection("takeaway").get();
    for (var item in takeawayItems.docs) {
      await purchased.doc(uId).collection("takeaway").doc(item.id).set(item.data());
      await cart.doc(uId).collection("takeaway").doc(item.id).delete();
    }

    final giftItems = await cart.doc(uId).collection("gift_cards").get();
    for (var item in giftItems.docs) {
      await purchased.doc(uId).collection("gift_cards").doc(item.id).set(item.data());
      await cart.doc(uId).collection("gift_cards").doc(item.id).delete();
    }
  }

  static Future<void> checkCouponPrice(String coupon)async {
   try{
     final response = await purchased.doc(uId).collection("gift_cards").where('gId',isEqualTo: coupon).get();
     final result = response.docs.first.data()['gId'];
     if(result == ""){
       print(result);
     } else{
       print("No price");
     }
   } catch (e){
     Get.snackbar('Alert', "Coupon code not exist");
     print(e);
   }
  }
}
import 'package:atelier_user/constraints/warnings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class GlobalFirebase{
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore cloud = FirebaseFirestore.instance;
  static final storage = FirebaseStorage.instance;
  static final purchased = GlobalFirebase.cloud.collection("Users").doc(GlobalFirebase.auth.currentUser!.uid).collection("purchasedItems");
  static final favorite = GlobalFirebase.cloud.collection("Users").doc(GlobalFirebase.auth.currentUser!.uid).collection("favorite");
  static final uId = GlobalFirebase.auth.currentUser!.uid;

  static Future<int> checkCouponPrice(String coupon)async {
    try{
      final response = await purchased.doc(uId).collection("gift_cards").where('code',isEqualTo: coupon).get();
      final result = response.docs.first.data()['gId'];
      print(result);
      if(result != ""){
        Warnings.onSuccess("Coupon code exist");
        print(result);
        final value = response.docs.first.data()['price'];
        print(value);
        return value;
      } else{
        print("No price");
      }
    } catch (e){
      Warnings.onError("Coupon code not exist");
      print(e);
      return 0;
    }
    return 0;
  }

  static Future<void> removeCoupon(String coupon) async {
    try {
      final querySnapshot = await purchased.doc(uId).collection("gift_cards").where('code', isEqualTo: coupon).get();

      if (querySnapshot.docs.isEmpty) {
        print("Coupon code '$coupon' not found for user '$uId'."); // No coupon found
      }

      final doc = querySnapshot.docs.first;
      final price = doc.data()['price'];  // Extract the price
      await doc.reference.delete();        // Delete the document

      print("Coupon code '$coupon' successfully removed for user '$uId'. Price: $price");
    } on FirebaseException catch (e) {
      print("Error removing coupon: ${e.message}");
    } catch (e) {
      print("Unexpected error: $e");
    }
  }

  static Future<void> addTakeawayToFavorites(String id) async{
    await GlobalFirebase.favorite.doc(GlobalFirebase.uId).collection('takeaway').doc(id).set(
        {'tId' : id});
    Warnings.onSuccess("Successfully added to favorite");
  }
}
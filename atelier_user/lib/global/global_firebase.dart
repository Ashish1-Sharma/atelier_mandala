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
  static final uId = GlobalFirebase.auth.currentUser!.uid;

  static Future<int> checkCouponPrice(String coupon)async {
    try{
      final response = await purchased.doc(uId).collection("gift_cards").where('gId',isEqualTo: coupon).get();
      final result = response.docs.first.data()['gId'];
      print(result);
      if(result != ""){
        Warnings.onSuccess("Coupon code exist");
        print(result);
        final money = await GlobalFirebase.cloud.collection("gift_cards").where('gId',isEqualTo: result).get();
        final value = money.docs.first.data()['price'];
        print(value);
        return int.parse(value);
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
}
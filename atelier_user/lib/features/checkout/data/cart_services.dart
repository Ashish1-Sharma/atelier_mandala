import 'package:atelier_user/constraints/fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<void> addPurchaseItems(Map<String, dynamic> data) async {
    // try {
      // Create a batch for batch operations
      final batch = FirebaseFirestore.instance.batch();

      // Helper function to merge and update item details
      Future<void> processItems(List<dynamic> items, String collectionName) async {
        for (var item in items) {
          final itemId = item['id'].toString();
          final docRef = purchased.doc(uId).collection(collectionName).doc(itemId);
          final cartDocRef = cart.doc(uId).collection(collectionName).doc(itemId);

          // Check if the document exists in the purchased collection
          final docSnapshot = await docRef.get();
          if (docSnapshot.exists) {
            // Document exists, update the details
            final existingData = docSnapshot.data() ?? {};
            List<dynamic> existingTiming;

            if (existingData['timing'] is String) {
              // If timing is a String, convert it to a list
              existingTiming = [existingData['timing']];
            } else if (existingData['timing'] is List) {
              // If timing is a List, use it directly
              existingTiming = existingData['timing'];
            } else {
              // If timing is neither, initialize it as an empty list
              existingTiming = [];
            }

            // Check if the new timing already exists in the existingTiming list
            if (!existingTiming.contains(item['timing'])) {
              existingTiming.add(item['timing']);
            }

            final updatedData = {
              'quantity': (existingData['quantity'] ?? 0) + (item['quantity'] ?? 0),
              'timing': existingTiming,
              // Add or merge other fields as needed
            };

            batch.set(docRef, updatedData, SetOptions(merge: true));
          } else {
            // Document does not exist, create a new one
            batch.set(docRef, item);
          }
          // Delete the item from the cart
          batch.delete(cartDocRef);
        }
      }



      // Process takeaway items if available
      if (data['takeaway'] != null && data['takeaway'].isNotEmpty) {
        await processItems(data['takeaway'], 'takeaway');
      }

      // Process store items if available
      if (data['storeItems'] != null && data['storeItems'].isNotEmpty) {
        await processItems(data['storeItems'], 'store');
      }

      // Commit the batch if there are operations to perform
      await batch.commit();
    // } catch (e) {
    //   print("Error adding purchase items: $e");
    //   // Optionally: rethrow the exception or handle it according to your needs
    // }
  }


  static Future<int> checkCouponPrice(String coupon)async {
   try{
     final response = await purchased.doc(uId).collection("gift_cards").where('gId',isEqualTo: coupon).get();
     final result = response.docs.first.data()['gId'];
     if(result == ""){
       print(result);
       return result;
     } else{
       print("No price");
       return 0;
     }
   } catch (e){
     Get.snackbar('Alert', "Coupon code not exist");
     print(e);
     return 0;
   }
  }
}
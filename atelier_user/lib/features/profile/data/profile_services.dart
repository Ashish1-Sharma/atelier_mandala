import 'package:atelier_user/features/profile/data/profile_controller.dart';
import 'package:atelier_user/global/global_firebase.dart';
import 'package:atelier_user/global/global_models/workshop_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constraints/colors.dart';
import '../../../global/global_models/user_model.dart';
class ProfileServices{
  static Future<UserModel> get() async{
    final id = GlobalFirebase.auth.currentUser!.uid;
    final response = await GlobalFirebase.cloud.collection("Users").where('uid',isEqualTo: id).get();
    final data = response.docs;
    print(data.first.data());
    return UserModel.fromJson(data.first.data());
  }
  static Future<List<dynamic>> fetchWorkshops() async {
    // Create a list to store the results of each Future
    List<dynamic> results = [];

    // Create futures for each collection
    print("20% complete ---------------------------------");
    try{
      final id = GlobalFirebase.auth.currentUser!.uid;
      print("30% complete ---------------------------------");

      final QuerySnapshot response = await GlobalFirebase.cloud
          .collection("Users")
          .doc(id)
          .collection("purchasedItems")
          .doc(id)
          .collection("workshop")
          .get();
      print("40% complete ---------------------------------");
      for(var id in response.docs){
        // print();
        final workshopsFuture = await
        GlobalFirebase.cloud.collection('workshops').where('wId',isEqualTo: id.get('wId')).get();
          final workshopSnapshot = workshopsFuture;
          results.add(workshopSnapshot.docs.first);
      }
      // response.docs.map((doc) async {
      //       // print(doc.data());
      //   print(doc.data());
      //   print("-----------------------------");
      //       final wId = doc.get('wId');
      //       print(wId);
      //     //
      // });
    } catch (e){
      print("hello $e");
    }
    print(results.length);
    return results;
  }


  static Future<void> logOut() async {
    await GlobalFirebase.auth.signOut().then((value) {
      Get.snackbar("Success", "Successfully logged out",
          icon: Icon(Icons.gpp_good, color: AppColors.successColor),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
      Get.offAndToNamed("/login");
    },);
  }

}
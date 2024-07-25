import 'package:atelier_user/constraints/warnings.dart';
import 'package:atelier_user/features/authentication/data/auth_cache.dart';
import 'package:atelier_user/features/authentication/data/auth_controller.dart';
import 'package:atelier_user/global/global_models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constraints/colors.dart';
import '../../../global/global_firebase.dart';

class AuthService {

  static Future<void> createUser(String name, String email, String pass) async {
    AuthController.isProcessing.value = true;
    try {
      await GlobalFirebase.auth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then(
        (value) async {
          final id = GlobalFirebase.auth.currentUser!.uid;
          await GlobalFirebase.cloud
              .collection('Users')
              .doc(id)
              .set(UserModel(name: name, email: email, uid: id, img: "", wIds: [], tIds: [], sIds: [], gIds: []).toJson())
              .then(
            (value) {
              AuthController.isProcessing.value = false;
              AuthCache.saveUserData(GlobalFirebase.auth.currentUser!.uid, email, name);
              Warnings.onSuccess("now you can use your email to login in user panel");
            },
          );
        },
      );
    } on FirebaseException catch (e) {
      AuthController.isProcessing.value =
      false;
      // print(e);
      String cleanedErrorMessage = e.toString().replaceAll(RegExp(r'\[.*\)\]'), '');

      print(cleanedErrorMessage);
      Warnings.onError("$cleanedErrorMessage");
    }
  }

   static Future<void> loginUser(String email,String pass) async{
     AuthController.isProcessing.value = true;
     try{
       GlobalFirebase.auth.signInWithEmailAndPassword(email: email, password: pass)
           .then(
             (value) async {
               // print(GlobalFirebase.auth.currentUser!.metadata);
               final result = await GlobalFirebase.cloud.collection("Users").where("uid" ,isEqualTo: GlobalFirebase.auth.currentUser!.uid).get();
               final json = result.docs.first.data();
               final name = json['name'];
               print(name);
           AuthCache.saveUserData(
               GlobalFirebase.auth.currentUser!.uid,
               email,
               name);
         },
       ).onError((error, stackTrace) {
        Warnings.onError("Something is wrong");
       },);
       // AuthController.isProcessing.value = false;
     } on FirebaseException catch (e){
       print(e);
     }
   }

   static Future<void> checkUser() async {
    await GlobalFirebase.auth;
   }
   static Future<void> logOut()async {
    await GlobalFirebase.auth.signOut();
   }
}

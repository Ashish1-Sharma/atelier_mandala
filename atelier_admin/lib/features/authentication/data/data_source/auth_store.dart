import 'dart:convert';

import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/profile/controller/profile_controller.dart';
import 'package:atelier_admin/global_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constraints/colors.dart';

class AuthStore {

  static Future<void> createUser(String email, String pass) async {
    await GlobalFirebase.auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then(
      (value) async {
        await GlobalFirebase.cloud.collection('FakeUsers').doc(DateTime.timestamp().millisecondsSinceEpoch.toString()).set(
            {
              'email' : email,
            });
        final collection = GlobalFirebase.cloud.collection("Admin");
        // final result = collection.doc("v5cdYxiiK8ynTbMB8spH").get();
        Get.snackbar("stranger email detected", "now you can use your email to login in user panel",
            icon: Icon(Icons.gpp_good, color: AppColors.successColor),
            snackPosition: SnackPosition.TOP,
            snackStyle: SnackStyle.FLOATING);
        login(email, pass);
      },
    );
  }

  static Future<void> login(String email, String password) async {
    try {
      await GlobalFirebase.auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) async {
          // print(value);
          print("signin successfully no need to worry about it . now just checking you are admin or not");
          GlobalFirebase.cloud
              .collection("Admin")
              .doc("v5cdYxiiK8ynTbMB8spH")
              .get()
              .then(
            (value) {
              print("from now on i will check are you admin or not ?");
              if (value.data()?['email'] == email.toLowerCase()) {

                Get.snackbar("hello", "your email matches the admin email",
                    icon: Icon(Icons.gpp_good, color: AppColors.successColor),
                    snackPosition: SnackPosition.TOP,
                    snackStyle: SnackStyle.FLOATING);

                Get.offAndToNamed("/home");
              }
            },
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Get.snackbar(
          "login error",
          e.message?.replaceAll(RegExp(r'\(.*?\)'), '') ??
              'Unknown error occurred.',
          icon: Icon(Iconsax.danger, color: Colors.red),
          snackPosition: SnackPosition.TOP,
          snackStyle: SnackStyle.FLOATING);
      createUser(email, password);
    }
  }


  static Future<void> checkCurrUser() async {
    final currEmail = GlobalFirebase.auth.currentUser?.email;
    final result = await GlobalFirebase.cloud.collection("Admin").doc("v5cdYxiiK8ynTbMB8spH").get();
    final adminEmail = result.data()?['email'];
    print("${adminEmail} and ${currEmail}");
    if(adminEmail == currEmail){
      Get.offAllNamed("/home");
    } else{
      Get.offAllNamed("/login");
    }
  }
}

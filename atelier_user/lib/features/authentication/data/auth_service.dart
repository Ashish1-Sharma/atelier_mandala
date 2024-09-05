import 'package:atelier_user/constraints/warnings.dart';
import 'package:atelier_user/features/authentication/data/auth_cache.dart';
import 'package:atelier_user/features/authentication/data/auth_controller.dart';
import 'package:atelier_user/global/global_models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
              .set(UserModel(name: name, email: email, uid: id, img: "").toJson())
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
               Get.offAllNamed('/home');
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


  static Future<void> handleSignin() async {
    try {
      // Sign out the current user (if necessary)
      await GoogleSignIn().signOut();

      // Sign in with Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        // Obtain the auth details from the Google sign-in
        final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

        // Create a new credential using the Google sign-in authentication
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Check if the user already exists in Firestore
        final String email = googleUser.email;
        final QuerySnapshot userSnapshot = await GlobalFirebase.cloud
            .collection('Users')
            .where('email', isEqualTo: email)
            .get();

        // if (userSnapshot.docs.isNotEmpty) {
        //   // If user already exists, show a popup
        //   // Get.dialog(
        //   //   AlertDialog(
        //   //     title: Text('User Already Exists'),
        //   //     content: Text('An account with this email already exists. Please sign in directly.'),
        //   //     actions: [
        //   //       TextButton(
        //   //         onPressed: () {
        //   //           Get.back(); // Close the dialog
        //   //         },
        //   //         child: Text('OK'),
        //   //       ),
        //   //     ],
        //   //   ),
        //   // );
        //   // return; // Stop the sign-in process
        // }

        // If user does not exist, continue with Google sign-in
        final UserCredential userCredential = await GlobalFirebase.auth.signInWithCredential(credential);

        final user = userCredential.user;
        if (user != null) {
          // User signed in successfully, create a new record in Firestore
          final String uid = user.uid;
          final String name = user.displayName ?? '';

          final userModel = UserModel(name: name, email: email, uid: uid, img: "");
          await GlobalFirebase.cloud
              .collection('Users')
              .doc(uid)
              .set(userModel.toJson())
              .then((value) {
            AuthController.isProcessing.value = false;
            AuthCache.saveUserData(uid, email, name);
            Warnings.onSuccess("Now you can use your email to log in to the user panel");
          });

          // Navigate to the main page after successful sign-in
          Get.offAndToNamed('/home');
        }
      } else {
        // User canceled the Google sign-in process
        print('Google Sign-In canceled.');
      }
    } catch (e) {
      print(e);
    }
  }

}

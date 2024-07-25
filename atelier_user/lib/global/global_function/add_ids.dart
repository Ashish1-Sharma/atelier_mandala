import 'package:atelier_user/global/global_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddIds {
  static Future<void> toWorkshop(String id)async {
    await GlobalFirebase.cloud.collection("Users").doc(GlobalFirebase.auth.currentUser!.uid).update(
      {
        'wIds' : FieldValue.arrayUnion([id])
      }
    );
  }
  static Future<void> toTakeaway(String id)async {
    await GlobalFirebase.cloud.collection("Users").doc(GlobalFirebase.auth.currentUser!.uid).update(
      {
        'tIds' : FieldValue.arrayUnion([id])
      }
    );
  }
  static Future<void> toStore(String id)async {
    await GlobalFirebase.cloud.collection("Users").doc(GlobalFirebase.auth.currentUser!.uid).update(
      {
        'sIds' : FieldValue.arrayUnion([id])
      }
    );
  }
}
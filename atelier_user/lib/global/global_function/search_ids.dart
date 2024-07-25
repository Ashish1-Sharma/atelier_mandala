import 'package:cloud_firestore/cloud_firestore.dart';

import '../global_firebase.dart';

class SearchIds{
  static Future<bool?> fromWorkshop(String id)async {
    final result = await GlobalFirebase.cloud.collection("Users").doc(GlobalFirebase.auth.currentUser!.uid).get();
    final response = result.data();
    final List<dynamic>? list = response?['wIds'];
    // print(list.contains(id));
    return list?.contains(id);
  }
  static Future<bool> fromTakeaway(String id)async {
    final result = await GlobalFirebase.cloud.collection("Users").doc(GlobalFirebase.auth.currentUser!.uid).get();
    final response = result.data();
    final List<dynamic> list = response?['tIds'];
    // print(list.contains(id));
    return list.contains(id);
  }
  static Future<bool> fromStore(String id)async {
    final result = await GlobalFirebase.cloud.collection("Users").doc(GlobalFirebase.auth.currentUser!.uid).get();
    final response = result.data();
    final List<dynamic> list = response?['sIds'];
    // print(list.contains(id));
    return list.contains(id);
  }
}
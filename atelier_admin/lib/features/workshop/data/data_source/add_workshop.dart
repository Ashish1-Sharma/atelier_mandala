import 'package:atelier_admin/global_firebase.dart';

import '../models/workshop_model.dart';

class AddWorkshop{
  static Future<void> pushData(WorkshopModel model,String id) async {
     await GlobalFirebase.cloud.collection("workshops").doc(id).set(model.toMap()).then((value) {
       print("successfully uploaded");
     },);
  }
}
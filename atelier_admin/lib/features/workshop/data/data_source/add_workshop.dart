import 'package:atelier_admin/global_firebase.dart';

import '../models/workshop_model.dart';

class AddWorkshop{
  static Future<void> pushData(WorkshopModel model) async {
     await GlobalFirebase.cloud.collection("workshops").doc(DateTime.now().millisecondsSinceEpoch.toString()).set(model.toMap()).then((value) {
       print("successfully uploaded");
     },);
  }

}
import 'package:atelier_admin/features/store/data/models/store_model.dart';

import '../../../../global_firebase.dart';

class AddStore{
  static Future<void> pushData(StoreModel model) async {
    await GlobalFirebase.cloud.collection("store").doc(DateTime.now().millisecondsSinceEpoch.toString()).set(model.toMap()).then((value) {
      print("successfully uploaded");
    },);
  }

}
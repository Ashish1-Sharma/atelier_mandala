import 'package:atelier_admin/features/takeways/data/models/takeaway_item_model.dart';

import '../../../../global_firebase.dart';
import '../models/takeaway_model.dart';

class AddTakeaway{
  static Future<void> pushData(TakeawayModel model,String id) async {
    await GlobalFirebase.cloud.collection("takeaway").doc(id).set(model.toJson()).then((value) {
      print("successfully uploaded");
    },);
  }
  static Future<void> itemIds(TakeawayModel model,TakeawayItemModel itemModel) async {
    await GlobalFirebase.cloud.collection("takeaway").doc(model.tId.toString()).collection("Item_ids").doc(itemModel.code).set(model.toJson()).then((value) {
      print("successfully uploaded");
    },);
  }
}
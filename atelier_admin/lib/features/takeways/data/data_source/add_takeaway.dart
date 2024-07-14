import '../../../../global_firebase.dart';
import '../models/takeaway_model.dart';

class AddTakeaway{
  static Future<void> pushData(TakeawayModel model) async {
    await GlobalFirebase.cloud.collection("takeaway_orders").doc(DateTime.now().millisecondsSinceEpoch.toString()).set(model.toJson()).then((value) {
      print("successfully uploaded");
    },);
  }
}
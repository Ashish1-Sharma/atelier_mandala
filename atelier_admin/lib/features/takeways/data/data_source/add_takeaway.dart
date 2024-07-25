import '../../../../global_firebase.dart';
import '../models/takeaway_model.dart';

class AddTakeaway{
  static Future<void> pushData(TakeawayModel model,String id) async {
    await GlobalFirebase.cloud.collection("takeaway").doc(id).set(model.toJson()).then((value) {
      print("successfully uploaded");
    },);
  }
}
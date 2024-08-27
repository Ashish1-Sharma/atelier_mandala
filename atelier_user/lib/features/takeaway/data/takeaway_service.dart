import '../../../global/global_firebase.dart';
import '../../../global/global_models/takeaway_model.dart';

class TakeawayService{
  static Future<List<TakeawayModel>> fetchTakeaways() async {
    final snapshot = await GlobalFirebase.cloud.collection('takeaway').get();
    final documents = snapshot.docs;
    return List.generate(documents.length, (index) {
      final docSnapshot = documents[index];
      final model = TakeawayModel.fromMap(docSnapshot.data());
      return model;
    });
  }
}
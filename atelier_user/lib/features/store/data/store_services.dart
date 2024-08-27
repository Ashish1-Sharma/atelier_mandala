import 'package:atelier_user/global/global_firebase.dart';
import 'package:atelier_user/global/global_models/store_model.dart';

class StoreServices{
  static Future<List<StoreModel>> fetchStoreItems() async{
    final snapshot = await GlobalFirebase.cloud.collection('store').get();
    final documents = snapshot.docs;
    return List.generate(documents.length, (index) {
      final docSnapshot = documents[index];
      final model = StoreModel.fromMap(docSnapshot.data());
      return model;
    },);

  }
}
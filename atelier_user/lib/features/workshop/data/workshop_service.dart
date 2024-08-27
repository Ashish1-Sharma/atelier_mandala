import 'package:atelier_user/global/global_models/workshop_model.dart';

import '../../../global/global_firebase.dart';

class WorkshopService{
  static Future<List<WorkshopModel>> fetchWorkshops() async {
    final snapshot = await GlobalFirebase.cloud.collection('workshops').where('isPublic',isEqualTo: true).get();
    final documents = snapshot.docs;
    return List.generate(documents.length, (index) {
      final docSnapshot = documents[index];
      final model = WorkshopModel.fromMap(docSnapshot.data());
      return model;
    });
  }
}
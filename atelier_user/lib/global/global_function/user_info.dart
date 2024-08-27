import 'package:atelier_user/global/global_firebase.dart';
import 'package:atelier_user/global/global_models/user_model.dart';

class UserInfo{
  static Future<UserModel> get() async{
    final id = GlobalFirebase.auth.currentUser!.uid;
   final response = await GlobalFirebase.cloud.collection("Users").where('uid',isEqualTo: id).get();
    final data = response.docs;
    print(data.first.data());
    return UserModel.fromJson(data.first.data());
  }
}
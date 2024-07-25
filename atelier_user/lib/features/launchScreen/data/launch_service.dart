import 'package:get/get.dart';

import '../../../constraints/warnings.dart';
import '../../../global/global_firebase.dart';

class LaunchService{
  static Future<bool> checkUser() async {
    final value = GlobalFirebase.auth.currentUser.isBlank;
    print(value);
    if(value == null){
      return false;
    } else{
      return !value;
    }
  }
}
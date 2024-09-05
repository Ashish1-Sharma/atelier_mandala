import 'package:get/get.dart';

import '../../../constraints/warnings.dart';
import '../../../global/global_firebase.dart';

class LaunchService {
  static Future<bool> checkUser() async {
    final user = GlobalFirebase.auth.currentUser;
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }
}
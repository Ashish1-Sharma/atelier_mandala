import 'package:shared_preferences/shared_preferences.dart';

class AuthCache{
  static Future<void> saveUserData(String uid,String email,String name)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("name", name);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("uid", uid);
    // sharedPreferences.setStringList("wIds", []);
    // sharedPreferences.setStringList("tIds", []);
    // sharedPreferences.setStringList("sIds", []);
    // sharedPreferences.setStringList("gIds", []);
  }
  static Future<void> removeUserData(String uid,String email,String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('name');
    sharedPreferences.remove('email');
    sharedPreferences.remove('uid');
    // sharedPreferences.remove("wIds");
    // sharedPreferences.remove("tIds");
    // sharedPreferences.remove("sIds");
    // sharedPreferences.remove("gIds");
  }
  // static Future<void> updateUserData(String uid,String email,String name)async {
  //
  // }
}
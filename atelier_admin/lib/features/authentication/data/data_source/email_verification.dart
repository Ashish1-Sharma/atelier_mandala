import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';

class EmailVerification{
  // static EmailAuth emailAuth = EmailAuth(sessionName: "ashish sharma");
 static Future<bool> sendOtp(TextEditingController emailController) async {
   bool result = await EmailOTP.sendOTP(email: emailController.text);
   return result ;
 }

 static Future<bool> checkOtp(String otp)async {
   print("checkking start now");
   bool result = await EmailOTP.verifyOTP(otp: otp);
   print(result);
   return result;
 }


}
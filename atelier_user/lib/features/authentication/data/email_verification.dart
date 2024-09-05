import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';

class EmailVerification {
  // static EmailAuth emailAuth = EmailAuth(sessionName: "ashish sharma");
  static Future<void> sendOtpToEmail(String userEmail) async {
    // Configure the EmailOTP package
    EmailOTP.config(
      appEmail: 'test@gmail.com',
      appName: 'atelier',
      emailTheme: EmailTheme.v1,
      otpLength: 4,
      otpType: OTPType.numeric,
    );

    // Set the SMTP server details
    EmailOTP.setSMTP(
      host: 'smtp.gmail.com',
      emailPort: EmailPort.port587,  // Use port 587 for TLS
      secureType: SecureType.tls,    // Use TLS for encryption
      username: '2101270100023@iimtindia.net',
      password: 'apjwukewtncrqlie',  // Ensure this is your Gmail App Password
    );

    // Send OTP to the specified email address
    bool result = await EmailOTP.sendOTP(email: userEmail);

    // Handle the result
    if (result) {
      print("✅ OTP sent successfully to $userEmail");
    } else {
      print("❌ Failed to send OTP to $userEmail");
    }
  }

  static Future<bool> checkOtp(String otp) async {
    print("checking start now");
    bool result = await EmailOTP.verifyOTP(otp: otp);
    print(result);
    return result;
  }
}

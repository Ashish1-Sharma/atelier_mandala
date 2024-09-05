import 'package:atelier_user/features/authentication/presentation/screens/forget_password.dart';
import 'package:atelier_user/features/authentication/presentation/screens/log_in.dart';
import 'package:atelier_user/features/authentication/presentation/screens/sign_up.dart';
import 'package:atelier_user/features/checkout/data/stripe_service.dart';
import 'package:atelier_user/features/homepage/presentation/screens/home_page_screen.dart';
import 'package:atelier_user/features/launchScreen/presentation/launch_screen.dart';
import 'package:atelier_user/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:atelier_user/features/splash/presentation/screens/splash_screen.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/workshop_page.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'constraints/constants.dart';
import 'dependency_injection.dart';
import 'firebase_options.dart';


//  recovery code for twilio ZJT6QZSM9UULCWXUPG48KHF7 SMTP server
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // StripeService.init();
  // Stripe.publishableKey = "pk_test_51BTUDGJAJfZb9HEBwDg86TN1KNprHjkfipXmEDMb0gSCassK5T3ZfxsAbcgKVmAIXF7oZ6ItlZZbXO6idTHE67IM007EwQ4uN3";
  Stripe.publishableKey = "pk_test_51K3MhlBE3pq73oUMGjRV8bv2m1bK8HLT2idleBy8RQWDZQDM4ypg7t9WRKEHx9hS8yJmB4RttRWMwiXaTz4k7ITx00r7dTzuu4";
  EmailOTP.config(
      appEmail: 'wwwviveksharma45@gmail.com',
      appName: 'atelier',
      emailTheme: EmailTheme.v1,
      otpLength: 4,
      otpType: OTPType.numeric,
    
  );
  EmailOTP.setSMTP(
    host: 'smtp.gmail.com',
    emailPort: EmailPort.port587,  // Use port 587 for TLS
    secureType: SecureType.tls,    // Use TLS for encryption
    username: '2101270100023@iimtindia.net',
    password: 'apjwukewtncrqlie',  // Ensure this is your Gmail App Password
  );

  // WidgetsBinding.instance.addPostFrameCallback;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Get.put(Controller());
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Get.to('/login')
  // Get.to(()=>LoginScreen());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // theme: Them,
      debugShowCheckedModeBanner: false,
      title: 'Atelier mandala',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/login',page: () => const LogIn()),
        GetPage(name: '/signup',page: () => const SignUp()),
        GetPage(name: '/forget',page: () => const ForgetPassword()),
        GetPage(name: '/home',page: () => const HomePageScreen()),
        GetPage(name: '/edit_profile',page: () => const EditProfileScreen()),
      ],
      home: LaunchScreen(),
    );
  }
}


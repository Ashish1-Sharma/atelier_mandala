import 'package:atelier_user/features/authentication/presentation/screens/forget_password.dart';
import 'package:atelier_user/features/authentication/presentation/screens/log_in.dart';
import 'package:atelier_user/features/authentication/presentation/screens/sign_up.dart';
import 'package:atelier_user/features/homepage/presentation/screens/home_page_screen.dart';
import 'package:atelier_user/features/launchScreen/presentation/launch_screen.dart';
import 'package:atelier_user/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:atelier_user/features/splash/presentation/screens/splash_screen.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/workshop_page.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'firebase_options.dart';


//  recovery code for twilio ZJT6QZSM9UULCWXUPG48KHF7 SMTP server
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EmailOTP.config(
    appName: 'Ateliea Mandala',
    otpType: OTPType.numeric,
    emailTheme: EmailTheme.v2,
  );
  WidgetsBinding.instance.addPostFrameCallback;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Get.put(Controller());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Atelier mandala',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/login',page: () => const LogIn()),
        GetPage(name: '/signup',page: () => const SignUp()),
        GetPage(name: '/forget',page: () => const ForgetPassword()),
        GetPage(name: '/home',page: () => const HomePageScreen()),
        // GetPage(name: '/open_workshop_page',page: () => const WorkshopPage(img: '',)),
        GetPage(name: '/edit_profile',page: () => const EditProfileScreen()),
        // GetPage(name: '/create_workshop',page: () => const CreateNewWorkshop()),
        // // GetPage(name: '/users',page: () => const UserPageScreen()),
        // // GetPage(name: '/payment',page: () => const PaymentScreen()),
        // GetPage(name: '/takeaway',page: () => const TakeawayScreen()),
        // GetPage(name: '/create_takeaway',page: () => const CreateNewTakeaway()),
        // GetPage(name: '/gift',page: () => const GiftCardScreen()),
        // GetPage(name: '/create_gift_card',page: () => const CreateNewGiftCard()),
        // GetPage(name: '/create_store_item',page: () => const CreateNewStoreItem()),
        // GetPage(name: '/store',page: () => const StoreScreen()),
        // GetPage(name: '/edit_profile',page: () => const EditProfile()),
        // GetPage(name: '/create_user',page: () => const CreateUsers()),
      ],
      home: LaunchScreen(),
    );
  }
}


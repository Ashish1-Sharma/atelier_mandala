import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:atelier_admin/features/authentication/presentation/screens/login_screen.dart';
import 'package:atelier_admin/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:atelier_admin/features/giftCards/presentation/screens/giftcard_screen.dart';
import 'package:atelier_admin/features/giftCards/presentation/widgets/create_new_gift_card.dart';
import 'package:atelier_admin/features/homepage/presentation/Homepage_Screen.dart';
import 'package:atelier_admin/features/payments/presentation/screens/Payment_screen.dart';
import 'package:atelier_admin/features/profile/presentation/screens/edit_profile.dart';
import 'package:atelier_admin/features/store/presentation/screens/Store_screen.dart';
import 'package:atelier_admin/features/store/presentation/widgets/create_new_store_item.dart';
import 'package:atelier_admin/features/takeways/presentation/screens/takeaway_screen.dart';
import 'package:atelier_admin/features/takeways/presentation/widgets/create_new_takeaway.dart';
import 'package:atelier_admin/features/users/presentation/screens/user_page_screen.dart';
import 'package:atelier_admin/features/workshop/presentation/screens/workshop_screen.dart';
import 'package:atelier_admin/features/workshop/presentation/widgets/create_new_workshop.dart';
import 'package:atelier_admin/root_app.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'features/dashboard/presentation/widgets/create_users.dart';
import 'firebase_options.dart';


//  recovery code for twilio ZJT6QZSM9UULCWXUPG48KHF7 SMTP server
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EmailOTP.config(
    appName: 'Ateliea Mandala',
    otpType: OTPType.numeric,
    emailTheme: EmailTheme.v2,
  );
  // WidgetsBinding.instance.addPostFrameCallback;
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
      // theme: ThemeData(
      //   primarySwatch: Colors.orange,
      // ),
      getPages: [
        GetPage(name: '/login',page: () => const LoginScreen()),
        GetPage(name: '/forget',page: () => const ForgetPasswordScreen()),
        GetPage(name: '/home',page: () => const HomePage()),
        GetPage(name: '/workshop',page: () => const WorkshopScreen()),
        // GetPage(name: '/create_workshop',page: () => const CreateNewWorkshop()),
        // GetPage(name: '/users',page: () => const UserPageScreen()),
        // GetPage(name: '/payment',page: () => const PaymentScreen()),
        GetPage(name: '/takeaway',page: () => const TakeawayScreen()),
        // GetPage(name: '/create_takeaway',page: () => const CreateNewTakeaway()),
        GetPage(name: '/gift',page: () => const GiftCardScreen()),
        GetPage(name: '/create_gift_card',page: () => const CreateNewGiftCard()),
        GetPage(name: '/create_store_item',page: () => const CreateNewStoreItem()),
        GetPage(name: '/store',page: () => const StoreScreen()),
        GetPage(name: '/edit_profile',page: () => const EditProfile()),
        GetPage(name: '/create_user',page: () => const CreateUsers()),
      ],
      home: RootApp(),
    );
  }
}


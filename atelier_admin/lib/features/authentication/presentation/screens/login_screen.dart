import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomButton.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.2,
                ),
                Text(
                  "Welcome back",
                  style: AppTextStyles.h1(color: Colors.black),
                ),
                SizedBox(
                  height: Get.height * 0.013,
                ),
                Text(
                  "Welcome back. "
                  "Enter your credentials to access your account",
                  style: AppTextStyles.bodyBig(color: AppColors.black3),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Email Address",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                CustomField(
                  txt: "hello@example.com",
                  controller: email,
                  validator: (e) {
                    return null;
                  },
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  "Password",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                CustomField(
                  icon: Iconsax.eye,
                  txt: "Password",
                  controller: password,
                  validator: (e) {
                    return null;
                  },
                ),
                SizedBox(
                  height: Get.height * 0.007,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, child: Text("Forget Password",style: AppTextStyles.bodySmallest(color: AppColors.infoColor),)),
                  ],
                ),
                CustomButton()


              ],
            ),
          ),
        ),
      ),
    );
  }
}

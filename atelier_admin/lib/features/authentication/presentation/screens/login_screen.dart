import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/authentication/data/data_source/auth_store.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomButton.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomField.dart';
import 'package:atelier_admin/global_widgets/custom_normal_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constraints/space.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      body: SafeArea(
        child: Form(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Space.spacer(0.2),
                Text(
                  "Welcome back",
                  style: AppTextStyles.h1(color: Colors.black),
                ),
                // Space.h2,
                Space.spacer(0.01),
                Text(
                  "Welcome back. "
                  "Enter your credentials to access your account",
                  style: AppTextStyles.bodyMain16(color: AppColors.black3),
                ),
                Space.spacer(0.05),
                Text(
                  "Email Address",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                Space.spacer(0.006),
                CustomNormalTextField(controller: email, hint: "hello@gmail.com"),
                Space.spacer(0.02),
                Text(
                  "Password",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                Space.spacer(0.006),
                CustomField(
                  icon1: Iconsax.eye,
                  icon2: Iconsax.eye_slash,
                  txt: "Password",
                  controller: password,
                  validator: (e) {
                    return null;
                  },
                ),
                Space.spacer(0.004),
                // Space.h3,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){
                      Get.toNamed('/forget');
                    }, child: Text("Forget Password",style: AppTextStyles.bodySmallest(color: AppColors.infoColor),)),
                  ],
                ),
                Space.spacer(0.004),

                CustomButton(str: "Sign In",onPressed: (){
                  AuthStore.login(email.text,password.text).then((value) {

                  },);
                },)


              ],
            ),
          ),
        ),
      ),
    );
  }
}

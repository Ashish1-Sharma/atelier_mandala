import 'package:atelier_user/constraints/warnings.dart';
import 'package:atelier_user/features/authentication/data/auth_cache.dart';
import 'package:atelier_user/features/authentication/data/auth_service.dart';
import 'package:atelier_user/features/authentication/presentation/widgets/custom_auth_icon.dart';
import 'package:atelier_user/global/global_firebase.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_widgets/custom_normal_text_field.dart';
import '../widgets/custom_field.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space.spacer(0.2),
                  Text(
                    "Welcome back",
                    style: AppTextStyles.h1(color: AppColors.tertiaryColor),
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
                    style: AppTextStyles.bodySmall(color: AppColors.black2),
                  ),
                  Space.spacer(0.006),
                  CustomNormalTextField(
                      controller: email, hint: "hello@gmail.com"),
                  Space.spacer(0.02),
                  Text(
                    "Password",
                    style: AppTextStyles.bodySmall(color: AppColors.black2),
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
                      TextButton(
                          onPressed: () {
                            Get.toNamed('/forget');
                          },
                          child: Text(
                            "Forget Password",
                            style: AppTextStyles.bodySmallest(
                                color: AppColors.infoColor),
                          )),
                    ],
                  ),
                  Space.spacer(0.004),
                  Container(
                      width: double.infinity,
                      child: CustomElevatedButton(
                          backColor: AppColors.tertiaryColor,
                          txtColor: AppColors.black6,
                          txt: "Log In",
                          onPressed: () {
                            // AuthService.logOut();
                            AuthService.loginUser(
                                    email.text ?? "", password.text ?? "").then((value) {
                              Get.offAndToNamed('/home');
                                    },);

                          })),
                  Space.spacer(0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Or Login With",
                        style:
                            AppTextStyles.bodySmallest(color: AppColors.black2),
                      ),
                    ],
                  ),
                  Space.spacer(0.02),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAuthIcon(icon: "Facebook"),
                      CustomAuthIcon(icon: "Google"),
                      CustomAuthIcon(icon: "Apple"),
                    ],
                  ),
                  Space.spacer(0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account ? ",
                        style: AppTextStyles.bodySmallNormal(
                            color: AppColors.black3),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/signup');
                        },
                        child: Text(
                          "Sign up here",
                          style: AppTextStyles.bodySmall(
                              color: AppColors.infoColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

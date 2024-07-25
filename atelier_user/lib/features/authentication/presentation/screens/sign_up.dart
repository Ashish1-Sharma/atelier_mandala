import 'package:atelier_user/constraints/warnings.dart';
import 'package:atelier_user/features/authentication/data/auth_controller.dart';
import 'package:atelier_user/features/authentication/data/auth_service.dart';
import 'package:atelier_user/features/authentication/presentation/widgets/custom_auth_icon.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_widgets/custom_normal_text_field.dart';
import '../widgets/custom_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
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
          key: formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space.spacer(0.1),
                  Text(
                    "Create an Account",
                    style: AppTextStyles.h1(color: AppColors.tertiaryColor),
                  ),
                  // Space.h2,
                  Space.spacer(0.01),
                  Text(
                    "We are happy to welcome you to this platform",
                    style: AppTextStyles.bodyBigNormal(color: AppColors.black3),
                  ),
                  Space.spacer(0.05),
                  Text(
                    "Full Name",
                    style: AppTextStyles.bodySmall(color: AppColors.black2),
                  ),
                  Space.spacer(0.006),
                  CustomNormalTextField(controller: name, hint: "Full Name"),
                  Space.spacer(0.02),
                  Text(
                    "Email Address",
                    style: AppTextStyles.bodySmall(color: AppColors.black2),
                  ),
                  Space.spacer(0.006),
                  CustomNormalTextField(
                    controller: email,
                    hint: "hello@gmail.com",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      final RegExp emailRegExp =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
                      if (!emailRegExp.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null; //
                    },
                  ),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is empty';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                    },
                  ),
                  Space.spacer(0.01),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: AuthController.isChecked.value,
                          activeColor: AppColors.brandColor,
                          onChanged: (bool? value) {
                            AuthController.isChecked.value =
                                !AuthController.isChecked.value;
                          },
                        ),
                      ),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "By creating an account , you aggree to our ",
                                style: AppTextStyles.bodySmallest(
                                    color: AppColors.black3),
                              ),
                              TextSpan(
                                text: "Term and Conditions",
                                style: AppTextStyles.bodySmallest(
                                    color: AppColors.infoColor),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Space.spacer(0.02),
                  Obx(
                    () => Container(
                        width: double.infinity,
                        child: AuthController.isProcessing.value
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.brandColor,
                                ),
                                child: const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                )))
                            : CustomElevatedButton(
                                backColor: AppColors.brandColor,
                                txtColor: AppColors.black6,
                                txt: "Create an Account",
                                onPressed: () {
                                  AuthController.isProcessing.value = true;
                                  if (name.text.isEmpty ||
                                      email.text.isEmpty ||
                                      password.text.isEmpty) {
                                    Warnings.onError("Field is Empty.");
                                  } else {
                                    if (formKey.currentState!.validate()) {
                                      if (AuthController.isChecked.value) {
                                        AuthController.isProcessing.value =
                                        true;
                                        AuthService.createUser(name.text,
                                                email.text, password.text)
                                            .then(
                                          (value) {
                                            Get.offAndToNamed('/login');
                                            TextInput.finishAutofillContext();
                                          },
                                        ).onError(
                                          (error, stackTrace) {
                                            AuthController.isProcessing.value =
                                                false;
                                            Warnings.onError('$error');
                                          },
                                        );
                                      } else {
                                        Warnings.onError(
                                            "Please accept our terms and Conditions.");
                                      }
                                    } else {
                                      Warnings.onError("Something is wrong.");
                                    }
                                  }
                                })),
                  ),
                  Space.spacer(0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Or Signup With",
                        style:
                            AppTextStyles.bodySmallest(color: AppColors.black2),
                      ),
                    ],
                  ),
                  Space.spacer(0.03),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAuthIcon(icon: "Facebook"),
                      CustomAuthIcon(icon: "Google"),
                      CustomAuthIcon(icon: "Apple"),
                    ],
                  ),
                  Space.spacer(0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an Account ? ",
                        style:
                            AppTextStyles.bodySmallest(color: AppColors.black3),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAndToNamed('/login');
                        },
                        child: Text(
                          "Sign in here",
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

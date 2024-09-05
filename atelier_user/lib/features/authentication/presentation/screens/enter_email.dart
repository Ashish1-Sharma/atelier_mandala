import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../global/global_widgets/custom_elevated_button.dart';
import '../../../../global/global_widgets/custom_normal_text_field.dart';
import '../../data/email_verification.dart';
import '../widgets/custom_field.dart';

class EnterEmail extends StatefulWidget {
  final PageController controller;

  const EnterEmail({super.key, required this.controller});

  @override
  State<EnterEmail> createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.1,
            ),
            Text(
              "Please enter your email",
              style: AppTextStyles.h1(color: AppColors.tertiaryColor),
            ),
            SizedBox(
              height: Get.height * 0.013,
            ),
            Text(
              "We will send you a confirmation email",
              style: AppTextStyles.bodyBigNormal(color: AppColors.black3),
            ),
            SizedBox(
              height: Get.height * 0.06,
            ),
            Text(
              "Email Address",
              style: AppTextStyles.bodySmall(color: AppColors.black2),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            CustomNormalTextField(
                controller: email, hint: "hello@gmail.com"),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Container(
              width: double.infinity,
              child: CustomElevatedButton(
                  backColor: AppColors.tertiaryColor,
                  txtColor: AppColors.black6,
                  txt: "Continue",
                  onPressed: () {
                    EmailVerification.sendOtpToEmail(email.text.trim()).then(
                          (value) {
                        // if (value) {
                        //   print(value);
                        //   widget.controller.animateToPage(1, duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
                        //
                        // } else {
                        //   Get.snackbar("Error", "Try again sometime",
                        //       icon: const Icon(Icons.dangerous, color: AppColors.errorColor),
                        //       snackPosition: SnackPosition.TOP,
                        //       snackStyle: SnackStyle.FLOATING);
                        // }
                      },
                    );

                     }),
            )
          ],
        ),
      ),

    );
  }
}

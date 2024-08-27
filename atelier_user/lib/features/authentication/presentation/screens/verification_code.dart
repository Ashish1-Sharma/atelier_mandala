import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../widgets/otp_fields.dart';

class VerificationCode extends StatefulWidget {
  final PageController controller;

  const VerificationCode({super.key, required this.controller});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
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
              height: Get.height * 0.2,
            ),
            Text(
              "Authentication code",
              style: AppTextStyles.h1(color: AppColors.tertiaryColor),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            RichText(
                text: TextSpan(
                    text: "We have sent a verification code to your mail\t",
                    style: AppTextStyles.bodyBigNormal(color: AppColors.black3),
                    children: [
                  TextSpan(
                    text: "wwwviveksharma45@gmail.com",
                    style: AppTextStyles.bodySmall(color: AppColors.black1),
                  )
                ])),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const CustomInputFields(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Resend code 00:30",
                      style: AppTextStyles.bodySmallest(
                          color: AppColors.infoColor),
                    )),
              ],
            ),
            Container(
              width: double.infinity,
              child: CustomElevatedButton(
                  backColor: AppColors.tertiaryColor,
                  txtColor: AppColors.black6,
                  txt: "Confirm",
                  onPressed: () {

                    widget.controller.animateToPage(2, duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

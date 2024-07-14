import 'package:atelier_admin/features/authentication/data/auth_controller.dart';
import 'package:atelier_admin/features/authentication/data/data_source/email_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomInputFields.dart';

class VerificationScreen extends StatefulWidget {
  final PageController pageController;
  final TextEditingController controller;

  const VerificationScreen({super.key,required this.pageController, required this.controller});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthController.otp.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              height: Get.height * 0.01,
            ),
            RichText(text: TextSpan(
              text: "We have sent a verification code to your mail",
                style: AppTextStyles.bodyBig(color: AppColors.black3),
              children: [
                TextSpan(text: widget.controller.text, style: AppTextStyles.bodySmall(color: AppColors.black1),)
              ]
            )),
            SizedBox(
              height: Get.height * 0.02,
            ),
            CustomInputFields(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){

                }, child: Text("Resend code 00:30",style: AppTextStyles.bodySmallest(color: AppColors.infoColor),)),
              ],
            ),
            CustomButton(str: "Continue", onPressed: (){
              print(AuthController.otp.toString());
              print(AuthController.otp.length);
              if(AuthController.otp.length == 5){
              EmailVerification.checkOtp(AuthController.otp.toString()).then((value) {
                if(value){
                  widget.pageController.animateToPage(2, duration: Duration(milliseconds: 100), curve: Curves.linear).then((value) {
                    print("successfully next page");
                  },);
                }
                Get.snackbar("Error", "Try again sometime",
                    icon: const Icon(Icons.dangerous, color: AppColors.errorColor),
                    snackPosition: SnackPosition.TOP,
                    snackStyle: SnackStyle.FLOATING);
              },);
              }

            })
          ],
        ),
      ),
    );
  }
}

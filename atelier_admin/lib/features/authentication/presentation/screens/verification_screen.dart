import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomInputFields.dart';

class VerificationScreen extends StatefulWidget {
  final PageController pageController;
  const VerificationScreen({super.key,required this.pageController});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
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
                TextSpan(text: " rupeshyadav78857@gmail.com", style: AppTextStyles.bodySmall(color: AppColors.black1),)
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
              widget.pageController.animateToPage(2, duration: Duration(milliseconds: 100), curve: Curves.linear).then((value) {
                print("successfully next page");
              },);
            })
          ],
        ),
      ),
    );
  }
}

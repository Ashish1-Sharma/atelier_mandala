import 'package:atelier_admin/features/authentication/presentation/screens/set_new_password.dart';
import 'package:atelier_admin/features/authentication/presentation/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomField.dart';
import '../widgets/CustomInputFields.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        backgroundColor: AppColors.black6,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new,color: AppColors.brandColor,),
        ),
        title: Text('Forgot Password'),
        centerTitle: true,
      ),
      body: SafeArea(
        child:  PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            Form(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.1,
                    ),
                    Text(
                      "Please enter your email",
                      style: AppTextStyles.h1(color: Colors.black),
                    ),
                    SizedBox(
                      height: Get.height * 0.013,
                    ),
                    Text(
                      "We will send you a confirmation email",
                      style: AppTextStyles.bodyBig(color: AppColors.black3),
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    Text(
                      "Email Address",
                      style: AppTextStyles.bodySmall(color: AppColors.black1),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
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
                    CustomButton(str: "Continue",onPressed: (){
                      pageController.animateToPage(1, duration: Duration(milliseconds: 100), curve: Curves.linear);
                    },),




                  ],
                ),
              ),
            ),
            VerificationScreen(pageController: pageController),
            NewPassword(pageController: pageController)
          ],
        ),
      ),
    );
  }
}

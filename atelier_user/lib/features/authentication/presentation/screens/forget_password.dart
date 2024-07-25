import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/features/authentication/presentation/screens/enter_email.dart';
import 'package:atelier_user/features/authentication/presentation/screens/new_pass.dart';
import 'package:atelier_user/features/authentication/presentation/screens/verification_code.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      body: SafeArea(
        child: PageView(
          controller: pageController,
          children: [
            EnterEmail(controller:pageController),
            VerificationCode(controller: pageController,),
            NewPass(controller: pageController,)
          ],
        ),
      ),
    );
  }
}

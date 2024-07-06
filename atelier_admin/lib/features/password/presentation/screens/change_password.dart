
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../authentication/presentation/widgets/CustomButton.dart';
import '../../../authentication/presentation/widgets/CustomField.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.1,
              ),
              Text(
                "Please enter new password",
                style: AppTextStyles.h1(color: Colors.black),
              ),
              SizedBox(
                height: Get.height * 0.013,
              ),
              Text(
                "At least one capital letter and Latin alphabet",
                style: AppTextStyles.bodyBig(color: AppColors.black3),
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              Text(
                "Password",
                style: AppTextStyles.bodySmall(color: AppColors.black1),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              CustomField(
                icon1: Iconsax.eye,
                icon2: Iconsax.eye_slash,
                txt: "Password",
                controller: password,
                validator: (e) {
                  return null;
                },
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              Text(
                "Confirm Password",
                style: AppTextStyles.bodySmall(color: AppColors.black1),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              CustomField(
                icon1: Iconsax.eye,
                icon2: Iconsax.eye_slash,
                txt: "Password",
                controller: confirmPassword,
                validator: (e) {
                  return null;
                },
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomButton(str: "Continue",onPressed: (){
                // widget.pageController.animateToPage(1, duration: Duration(milliseconds: 100), curve: Curves.linear);
              },),




            ],
          ),
        ),
      ),
    );
  }
}

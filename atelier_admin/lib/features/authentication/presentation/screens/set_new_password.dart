import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../widgets/CustomButton.dart';
import '../widgets/CustomField.dart';
import '../widgets/CustomInputFields.dart';

class NewPassword extends StatefulWidget {
  final PageController pageController;
  const NewPassword({super.key,required this.pageController});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Form(
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
              Space.spacer(0.007),
              CustomField(
                icon1: Iconsax.eye,
                icon2: Iconsax.eye_slash,
                txt: "Password",
                controller: password,
                validator: (e) {
                  return null;
                },
              ),
              Space.spacer(0.025),
              Text(
                "Confirm Password",
                style: AppTextStyles.bodySmall(color: AppColors.black1),
              ),
              Space.spacer(0.007),
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

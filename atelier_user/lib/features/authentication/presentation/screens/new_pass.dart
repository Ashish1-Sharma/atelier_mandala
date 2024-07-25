import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../widgets/custom_field.dart';


class NewPass extends StatefulWidget {
  final PageController controller;

  const NewPass({super.key, required this.controller});

  @override
  State<NewPass> createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
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
                style: AppTextStyles.h1(color: AppColors.tertiaryColor),
              ),
              SizedBox(
                height: Get.height * 0.013,
              ),
              Text(
                "At least one capital letter and Latin alphabet",
                style: AppTextStyles.bodyBigNormal(color: AppColors.black3),
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              Text(
                "Password",
                style: AppTextStyles.bodySmall(color: AppColors.black2),
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
                style: AppTextStyles.bodySmall(color: AppColors.black2),
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
                height: Get.height * 0.03,
              ),

              Container(
                  width: double.infinity,
                  child: CustomElevatedButton(backColor: AppColors.brandColor, txtColor: AppColors.black6, txt: "Continue", onPressed: (){}))

            ],
          ),
        ),
      ),
    );
  }
  }

import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/profile/presentation/widgets/dob_picker.dart';
import 'package:atelier_admin/features/profile/presentation/widgets/gender_picker.dart';
import 'package:atelier_admin/features/takeways/presentation/widgets/drop_down_category.dart';
import 'package:atelier_admin/global_widgets/custom_date_picker.dart';
import 'package:atelier_admin/global_widgets/custom_elevated_button.dart';
import 'package:atelier_admin/global_widgets/custom_normal_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final spaceH1 = Get.height * 0.015;
    final spaceH2 = Get.height * 0.008;
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // padding: EdgeInsets.s(15),
            color: CupertinoColors.white,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: Get.width * 0.2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Ashish sharma",
                  style: AppTextStyles.h2(color: AppColors.black1),
                ),
                Text(
                  "wwwviveksharma45@gmail.com",
                  style: AppTextStyles.bodySmallest(color: AppColors.black1),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            color: CupertinoColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Name",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                CustomNormalTextField(controller: name, hint: "Ashish sharma"),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Email",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                CustomNormalTextField(controller: email, hint: "wwwviveksharma45@gmail.com"),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Date Of Birth",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                DobPicker(controller: dob),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Gender",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                GenderPicker(controller: gender)
              ],
            ),
          ),
          Container(
              width: double.infinity,
              child: CustomElevatedButton(backColor: AppColors.brandColor, txtColor: AppColors.black6, txt: "Save", onPressed: (){}))
        ],
      ),
    ));
  }
}

import 'package:atelier_user/features/profile/data/profile_controller.dart';
import 'package:atelier_user/features/profile/data/profile_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../global/global_widgets/custom_elevated_button.dart';
import '../../../../global/global_widgets/custom_normal_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ProfileServices.extractUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final spaceH1 = Get.height * 0.015;
    final spaceH2 = Get.height * 0.008;
    return Scaffold(
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.black6,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.brandColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text("Edit Profile"),
      ),
      body: SafeArea(
          child: Obx(
        () => Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  // padding: EdgeInsets.s(15),
                  color: CupertinoColors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      profileImage(),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Text(
                          ProfileController.name.value,
                          style: AppTextStyles.h2(color: AppColors.black1),
                        ),
                      ),
                      Obx(
                        () => Text(
                          ProfileController.email.value,
                          style: AppTextStyles.bodySmallest(
                              color: AppColors.black1),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
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
                      CustomNormalTextField(
                          controller: name, hint: ProfileController.name.value),
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
                      CustomNormalTextField(
                          controller: email,
                          hint: ProfileController.email.value),
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
                      // DobPicker(controller: dob),
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
                      // GenderPicker(controller: gender)
                    ],
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                        backColor: AppColors.brandColor,
                        txtColor: AppColors.black6,
                        txt: "Save",
                        onPressed: () {}))
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget profileImage() {
    return Container(
      width: Get.height * 0.2,
      height: Get.height * 0.2,
      decoration: BoxDecoration(
          color: AppColors.brandColor,
          borderRadius: BorderRadius.circular(Get.height * 0.1)),
      alignment: Alignment.center,
      child: Text(
        ProfileController.name.toString().substring(0, 1).toUpperCase(),
        style: AppTextStyles.h1(color: AppColors.black6)
            .copyWith(fontSize: Get.width * 0.25),
      ),
    );
  }
}

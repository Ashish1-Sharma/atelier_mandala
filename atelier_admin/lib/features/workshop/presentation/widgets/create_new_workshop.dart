import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomButton.dart';
import 'package:atelier_admin/global_widgets/custom_date_picker.dart';
import 'package:atelier_admin/global_widgets/custom_description.dart';
import 'package:atelier_admin/global_widgets/custom_elevated_button.dart';
import 'package:atelier_admin/global_widgets/custom_normal_text_field.dart';
import 'package:atelier_admin/global_widgets/custom_outlined_button.dart';
import 'package:atelier_admin/global_widgets/custom_time_picker.dart';
import 'package:atelier_admin/global_widgets/custom_upload_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CreateNewWorkshop extends StatefulWidget {
  const CreateNewWorkshop({super.key});

  @override
  State<CreateNewWorkshop> createState() => _CreateNewWorkshopState();
}

class _CreateNewWorkshopState extends State<CreateNewWorkshop> {
  TextEditingController title = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final spaceH1 = Get.height * 0.015;
    final spaceH2 = Get.height * 0.008;
    return Scaffold(
      backgroundColor: AppColors.black5,
      body: SafeArea(
          child: Form(
        key: key,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Cancel",
                        style: AppTextStyles.bodySmall(
                            color: AppColors.brandColor),
                      )),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Add Workshop",
                    style: AppTextStyles.h2(color: AppColors.black1),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "New Title",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                CustomNormalTextField(controller: title, hint: "Workshop Name"),
                SizedBox(
                  height: spaceH1,
                ),
                Text(
                  "Description",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                CustomDescription(controller: title),
                SizedBox(
                  height: spaceH1,
                ),
                Text(
                  "Upload Image",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                const CustomUploadImage(),
                SizedBox(
                  height: spaceH1,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: spaceH1,
                        ),
                        Text(
                          "Start Date",
                          style:
                              AppTextStyles.bodySmall(color: AppColors.black1),
                        ),
                        SizedBox(
                          height: spaceH2,
                        ),
                        CustomDatePicker(
                          controller: startDate,
                        ),
                      ],
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: spaceH1,
                        ),
                        Text(
                          "Start Time",
                          style:
                              AppTextStyles.bodySmall(color: AppColors.black1),
                        ),
                        SizedBox(
                          height: spaceH2,
                        ),
                        CustomTimePicker(
                          controller: startTime,
                        ),
                      ],
                    )),
                    // Expanded(child: child)
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: spaceH1,
                        ),
                        Text(
                          "End Date",
                          style:
                              AppTextStyles.bodySmall(color: AppColors.black1),
                        ),
                        SizedBox(
                          height: spaceH2,
                        ),
                        CustomDatePicker(
                          controller: endDate,
                        ),
                      ],
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: spaceH1,
                        ),
                        Text(
                          "End Time",
                          style:
                              AppTextStyles.bodySmall(color: AppColors.black1),
                        ),
                        SizedBox(
                          height: spaceH2,
                        ),
                        CustomTimePicker(
                          controller: endTime,
                        ),
                      ],
                    )),
                    // Expanded(child: child)
                  ],
                ),
                SizedBox(
                  height: spaceH1,
                ),
                Text(
                  "Ticket Name",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                CustomNormalTextField(controller: title, hint: "Ticket Name"),
                SizedBox(
                  height: spaceH1,
                ),
                Text(
                  "Workshop Location",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                CustomNormalTextField(
                    controller: title, hint: "Enter Location"),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomOutlinedButton(
                            sideColor: AppColors.brandColor,
                            txtColor: AppColors.brandColor,
                            txt: "Save",
                            onPressed: () {})),
                    SizedBox(
                      width: Get.width * 0.06,
                    ),
                    Expanded(
                        child: CustomElevatedButton(
                            backColor: AppColors.brandColor,
                            txtColor: AppColors.black6,
                            txt: "Publish",
                            onPressed: () {}))
                  ],
                ),
                SizedBox(
                  height: spaceH1,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

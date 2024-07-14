import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomButton.dart';
import 'package:atelier_admin/features/takeways/data/data_source/add_takeaway.dart';
import 'package:atelier_admin/features/takeways/data/models/takeaway_model.dart';
import 'package:atelier_admin/features/takeways/presentation/widgets/drop_down_category.dart';
import 'package:atelier_admin/global_widgets/custom_date_picker.dart';
import 'package:atelier_admin/global_widgets/custom_description.dart';
import 'package:atelier_admin/global_widgets/custom_elevated_button.dart';
import 'package:atelier_admin/global_widgets/custom_normal_text_field.dart';
import 'package:atelier_admin/global_widgets/custom_outlined_button.dart';
import 'package:atelier_admin/global_widgets/custom_time_picker.dart';
import 'package:atelier_admin/global_widgets/custom_upload_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../global_controller.dart';
import '../../../../global_firebase.dart';
import '../../../workshop/data/data_source/add_workshop.dart';

class CreateNewTakeaway extends StatefulWidget {
  const CreateNewTakeaway({super.key});

  @override
  State<CreateNewTakeaway> createState() => _CreateNewTakeawayState();
}

class _CreateNewTakeawayState extends State<CreateNewTakeaway> {
  TextEditingController title = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

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
                      // child: Text(
                      //   "Cancel",
                      //   style: AppTextStyles.bodySmall(color: AppColors.brandColor),
                      // ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Food Takeaway",
                        style: AppTextStyles.h2(color: AppColors.black1),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Text(
                      "Food Name",
                      style: AppTextStyles.bodySmall(color: AppColors.black1),
                    ),
                    SizedBox(
                      height: spaceH2,
                    ),
                    CustomNormalTextField(controller: title, hint: "Food Name"),
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
                    CustomDescription(controller: description),
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
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price",
                              style: AppTextStyles.bodySmall(color: AppColors.black1),
                            ),
                            SizedBox(
                              height: spaceH2,
                            ),
                            CustomNormalTextField(controller: price, hint: "Enter Price"),

                          ],
                        )),
                        SizedBox(
                          width: Get.width * 0.06,
                        ),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Category",
                              style: AppTextStyles.bodySmall(color: AppColors.black1),
                            ),
                            SizedBox(
                              height: spaceH2,
                            ),
                            DropDownCategory(controller: category,)
                          ],
                        ))
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Text(
                      "Choose Date",
                      style: AppTextStyles.bodySmall(color: AppColors.black1),
                    ),
                    SizedBox(
                      height: spaceH2,
                    ),
                    CustomDatePicker(controller: date),
                    SizedBox(
                      height: spaceH1,
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
                                onPressed: () async {
                                  Reference ref = GlobalFirebase.storage.ref().child("/workshop/${GlobalController.link.value}");
                                  final snapshot = await ref.putFile(GlobalController.image!).whenComplete(() => null);
                                  String downloadUrl = await snapshot.ref.getDownloadURL();
                                  print(downloadUrl);
                                  TakeawayModel model = TakeawayModel(title: title.text, description: description.text, imageUrl: downloadUrl, price: price.text, category: category.text, date: date.text);

                                  AddTakeaway.pushData(model).then((value) => Get.back());

                                }))
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

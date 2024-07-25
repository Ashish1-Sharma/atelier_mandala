import 'dart:io';

import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomButton.dart';
import 'package:atelier_admin/features/takeways/data/data_source/add_takeaway.dart';
import 'package:atelier_admin/features/takeways/data/models/takeaway_model.dart';
import 'package:atelier_admin/features/takeways/presentation/widgets/drop_down_category.dart';
import 'package:atelier_admin/global_function/generate_uid.dart';
import 'package:atelier_admin/global_widgets/custom_date_picker.dart';
import 'package:atelier_admin/global_widgets/custom_description.dart';
import 'package:atelier_admin/global_widgets/custom_duration_picker.dart';
import 'package:atelier_admin/global_widgets/custom_elevated_button.dart';
import 'package:atelier_admin/global_widgets/custom_normal_text_field.dart';
import 'package:atelier_admin/global_widgets/custom_outlined_button.dart';
import 'package:atelier_admin/global_widgets/custom_time_picker.dart';
import 'package:atelier_admin/global_widgets/custom_upload_image.dart';
// import 'package:duration_picker/duration_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/space.dart';
import '../../../../constraints/warnings.dart';
import '../../../../global_controller.dart';
import '../../../../global_firebase.dart';
import '../../../workshop/data/data_source/add_workshop.dart';
import '../../data/controller/takeaway_controller.dart';

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
  Duration duration = Duration();

  @override
  void initState() {
    // TODO: implement initState
    TakeawayController.selectedValue.value = "Art";
    GlobalController.pickedImage = null;
    GlobalController.path.value = "";
    GlobalController.image = File('');
    super.initState();
  }
  GlobalKey<FormState> key = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    title.dispose();
    category.dispose();
    date.dispose();
    price.dispose();
    description.dispose();
    super.dispose();
  }
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
                    ),SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Text(
                      "Duration",
                      style: AppTextStyles.bodySmall(color: AppColors.black1),
                    ),
                    SizedBox(
                      height: spaceH2,
                    ),
                    CustomDurationPicker(onDurationChanged: (value){
                      duration = value;
                    },),
                    Space.spacer(0.05),
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

                        Obx(
                              ()=> Expanded(
                              child: TakeawayController.isProcessing.value ? Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.brandColor,
                                  ),
                                  child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      )))
                                  : CustomElevatedButton(
                                backColor: AppColors.brandColor,
                                txtColor: AppColors.black6,
                                txt: "Publish",
                                onPressed: () async {
                                  print(date.text);
                                  print(category.text);
                                  TakeawayController.isProcessing.value = true;
                                  if (!(title.text.isEmpty || description.text.isEmpty || price.text.isEmpty || date.text.isEmpty || category.text.isEmpty)) {
                                    if (!(GlobalController.pickedImage == null)) {

                                      Reference ref = GlobalFirebase.storage.ref().child("/takeaway/${GlobalController.link.value}");

                                      final snapshot = await ref.putFile(GlobalController.image!).whenComplete(() => null);
                                      String downloadUrl = await snapshot.ref.getDownloadURL();
                                      print(downloadUrl);
                                      final id = DateTime.now().millisecondsSinceEpoch.toString();
                                      TakeawayModel model = TakeawayModel(title: title.text, description: description.text, imageUrl: downloadUrl, price: price.text, tId: id, users: 0, category: category.text, date: date.text, duration: formatDuration(duration) );
                                      AddTakeaway.pushData(model,id)
                                          .then((value) => Get.back());
                                      TakeawayController.isProcessing.value = false;
                                    } else{
                                      print("Pls Pick the image."); TakeawayController.isProcessing.value = false;
                                      Warnings.onError("Pls Pick the image.");
                                    }
                                    TakeawayController.isProcessing.value = false;
                                                                    } else {
                                    Warnings.onError("Something is missing."); TakeawayController.isProcessing.value = false;
                                    print(GlobalController.link);
                                    // print(startDate.text);
                                  }
                                })))
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
  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = (duration.inMinutes % 60).abs(); // Ensure non-negative minutes

    if (hours > 0 && minutes > 0) {
      return '${hours} hours and ${minutes} minutes';
    } else if (hours > 0) {
      return '${hours} hours';
    } else {
      return '${minutes} minutes';
    }
  }
}

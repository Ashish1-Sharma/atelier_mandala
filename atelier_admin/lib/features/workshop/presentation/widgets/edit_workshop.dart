import 'dart:io';

import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/constraints/warnings.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomButton.dart';
import 'package:atelier_admin/features/workshop/data/data_source/add_workshop.dart';
import 'package:atelier_admin/features/workshop/data/models/workshop_model.dart';
import 'package:atelier_admin/features/workshop/data/workshop_controller.dart';
import 'package:atelier_admin/global_controller.dart';
import 'package:atelier_admin/global_function/generate_uid.dart';
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
import 'package:intl/intl.dart';

import '../../../../global_firebase.dart';

class EditWorkshop extends StatefulWidget {
  final WorkshopModel model;
  const EditWorkshop({super.key, required this.model});

  @override
  State<EditWorkshop> createState() => _EditWorkshopState();
}

class _EditWorkshopState extends State<EditWorkshop> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController ticketName = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController price = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    GlobalController.path.value = "";
    GlobalController.image = File('');
    super.initState();
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    startDate.dispose();
    endDate.dispose();
    startTime.dispose();
    endTime.dispose();
    ticketName.dispose();
    location.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spaceH1 = Get.height * 0.015;
    final spaceH2 = Get.height * 0.008;
    title.text = widget.model.title;
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
                    CustomNormalTextField(
                        controller: ticketName, hint: "Ticket Name"),
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
                        controller: location, hint: "Enter Location"),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Text(
                      "Enter price",
                      style: AppTextStyles.bodySmall(color: AppColors.black1),
                    ),
                    SizedBox(
                      height: spaceH2,
                    ),
                    CustomNormalTextField(controller: price, hint: "Enter Price"),
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
                        Obx(
                              ()=> Expanded(
                              child: WorkshopController.isProcessing.value ? Container(
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
                                    WorkshopController.isProcessing.value = true;
                                    if (!(title.text.isEmpty || description.text.isEmpty || ticketName.text.isEmpty || location.text.isEmpty || price.text.isEmpty)) {
                                      if (!(startDate.text.isEmpty && endDate.text.isEmpty && startTime.text.isEmpty && endTime.text.isEmpty)) {

                                        if(checkDateAndTime(startDate.text, startTime.text, endDate.text, endTime.text)){
                                          Warnings.onError("Selected date choose correctly");
                                        } else{
                                          if (!(GlobalController.pickedImage == null)) {

                                            Reference ref = GlobalFirebase.storage.ref().child("/workshop/${GlobalController.link.value}");

                                            final snapshot = await ref.putFile(GlobalController.image!).whenComplete(() => null);
                                            String downloadUrl = await snapshot.ref.getDownloadURL();
                                            print(downloadUrl);
                                            final id = GenerateUid.generateRandomString();
                                            WorkshopModel model = WorkshopModel(title: title.text, description: description.text, imageUrl: downloadUrl, startDate: startDate.text, startTime: startTime.text ,endTime: endTime.text, ticketName: ticketName.text, location: location.text, price: price.text, wId: id, users: 0, isPublic: true );
                                            AddWorkshop.pushData(model,id)
                                                .then((value) => Get.back());
                                            WorkshopController.isProcessing.value = false;
                                          } else{
                                            print("Pls Pick the image."); WorkshopController.isProcessing.value = false;
                                            Warnings.onError("Pls Pick the image.");
                                          }
                                        }
                                        WorkshopController.isProcessing.value = false;
                                      } else {
                                        Warnings.onError(
                                            "Date And time field is empty."); WorkshopController.isProcessing.value = false;
                                      }
                                    } else {
                                      Warnings.onError("Something is missing."); WorkshopController.isProcessing.value = false;
                                      print(GlobalController.link);
                                      print(startDate.text);
                                    }
                                  })),
                        )
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


  bool checkDateAndTime(String startDate,String startTime,String endDate,String endTime) {

    // Define date and time formats
    DateFormat dateFormat = DateFormat('EEE - dd MMMM', 'en_US');
    DateFormat timeFormat = DateFormat('h:mm a', 'en_US');

    // Parse the start date and time
    DateTime parsedStartDate = dateFormat.parse(startDate);
    DateTime parsedStartTime = timeFormat.parse(startTime);
    int currentYear = DateTime.now().year;
    DateTime startDateTime = DateTime(
      currentYear,
      parsedStartDate.month,
      parsedStartDate.day,
      parsedStartTime.hour,
      parsedStartTime.minute,
    );

    // Parse the end date and time
    DateTime parsedEndDate = dateFormat.parse(endDate);
    DateTime parsedEndTime = timeFormat.parse(endTime);
    DateTime endDateTime = DateTime(
      currentYear,
      parsedEndDate.month,
      parsedEndDate.day,
      parsedEndTime.hour,
      parsedEndTime.minute,
    );

    return endDateTime.isBefore(startDateTime);
  }

}

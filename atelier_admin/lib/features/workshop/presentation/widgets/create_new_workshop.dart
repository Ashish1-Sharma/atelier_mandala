import 'dart:io';

import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/constraints/warnings.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomButton.dart';
import 'package:atelier_admin/features/workshop/data/data_source/add_workshop.dart';
import 'package:atelier_admin/features/workshop/data/models/workshop_model.dart';
import 'package:atelier_admin/features/workshop/data/workshop_controller.dart';
import 'package:atelier_admin/features/workshop/presentation/widgets/workshop_page.dart';
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

import '../../../../constraints/space.dart';
import '../../../../global_firebase.dart';

class CreateNewWorkshop extends StatefulWidget {
  final WorkshopModel? model;
  const CreateNewWorkshop({super.key, this.model});

  @override
  State<CreateNewWorkshop> createState() => _CreateNewWorkshopState();
}

class _CreateNewWorkshopState extends State<CreateNewWorkshop> {
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
  DateFormat formatter = DateFormat("EEE - d MMMM");
  @override
  void initState() {
    // TODO: implement initState
    GlobalController.pickedImage = null;
    GlobalController.path.value = "";
    GlobalController.image = File('');
    // Initialize each controller with the corresponding model data
    title = TextEditingController(text: widget.model?.title ?? "");
    description = TextEditingController(text: widget.model?.description ?? "");
    startDate = TextEditingController(text: widget.model?.startDate ?? "");
    // endDate = TextEditingController(text: widget.model?.endDate ?? "");
    startTime = TextEditingController(text: widget.model?.startTime ?? "");
    endTime = TextEditingController(text: widget.model?.endTime ?? "");
    ticketName = TextEditingController(text: widget.model?.ticketName ?? "");
    location = TextEditingController(text: widget.model?.location ?? "");
    price = TextEditingController(text: widget.model?.price ?? "");
    GlobalController.link.value = "";
    GlobalController.choosenImageLink.value = "";
    try {
      print(widget.model!.imageUrl.isEmpty);
      if (widget.model!.imageUrl.isNotEmpty) {
        GlobalController.choosenImageLink.value = widget.model!.imageUrl;
      }
    } catch (e) {
      print(e);
    }
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
    // Initialize the controller with the model title or an empty string

    return Scaffold(
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        backgroundColor: AppColors.black6,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        title: Text(
          "Create Workshop",
          style: AppTextStyles.h3Normal(color: AppColors.black1),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                try {
                  String downloadUrl;
                  print(GlobalController.choosenImageLink.value);
                  print(GlobalController.link.value);
                  if (GlobalController.choosenImageLink.value.isNotEmpty ||
                      GlobalController.link.value.isNotEmpty) {
                    if (GlobalController.choosenImageLink.value != '') {
                      downloadUrl = GlobalController.choosenImageLink.value;
                    } else {
                      downloadUrl = GlobalController.downloadUrl.value;
                    }
                  } else {
                    downloadUrl = "";
                  }

                  String? id;
                  // print(downloadUrl);
                  print(widget.model?.wId);
                  try {
                    if (widget.model!.wId == null) {
                      id = DateTime.now().millisecondsSinceEpoch.toString();
                    } else {
                      id = widget.model?.wId;
                    }
                  } catch (e) {
                    id = DateTime.now().millisecondsSinceEpoch.toString();
                  }
                  // final id = widget.model?.wId == "" ? DateTime.now().millisecondsSinceEpoch.toString() : widget.model?.wId;
                  WorkshopModel model = WorkshopModel(
                      title: title.text,
                      description: description.text,
                      imageUrl: downloadUrl,
                      startDate: startDate.text,
                      startTime: startTime.text,
                      // endDate: endDate.text,
                      endTime: endTime.text,
                      ticketName: ticketName.text,
                      location: location.text,
                      price: price.text,
                      wId: id ?? '',
                      users: 0,
                      isPublic: false);
                  AddWorkshop.pushData(model, id!).then((value) => Get.back());
                } catch (e) {
                  print(e);
                }
              },
              child: Text(
                "Save Draft",
                style:
                    AppTextStyles.bodySmallNormal(color: AppColors.infoColor),
              ))
        ],
      ),
      body: SafeArea(
          child: Form(
        key: key,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      showImagePickerDialog(context);
                    },
                    child: (GlobalController.link.isNotEmpty ||
                            GlobalController.choosenImageLink.value.isNotEmpty)
                        ? Image.network(
                      GlobalController.link.value.isEmpty
                          ? GlobalController.choosenImageLink.value
                          : GlobalController.downloadUrl.value,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.black5,
                                child: Center(
                                    child:
                                        Icon(Icons.error, color: Colors.red)),
                              );
                            },
                            height: 175,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 175,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.black5,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColors.black1, width: 1),
                                    ),
                                    child: Icon(Icons.add),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Add image or poster",
                                    style: AppTextStyles.bodySmall(
                                        color: AppColors.black1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Event Name",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                CustomNormalTextField(
                    controller: title, hint: "EX: micproject"),
                SizedBox(
                  height: spaceH1,
                ),
                SizedBox(
                  height: spaceH1,
                ),
                Text(
                  "Date",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                CustomDatePicker(
                  controller: startDate,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Price",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                TextFormField(
                  controller: price,
                  style: AppTextStyles.bodyMain16(color: AppColors.black1),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.black6,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.infoColor, width: 1.5),
                          borderRadius: BorderRadius.circular(5)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.black2, width: 1.5),
                          borderRadius: BorderRadius.circular(5)),
                      hintText: "Price",
                      hintStyle:
                          AppTextStyles.bodySmall(color: AppColors.black3)),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                Text(
                  "Time",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomTimePicker(
                      controller: startTime,
                    )),
                    Space.width(0.005),
                    Expanded(
                        child: CustomTimePicker(
                      controller: endTime,
                    )),
                    // Expanded(child: child)
                  ],
                ),
                SizedBox(
                  height: spaceH2,
                ),
                SizedBox(
                  height: spaceH2,
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
                  "Location",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                CustomNormalTextField(controller: location, hint: "Location"),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomOutlinedButton(
                            sideColor: AppColors.brandColor,
                            txtColor: AppColors.brandColor,
                            txt: "Preview",
                            onPressed: () {
                              Get.to(WorkshopPage(model: widget.model));
                            })),
                    SizedBox(
                      width: Get.width * 0.06,
                    ),
                    Obx(() => Expanded(
                          child: WorkshopController.isProcessing.value
                              ? Container(
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
                                    WorkshopController.isProcessing.value =
                                        true;

                                    try {
                                      // Check required fields
                                      if (title.text.isEmpty ||
                                          description.text.isEmpty ||
                                          location.text.isEmpty ||
                                          price.text.isEmpty) {
                                        Warnings.onError(
                                            "Please fill in all required fields.");
                                        return;
                                      }

                                      // Check date and time fields
                                      if (startDate.text.isEmpty ||
                                          startTime.text.isEmpty ||
                                          endTime.text.isEmpty) {
                                        Warnings.onError(
                                            "Date and time fields cannot be empty.");
                                        return;
                                      }

                                      if (checkTimeOnly(
                                          startTime.text, endTime.text)) {
                                        Warnings.onError(
                                            "Selected date and time are incorrect.");
                                        return;
                                      }
                                      String downloadUrl;
                                      // Check if image is picked
                                      if (GlobalController.choosenImageLink
                                              .value.isNotEmpty ||
                                          GlobalController
                                              .link.value.isNotEmpty) {
                                        if (GlobalController
                                                .choosenImageLink.value !=
                                            '') {
                                          downloadUrl = GlobalController
                                              .choosenImageLink.value;
                                        } else {
                                          downloadUrl = GlobalController.downloadUrl.value;
                                        }
                                      } else {
                                        downloadUrl = "";
                                      }
                                      String? id;
                                      try {
                                        if (widget.model!.wId == null) {
                                          id = DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString();
                                        } else {
                                          id = widget.model?.wId;
                                        }
                                      } catch (e) {
                                        id = DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString();
                                      }
                                      // Upload image and get URL
                                      // Reference ref = GlobalFirebase.storage.ref().child("/workshop/${GlobalController.link.value}");
                                      // final snapshot = await ref.putFile(GlobalController.image!);
                                      // downloadUrl = await snapshot.ref.getDownloadURL();
                                      // print(downloadUrl);

                                      // Create WorkshopModel
                                      // final id = DateTime.now().millisecondsSinceEpoch.toString();
                                      WorkshopModel model = WorkshopModel(
                                        title: title.text,
                                        description: description.text,
                                        imageUrl: downloadUrl,
                                        startDate: startDate.text,
                                        startTime: startTime.text,
                                        endTime: endTime.text,
                                        ticketName: ticketName.text,
                                        location: location.text,
                                        price: price.text,
                                        wId: id!,
                                        users: 0,
                                        isPublic: true,
                                      );

                                      // Push data and go back
                                      await AddWorkshop.pushData(model, id!);
                                      Get.back();
                                    } catch (e) {
                                      print(e);
                                      Warnings.onError(
                                          "An error occurred while publishing the workshop.");
                                    } finally {
                                      // Ensure processing flag is reset
                                      WorkshopController.isProcessing.value =
                                          false;
                                    }
                                  },
                                ),
                        ))
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

  bool checkTimeOnly(String startTime, String endTime) {
    // Define time format
    DateFormat timeFormat = DateFormat('h:mm a', 'en_US');

    try {
      // Parse the start and end times
      DateTime parsedStartTime = timeFormat.parse(startTime);
      DateTime parsedEndTime = timeFormat.parse(endTime);

      // Compare times
      return parsedEndTime.isBefore(parsedStartTime);
    } catch (e) {
      print("Error parsing time: $e");
      return false; // or handle parsing error as needed
    }
  }

  Future showImagePickerDialog(BuildContext context) {
    WorkshopController.imageLinks.clear();
    WorkshopController.isButtonSelected.value = true;

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
          backgroundColor: AppColors.black6,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          WorkshopController.imageLinks.clear();
                          WorkshopController.isButtonSelected.value = true;
                        },
                        child: Text(
                          "Pick Image",
                          style:
                              AppTextStyles.bodySmall(color: AppColors.black1),
                        )),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          WorkshopController.isButtonSelected.value = false;
                          final storage = FirebaseStorage.instance;
                          final listRef = storage.ref().child(
                              'workshop'); // Replace 'store' with your folder name
                          final result = await listRef.listAll();
                          for (var item in result.items) {
                            final downloadUrl = await item.getDownloadURL();
                            WorkshopController.imageLinks.add(downloadUrl);
                          }
                          GlobalController.isPickedImageSelected.clear();
                          GlobalController.isPickedImageSelected.value =
                              List.generate(
                            WorkshopController.imageLinks.length,
                            (index) => false,
                          );
                        },
                        child: Text(
                          "Media Library",
                          style:
                              AppTextStyles.bodySmall(color: AppColors.black1),
                        )),
                  ),
                ],
              ),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                        child: Divider(
                      height: 5,
                      color: WorkshopController.isButtonSelected.value
                          ? AppColors.black1
                          : AppColors.black6,
                    )),
                    Expanded(
                        child: Divider(
                      height: 5,
                      color: WorkshopController.isButtonSelected.value
                          ? AppColors.black6
                          : AppColors.black1,
                    )),
                  ],
                ),
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () async {

                  if(GlobalController.link.value.isNotEmpty){
                    GlobalController.choosenImageLink.value = '';
                    Reference ref = GlobalFirebase.storage
                        .ref()
                        .child("/workshop/${GlobalController.link.value}");

                    final snapshot = await ref
                        .putFile(GlobalController.image)
                        .whenComplete(() => null);
                    GlobalController.downloadUrl.value = await snapshot.ref.getDownloadURL();
                    print(GlobalController.downloadUrl.value);
                  }
                  Get.back();
                },
                child: const Text("Ok")),
          ],
          content: Obx(
            () => WorkshopController.isButtonSelected.value
                ? Container(child: CustomUploadImage())
                : Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      WorkshopController.imageLinks.length,
                      (index) {
                        return InkWell(
                          onTap: () {
                            GlobalController.isPickedImageSelected.setAll(
                                0,
                                List.generate(
                                  GlobalController.isPickedImageSelected.length,
                                  (index) => false,
                                ));
                            GlobalController.isPickedImageSelected[index] =
                                !GlobalController.isPickedImageSelected[index];
                            GlobalController.choosenImageLink.value =
                                WorkshopController.imageLinks[index];
                            // GlobalController.link.value =
                            //     GlobalController.extractName(
                            //         WorkshopController.imageLinks[index]);
                            // print(GlobalController.link);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: GlobalController
                                              .isPickedImageSelected[index]
                                          ? AppColors.brandColor
                                          : CupertinoColors.white,
                                      width: GlobalController
                                              .isPickedImageSelected[index]
                                          ? 5
                                          : 0)),
                              child: Image.network(
                                WorkshopController.imageLinks[index],
                                height: 100,
                                fit: BoxFit.cover,
                              )),
                        );
                      },
                    ),
                  ),
          )),
    );
  }
}

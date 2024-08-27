import 'dart:io';

import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomButton.dart';
import 'package:atelier_admin/features/store/data/data_source/add_store.dart';
import 'package:atelier_admin/features/store/data/models/store_model.dart';
import 'package:atelier_admin/features/store/presentation/widgets/store_page.dart';
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
import 'package:intl/intl.dart';

import '../../../../constraints/space.dart';
import '../../../../constraints/warnings.dart';
import '../../../../global_controller.dart';
import '../../../../global_firebase.dart';
import '../../../../global_widgets/custom_counter.dart';
import '../../../workshop/data/data_source/add_workshop.dart';
import '../../data/controller/store_controller.dart';

class CreateNewStoreItem extends StatefulWidget {
  final StoreModel? model;
  const CreateNewStoreItem({super.key, this.model});

  @override
  State<CreateNewStoreItem> createState() => _CreateNewStoreItemState();
}

class _CreateNewStoreItemState extends State<CreateNewStoreItem> {
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
  final PickupTimeSlotsController controller =
  Get.put(PickupTimeSlotsController());
  @override
  void initState() {
    // TODO: implement initState
    GlobalController.pickedImage = null;
    GlobalController.path.value = "";
    GlobalController.image = File('');
    title = TextEditingController(text: widget.model?.title ?? "");
    description = TextEditingController(text: widget.model?.description ?? "");
    startDate = TextEditingController(text: widget.model?.date ?? "");
    location = TextEditingController(text: widget.model?.location ?? "");
    price = TextEditingController(text: widget.model?.price ?? "");

    if (widget.model != null) {
      final pickupTimings = widget.model!.pickupTimings.cast<String>();
      for (var timing in pickupTimings) {
        final parts = timing.split('_');
        if (parts.length == 2) {
          controller.timeSlots.add({
            'startTime': TextEditingController(text: parts[0].trim()),
            'endTime': TextEditingController(text: parts[1].trim()),
          });
        }
      }
    }
    GlobalController.link.value = "";
    GlobalController.choosenImageLink.value = "";
    try{
      print(widget.model!.imageUrl.isEmpty);
      if(widget.model!.imageUrl.isNotEmpty){
        GlobalController.choosenImageLink.value = widget.model!.imageUrl;
      }

    } catch (e){
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
    // quantity.text = "1";
    return Scaffold(
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        backgroundColor: AppColors.black6,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        title: Text(
          "Create store",
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
                  print(widget.model?.sId);
                  try {
                    if (widget.model!.sId == null) {
                      id = DateTime.now().millisecondsSinceEpoch.toString();
                    } else {
                      id = widget.model?.sId;
                    }
                  } catch (e) {
                    id = DateTime.now().millisecondsSinceEpoch.toString();
                  }
                  List<String> timeSlotsList =
                  controller.generateTimeSlotsList();
                  // final id = widget.model?.sId == "" ? DateTime.now().millisecondsSinceEpoch.toString() : widget.model?.sId;
                  StoreModel model = StoreModel(
                      title: title.text,
                      description: description.text,
                      imageUrl: downloadUrl,
                      date: startDate.text,
                      location: location.text,
                      price: price.text,
                      sId: id ?? '',
                      users: 0,
                      isPublic: false,
                      // category: '',
                      // duration: '',
                      // ,
                      pickupTimings: timeSlotsList);
                  AddStore.pushData(model, id!).then((value) => Get.back());
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
                      "Item Name",
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
                    Text(
                      "Item Price",
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
                    SizedBox(
                      height: spaceH2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pickup Time Slots",
                          style: AppTextStyles.bodySmall(color: AppColors.black1),
                        ),
                        TextButton(
                          onPressed: controller.addNewSlots,
                          child: Text("Add Pickup Slot"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: spaceH2,
                    ),
                    // Use Obx to update the UI when the timeSlots list changes
                    Obx(
                          () => Column(
                        children: controller.timeSlots.map((slot) {
                          int index = controller.timeSlots.indexOf(slot);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTimePicker(
                                    controller: slot['startTime']!,
                                  ),
                                ),
                                Space.width(0.005),
                                Expanded(
                                  child: CustomTimePicker(
                                    controller: slot['endTime']!,
                                  ),
                                ),
                                IconButton(
                                  icon:
                                  Icon(Icons.remove_circle, color: Colors.red),
                                  onPressed: () => controller.removeSlot(index),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: spaceH2,
                    ),
                    // Button to add new time slots

                    Row(
                      children: [
                        Expanded(
                            child: CustomOutlinedButton(
                                sideColor: AppColors.tertiaryColor,
                                txtColor: AppColors.tertiaryColor,
                                txt: "Preview",
                                onPressed: () {
                                  Get.to(StorePage(model: widget.model));
                                })),
                        SizedBox(
                          width: Get.width * 0.06,
                        ),
                        Obx(() => Expanded(
                          child: StoreController.isProcessing.value
                              ? Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.tertiaryColor,
                              ),
                              child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )))
                              : CustomElevatedButton(
                            backColor: AppColors.tertiaryColor,
                            txtColor: AppColors.black6,
                            txt: "Publish",
                            onPressed: () async {
                              StoreController.isProcessing.value =
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
                                List<String> timeSlotsList =
                                controller.generateTimeSlotsList();
                                if (timeSlotsList.isEmpty) {
                                  Warnings.onError(
                                      "Pls select timeslots");
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
                                    Reference ref = GlobalFirebase.storage
                                        .ref()
                                        .child(
                                        "/store/${GlobalController.link.value}");

                                    final snapshot = await ref
                                        .putFile(GlobalController.image)
                                        .whenComplete(() => null);
                                    downloadUrl = await snapshot.ref
                                        .getDownloadURL();
                                  }
                                } else {
                                  downloadUrl = "";
                                }
                                String? id;
                                try {
                                  if (widget.model!.sId == null) {
                                    id = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();
                                  } else {
                                    id = widget.model?.sId;
                                  }
                                } catch (e) {
                                  id = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                }
                                StoreModel model = StoreModel(
                                  title: title.text,
                                  description: description.text,
                                  imageUrl: downloadUrl,
                                  location: location.text,
                                  price: price.text,
                                  sId: id!,
                                  users: 0,
                                  isPublic: true,
                                  pickupTimings: timeSlotsList,
                                  date: startDate.text,
                                );
                                await AddStore.pushData(model, id!);
                                Get.back();
                              } catch (e) {
                                print(e);
                                Warnings.onError(
                                    "An error occurred while publishing the workshop.");
                              } finally {
                                // Ensure processing flag is reset
                                StoreController.isProcessing.value =
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

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes =
    (duration.inMinutes % 60).abs(); // Ensure non-negative minutes

    if (hours > 0 && minutes > 0) {
      return '${hours} hours and ${minutes} minutes';
    } else if (hours > 0) {
      return '${hours} hours';
    } else {
      return '${minutes} minutes';
    }
  }

  Future<void> showImagePickerDialog(BuildContext context) async {
    StoreController.imageLinks.clear();
    StoreController.isButtonSelected.value = true;

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
                      GlobalController.choosenImageLink.value = '';
                      StoreController.imageLinks.clear();
                      StoreController.isButtonSelected.value = true;
                    },
                    child: Text(
                      "Pick Image",
                      style: AppTextStyles.bodySmall(color: AppColors.black1),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      StoreController.isButtonSelected.value = false;
                      GlobalController.link.value = '';

                      // Load images from Firebase storage
                      await _loadImagesFromFirebase();

                      // Initialize the selection state after images are loaded
                      GlobalController.isPickedImageSelected.value =
                          List.generate(
                            StoreController.imageLinks.length,
                                (index) => false,
                          );
                    },
                    child: Text(
                      "Media Library",
                      style: AppTextStyles.bodySmall(color: AppColors.black1),
                    ),
                  ),
                ),
              ],
            ),
            Obx(
                  () => Row(
                children: [
                  Expanded(
                    child: Divider(
                      height: 5,
                      color: StoreController.isButtonSelected.value
                          ? AppColors.black1
                          : AppColors.black6,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      height: 5,
                      color: StoreController.isButtonSelected.value
                          ? AppColors.black6
                          : AppColors.black1,
                    ),
                  ),
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
                    .child("/store/${GlobalController.link.value}");

                final snapshot = await ref
                    .putFile(GlobalController.image)
                    .whenComplete(() => null);
                GlobalController.downloadUrl.value = await snapshot.ref.getDownloadURL();
                print(GlobalController.downloadUrl.value);
              }
              Get.back();
            },
            child: const Text("Ok"),
          ),
        ],
        content: Obx(
              () => StoreController.isButtonSelected.value
              ? CustomUploadImage()
              : _buildMediaLibrary(),
        ),
      ),
    );
  }

  Widget _buildMediaLibrary() {
    if (StoreController.imageLinks.isEmpty) {
      return Center(
          child:
          CircularProgressIndicator()); // Show a loading indicator while images are loading
    }

    return SingleChildScrollView(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(StoreController.imageLinks.length, (index) {
          return InkWell(
            onTap: () {
              GlobalController.isPickedImageSelected.setAll(
                0,
                List.generate(
                  GlobalController.isPickedImageSelected.length,
                      (index) => false,
                ),
              );
              GlobalController.isPickedImageSelected[index] = true;
              GlobalController.choosenImageLink.value =
              StoreController.imageLinks[index];
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: GlobalController.isPickedImageSelected[index]
                      ? AppColors.tertiaryColor
                      : CupertinoColors.white,
                  width: GlobalController.isPickedImageSelected[index] ? 5 : 0,
                ),
              ),
              child: Image.network(
                StoreController.imageLinks[index],
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _loadImagesFromFirebase() async {
    try {
      final storage = FirebaseStorage.instance;
      final listRef = storage
          .ref()
          .child('store'); // Replace 'store' with your folder name
      final result = await listRef.listAll();

      // Ensure imageLinks is updated after all URLs are fetched
      StoreController.imageLinks.value = await Future.wait(
        result.items.map((item) async => await item.getDownloadURL()).toList(),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load images: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class PickupTimeSlotsController extends GetxController {
  // Observable list of time slots
  var timeSlots = <Map<String, TextEditingController>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with two default slots
    addNewSlots();
  }

  // Method to add new slots
  void addNewSlots() {
    timeSlots.add({
      'startTime': TextEditingController(),
      'endTime': TextEditingController(),
    });
  }

  List<String> generateTimeSlotsList() {
    return timeSlots.map((slot) {
      String startTime = slot['startTime']!.text;
      String endTime = slot['endTime']!.text;
      return "$startTime _ $endTime";
    }).toList();
  }

  void removeSlot(int index) {
    if (timeSlots.length > 1) {
      timeSlots[index]['startTime']?.dispose();
      timeSlots[index]['endTime']?.dispose();
      timeSlots.removeAt(index);
    }
  }

  @override
  void onClose() {
    // Dispose of all controllers when done
    for (var slot in timeSlots) {
      slot['startTime']!.dispose();
      slot['endTime']!.dispose();
    }
    super.onClose();
  }
}

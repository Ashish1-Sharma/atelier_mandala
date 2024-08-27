import 'dart:io';

import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomButton.dart';
import 'package:atelier_admin/features/giftCards/data/data_source/add_gift_card.dart';
import 'package:atelier_admin/features/giftCards/data/gift_card_controller.dart';
import 'package:atelier_admin/features/giftCards/data/models/gift_card_model.dart';
import 'package:atelier_admin/features/giftCards/presentation/widgets/gift_card_page.dart';
import 'package:atelier_admin/features/takeways/data/data_source/add_takeaway.dart';
import 'package:atelier_admin/features/takeways/data/models/takeaway_model.dart';
import 'package:atelier_admin/features/takeways/presentation/widgets/drop_down_category.dart';
import 'package:atelier_admin/features/takeways/presentation/widgets/takeaway_page.dart';
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
import '../../../takeways/data/controller/takeaway_controller.dart';

class CreateNewGiftCard extends StatefulWidget {
  final GiftCardModel? model;
  const CreateNewGiftCard({super.key, this.model});

  @override
  State<CreateNewGiftCard> createState() => _CreateNewGiftCardState();
}

class _CreateNewGiftCardState extends State<CreateNewGiftCard> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController ticketName = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController couponCode = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    GlobalController.pickedImage = null;
    GlobalController.path.value = "";
    GlobalController.image = File('');
    title = TextEditingController(text: widget.model?.title ?? "");
    description = TextEditingController(text: widget.model?.description ?? "");
    startDate = TextEditingController(text: widget.model?.expiryDate ?? "");
    price = TextEditingController(text: widget.model?.price ?? "");
    couponCode = TextEditingController(text: widget.model?.code ?? "");
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
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.black6,

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Divider(
            thickness: 2,
            height: 0,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        title: Text(
          "Create Gift Card",
          style: AppTextStyles.h3Normal(color: AppColors.black1),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                try {
                  String downloadUrl;
                  print("Choosen Image Link ${GlobalController.choosenImageLink.value}");
                  print("Global pickup link ${GlobalController.link.value}");
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

                  print("Here is the $downloadUrl");
                  String? id;
                  // print(downloadUrl);
                  print(widget.model?.gId);
                  try {
                    if (widget.model!.gId == null) {
                      id = DateTime.now().millisecondsSinceEpoch.toString();
                    } else {
                      id = widget.model?.gId;
                    }
                  } catch (e) {
                    id = DateTime.now().millisecondsSinceEpoch.toString();
                  }
                  // final id = widget.model?.gId == "" ? DateTime.now().millisecondsSinceEpoch.toString() : widget.model?.gId;
                  GiftCardModel model = GiftCardModel(
                      title: title.text,
                      description: description.text,
                      imageUrl: downloadUrl,
                      expiryDate: startDate.text,
                      gId: id ?? '',
                      code: couponCode.text,
                      isPublic: false, price: price.text,);
                  AddGiftCard.pushData(model, id!).then((value) => Get.back());
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
                    Space.spacer(0.01),
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
                      "Expiry Date",
                      style: AppTextStyles.bodySmall(color: AppColors.black1),
                    ),
                    SizedBox(
                      height: spaceH2,
                    ),
                    CustomDatePicker(
                      controller: startDate,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      "Description",
                      style: AppTextStyles.bodySmall(color: AppColors.black1),
                    ),
                    SizedBox(
                      height: spaceH2,
                    ),
                    CustomDescription(controller: description),
                    Space.spacer(0.04),
                    // Button to add new time slots
                    Row(
                      children: [
                        Expanded(
                            flex: 6,
                            child: CustomNormalTextField(controller: couponCode, hint: "Unique Code")),
                        Space.width(0.01),
                        CustomElevatedButton(backColor: AppColors.tertiaryColor, txtColor: AppColors.black6, txt: "Generate", onPressed: (){
                          final str = DateTime.now().millisecondsSinceEpoch.toString();
                          final mappedStr = str.split('').map((e) {
                            int digit = int.parse(e);
                            return String.fromCharCode(digit + 65); // A=65, B=66, ..., J=74
                          }).join('');
                          couponCode.text = mappedStr;
                        })
                      ],
                    ),
                    Space.spacer(0.03),

                    Row(
                      children: [
                        Expanded(
                            child: CustomOutlinedButton(
                                sideColor: AppColors.tertiaryColor,
                                txtColor: AppColors.tertiaryColor,
                                txt: "Preview",
                                onPressed: () {
                                  Get.to(GiftCardPage(model: widget.model));
                                })),
                        SizedBox(
                          width: Get.width * 0.06,
                        ),
                        Obx(() => Expanded(
                          child: GiftCardController.isProcessing.value
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
                              GiftCardController.isProcessing.value = true;

                              try {
                                // Check required fields
                                if (title.text.isEmpty ||
                                    description.text.isEmpty||
                                    price.text.isEmpty || couponCode.text.isEmpty) {
                                  Warnings.onError("Please fill in all required fields.");
                                  return;
                                }

                                // Check date and time fields
                                if (checkTimeOnly(startTime.text, endTime.text)) {
                                  Warnings.onError("Selected date and time are incorrect.");
                                  return;
                                }

                                String downloadUrl = "";
                                // Handle image upload
                                if (GlobalController.choosenImageLink.value.isNotEmpty) {
                                  downloadUrl = GlobalController.choosenImageLink.value;
                                } else if (GlobalController.link.value.isNotEmpty) {
                                  downloadUrl = GlobalController.downloadUrl.value;
                                }

                                // Generate or retrieve the ID
                                String id = widget.model?.gId ?? DateTime.now().millisecondsSinceEpoch.toString();

                                // Create GiftCardModel instance
                                GiftCardModel model = GiftCardModel(
                                  title: title.text,
                                  description: description.text,
                                  imageUrl: downloadUrl,
                                  price: price.text,
                                  gId: id,
                                  isPublic: true,
                                  code: couponCode.text,
                                  expiryDate: startDate.text,
                                );

                                // Push data to the server
                                await AddGiftCard.pushData(model, id);

                                // Close the current screen
                                Get.back();

                              } catch (e) {
                                print(e);
                                Warnings.onError("An error occurred while processing the gift card.");
                              } finally {
                                // Ensure processing flag is reset
                                GiftCardController.isProcessing.value = false;
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
    GiftCardController.imageLinks.clear();
    GiftCardController.isButtonSelected.value = true;

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
                      GiftCardController.imageLinks.clear();
                      GiftCardController.isButtonSelected.value = true;
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
                      GiftCardController.isButtonSelected.value = false;
                      GlobalController.link.value = '';

                      // Load images from Firebase storage
                      await _loadImagesFromFirebase();

                      // Initialize the selection state after images are loaded
                      GlobalController.isPickedImageSelected.value =
                          List.generate(
                            GiftCardController.imageLinks.length,
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
                      color: GiftCardController.isButtonSelected.value
                          ? AppColors.black1
                          : AppColors.black6,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      height: 5,
                      color: GiftCardController.isButtonSelected.value
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
                    .child("/gifts/${GlobalController.link.value}");

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
              () => GiftCardController.isButtonSelected.value
              ? CustomUploadImage()
              : _buildMediaLibrary(),
        ),
      ),
    );
  }

  Widget _buildMediaLibrary() {
    if (GiftCardController.imageLinks.isEmpty) {
      return Center(
          child:
          CircularProgressIndicator()); // Show a loading indicator while images are loading
    }

    return SingleChildScrollView(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(GiftCardController.imageLinks.length, (index) {
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
              GiftCardController.imageLinks[index];
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
                GiftCardController.imageLinks[index],
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
          .child('gifts'); // Replace 'store' with your folder name
      final result = await listRef.listAll();

      // Ensure imageLinks is updated after all URLs are fetched
      GiftCardController.imageLinks.value = await Future.wait(
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

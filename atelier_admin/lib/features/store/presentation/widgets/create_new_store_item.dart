import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomButton.dart';
import 'package:atelier_admin/features/store/data/controller/store_controller.dart';
import 'package:atelier_admin/features/store/data/data_source/add_store.dart';
import 'package:atelier_admin/features/store/data/models/store_model.dart';
import 'package:atelier_admin/features/store/presentation/widgets/choice_chips.dart';
import 'package:atelier_admin/features/takeways/presentation/widgets/drop_down_category.dart';
import 'package:atelier_admin/global_widgets/custom_counter.dart';
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

import '../../../../constraints/warnings.dart';
import '../../../../global_controller.dart';
import '../../../../global_firebase.dart';
import '../../../../global_function/generate_uid.dart';

class CreateNewStoreItem extends StatefulWidget {
  const CreateNewStoreItem({super.key});

  @override
  State<CreateNewStoreItem> createState() => _CreateNewStoreItemState();
}

class _CreateNewStoreItemState extends State<CreateNewStoreItem> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController date = TextEditingController();
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
                    "Ecommerce",
                    style: AppTextStyles.h2(color: AppColors.black1),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Product Name",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                CustomNormalTextField(controller: title, hint: "Product Name"),
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
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter price",
                          style:
                              AppTextStyles.bodySmall(color: AppColors.black1),
                        ),
                        SizedBox(
                          height: spaceH2,
                        ),
                        CustomNormalTextField(
                            controller: price, hint: "Enter price"),
                      ],
                    )),
                    SizedBox(
                      width: Get.width * 0.06,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Stock Quantity",
                          style:
                              AppTextStyles.bodySmall(color: AppColors.black1),
                        ),
                        SizedBox(
                          height: spaceH2,
                        ),
                        CustomCounter(controller: quantity)
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: spaceH1,
                ),
                // CustomChoiceChips(),
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
                          child: StoreController.isProcessing.value ? Container(
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
                              StoreController.isProcessing.value = true;
                              if (!(title.text.isEmpty || description.text.isEmpty || price.text.isEmpty || date.text.isEmpty)) {
                                if (!(GlobalController.pickedImage == null)) {

                                  Reference ref = GlobalFirebase.storage.ref().child("/workshop/${GlobalController.link.value}");

                                  final snapshot = await ref.putFile(GlobalController.image!).whenComplete(() => null);
                                  String downloadUrl = await snapshot.ref.getDownloadURL();
                                  print(downloadUrl);
                                  final id = DateTime.now().millisecondsSinceEpoch.toString();

                                  StoreModel model = StoreModel(title: title.text, description: description.text, imageUrl: downloadUrl, price: price.text, stockQuantity: quantity.text ?? '1', sId: id,users: 0, date: date.text);
                                  AddStore.pushData(model,id)
                                      .then((value) => Get.back());
                                  StoreController.isProcessing.value = false;
                                } else{
                                  print("Pls Pick the image."); StoreController.isProcessing.value = false;
                                  Warnings.onError("Pls Pick the image.");
                                }
                              } else {
                                Warnings.onError("Something is missing."); StoreController.isProcessing.value = false;
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
}

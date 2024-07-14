import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/authentication/presentation/widgets/CustomButton.dart';
import 'package:atelier_admin/features/giftCards/data/data_source/add_gift_card.dart';
import 'package:atelier_admin/features/giftCards/data/models/gift_card_model.dart';
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

import '../../../../global_controller.dart';
import '../../../../global_firebase.dart';

class CreateNewGiftCard extends StatefulWidget {
  const CreateNewGiftCard({super.key});

  @override
  State<CreateNewGiftCard> createState() => _CreateNewGiftCardState();
}

class _CreateNewGiftCardState extends State<CreateNewGiftCard> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController conditions = TextEditingController();
  // TextEditingController endTime = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Counter.value.value = 1;
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
                    "Gift Card",
                    style: AppTextStyles.h2(color: AppColors.black1),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Gift Name",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                CustomNormalTextField(
                    controller: title, hint: "Gift Card Name"),
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
                          "Expiry Date",
                          style:
                              AppTextStyles.bodySmall(color: AppColors.black1),
                        ),
                        SizedBox(
                          height: spaceH2,
                        ),
                        CustomDatePicker(
                          controller: expiryDate,
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
                          "Value",
                          style:
                              AppTextStyles.bodySmall(color: AppColors.black1),
                        ),
                        SizedBox(
                          height: spaceH2,
                        ),
                        CustomCounter(controller: quantity)
                      ],
                    )),
                    // Expanded(child: child)
                  ],
                ),
                SizedBox(
                  height: spaceH1,
                ),
                Text(
                  "Redeem Conditions",
                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                ),
                SizedBox(
                  height: spaceH2,
                ),
                CustomNormalTextField(
                    controller: conditions, hint: "Redeem Conditions"),
                SizedBox(
                  height: spaceH1,
                ),
                Text(
                  "Enter Price",
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
                    Expanded(
                        child: CustomElevatedButton(
                            backColor: AppColors.brandColor,
                            txtColor: AppColors.black6,
                            txt: "Publish",
                            onPressed: () async {
                              Reference ref = GlobalFirebase.storage.ref().child(
                                  "/workshop/${GlobalController.link.value}");
                              final snapshot = await ref
                                  .putFile(GlobalController.image!)
                                  .whenComplete(() => null);
                              String downloadUrl =
                                  await snapshot.ref.getDownloadURL();
                              print(downloadUrl);
                              GiftCardModel model = GiftCardModel(
                                  title: title.text,
                                  description: description.text,
                                  imageUrl: downloadUrl,
                                  price: price.text,
                                  expiryDate: expiryDate.text,
                                  quantity: Counter.value.value,
                                  status: true);

                              AddGiftCard.pushData(model)
                                  .then((value) => Get.back());
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

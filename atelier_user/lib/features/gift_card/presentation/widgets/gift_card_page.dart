import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/features/gift_card/data/gift_card_services.dart';
import 'package:atelier_user/global/global_function/add_ids.dart';
import 'package:atelier_user/global/global_models/gift_card_model.dart';
import 'package:atelier_user/global/global_widgets/custom_counter.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_firebase.dart';

class GiftCardPage extends StatefulWidget {
  final GiftCardModel model;
  const GiftCardPage({super.key, required this.model});

  @override
  State<GiftCardPage> createState() => _GiftCardPageState();
}

class _GiftCardPageState extends State<GiftCardPage> {
  TextEditingController quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black5,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.black6,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.brandColor,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.model.imageUrl,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/loading_images/g_one.jpg",width: double.infinity,fit: BoxFit.cover,));
                },
              ),
            ),
            Space.spacer(0.02),
            Text(
              widget.model.title,
              style: AppTextStyles.h1withnormal(color: AppColors.black2),
            ),
            Space.spacer(0.01),
            Text(
              "\$ ${widget.model.price}",
              style: AppTextStyles.h1withnormal(color: AppColors.black2),
            ),
            Space.spacer(0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.shop,
                      color: AppColors.brandColor,
                    ),
                    Text(
                      "In Store-\n online",
                      style:
                          AppTextStyles.bodySmallest(color: AppColors.black3),
                    )
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.shopping_cart,
                      color: AppColors.brandColor,
                    ),
                    Text(
                      "Shopping\n Uses Only",
                      style:
                          AppTextStyles.bodySmallest(color: AppColors.black3),
                    )
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Iconsax.timer,
                      color: AppColors.brandColor,
                    ),
                    Text(
                      "Expiry Date\n"
                      " 17/07/2024",
                      style:
                          AppTextStyles.bodySmallest(color: AppColors.black3),
                    )
                  ],
                ),
              ],
            ),
            Space.spacer(0.01),
            Row(
              children: [
                Text(
                  "Description",
                  style: AppTextStyles.bodyMain16withBold(
                      color: AppColors.infoColor),
                ),
                Space.width(0.02),
                Text(
                  "How To Redeem",
                  style: AppTextStyles.bodySmall(color: AppColors.black3),
                )
              ],
            ),
            Space.spacer(0.01),
            Text(
              widget.model.description,
              style: AppTextStyles.bodySmallNormal(color: AppColors.black3),
            ),
            Row(
              children: [
                Expanded(child: CustomCounter(controller: quantityController,quantity: int.parse(widget.model.quantity),)),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: CustomElevatedButton(
                          backColor: AppColors.brandColor,
                          txtColor: AppColors.black6,
                          txt: "Buy For ME",
                          onPressed: () async {
                            print(quantityController.text);
                            print("----------------------");
                            // final code = await GiftCardServices.findCode(widget.model.gId,int.parse(quantityController.text));
                            AddIds.toGiftCard(widget.model.gId).then(
                              (value) {},
                            );
                          })),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


}

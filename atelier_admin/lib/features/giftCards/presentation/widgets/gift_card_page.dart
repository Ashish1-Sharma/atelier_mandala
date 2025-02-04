import 'package:atelier_admin/features/giftCards/data/models/gift_card_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global_widgets/custom_elevated_button.dart';

class GiftCardPage extends StatefulWidget {
  final GiftCardModel? model;
  const GiftCardPage({super.key, required this.model});

  @override
  State<GiftCardPage> createState() => _GiftCardPageState();
}

class _GiftCardPageState extends State<GiftCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.brandColor,),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.model!.imageUrl,width: double.infinity,fit: BoxFit.contain,),
            Space.spacer(0.02),
            Text(widget.model!.title,style: AppTextStyles.h1Normal(color: AppColors.black2_5),),
            Space.spacer(0.01),
            Text("\$ ${widget.model!.price}",style: AppTextStyles.h1Normal(color: AppColors.black2_5),),
            Space.spacer(0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.shop,color: AppColors.brandColor,),
                    Text("In Store-\n online",style: AppTextStyles.bodySmallest(color: AppColors.black3),)
                  ],
                ),
                Column(mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.shopping_cart,color: AppColors.brandColor,),
                    Text("Shopping\n Uses Only",style: AppTextStyles.bodySmallest(color: AppColors.black3),)
                  ],
                ),
                Column(mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Iconsax.timer,color: AppColors.brandColor,),
                    Text("Expiry Date\n"
                        " 17/07/2024",style: AppTextStyles.bodySmallest(color: AppColors.black3),)
                  ],
                ),

              ],
            ),
            Space.spacer(0.01),
            Row(
              children: [
                Text("Description",style: AppTextStyles.bodyMain16Bold(color: AppColors.infoColor),),
                Space.width(0.02),
                Text("How To Redeem",style: AppTextStyles.bodySmall(color: AppColors.black3),)
              ],
            ),
            Space.spacer(0.01),
            Text(widget.model!.description,style: AppTextStyles.bodySmallNormal(color: AppColors.black3),),
            ],
        ),
      ),
    );
  }
}

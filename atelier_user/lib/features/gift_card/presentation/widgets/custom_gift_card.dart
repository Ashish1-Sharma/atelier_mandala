import 'package:atelier_user/features/gift_card/presentation/widgets/gift_card_page.dart';
import 'package:atelier_user/global/global_models/gift_card_model.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';

class CustomGiftCard extends StatefulWidget {
  final GiftCardModel model;
  const CustomGiftCard({super.key, required  this.model});

  @override
  State<CustomGiftCard> createState() => _CustomGiftCardState();
}

class _CustomGiftCardState extends State<CustomGiftCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(GiftCardPage(model: widget.model));
      },
      child: Container(
        width: Get.width*0.9,
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: AppColors.black6,
          border: Border.all(
              color: AppColors.black3,
              width: 0.5
          ),
          borderRadius: BorderRadius.circular(20),),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(widget.model.imageUrl,width: double.infinity,fit: BoxFit.contain,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.model.title,style: AppTextStyles.bodyMain16withBold(color: AppColors.black2),),
                  Space.spacer(0.005),
                  Text("\$ ${widget.model.price}",style: AppTextStyles.bodyMain16(color: AppColors.black2),),
                  Space.spacer(0.005),
                  Text("Description",style: AppTextStyles.bodySmall(color: AppColors.black2),),
                  Space.spacer(0.01),
                  Flexible(
                    child: Text(
                     widget.model.description,style: AppTextStyles.bodySmall(color: AppColors.black3),),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      child: CustomElevatedButton(backColor: AppColors.brandColor, txtColor:  AppColors.black6, txt: "Buy Now", onPressed: (){
                        Get.to(GiftCardPage(model: widget.model));
                      }))

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:atelier_user/features/gift_card/presentation/widgets/gift_card_buy_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_function/add_ids.dart';
import '../../../../global/global_models/gift_card_model.dart';
import '../../../../global/global_widgets/custom_elevated_button.dart';

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
      backgroundColor: AppColors.black6,
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
        child: SingleChildScrollView(
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
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.black2,
                    size: 16,
                  ),
                  Icon(
                    Icons.star,
                    color: AppColors.black2,
                    size: 16,
                  ),
                  Icon(
                    Icons.star,
                    color: AppColors.black2,
                    size: 16,
                  ),
                  Icon(
                    Icons.star,
                    color: AppColors.black2,
                    size: 16,
                  ),
                  Icon(
                    Icons.star,
                    color: AppColors.black2,
                    size: 16,
                  ),
                  Text("4.4",style: AppTextStyles.bodySmallest(color: AppColors.black2),)
                ],
              ),
              Space.spacer(0.01),
              Text("Amount",style: AppTextStyles.bodyMain16withBold(color: AppColors.black2),),
              Space.spacer(0.01),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.errorColor,
                        width: 1
                    ),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  "\$ ${widget.model.price}",
                  style: AppTextStyles.bodySmallNormal(color: AppColors.black2),
                ),
              ),

              Space.spacer(0.02),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: CustomElevatedButton(
                            backColor: AppColors.tertiaryColor,
                            txtColor: AppColors.black6,
                            txt: "Buy For ME",
                            onPressed: () async {
                              print(quantityController.text);
                              print("----------------------");
                              Get.to(()=>GiftCardBuyPage(model: widget.model));
                              // final code = await GiftCardServices.findCode(widget.model.gId,int.parse(quantityController.text));
                              // AddIds.toGiftCard(widget.model.gId).then(
                              //       (value) {},
                              // );
                            })),
                  ),
                  Space.width(0.03),
                  Expanded(child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: CustomElevatedButton(
                          backColor: AppColors.tertiaryColor,
                          txtColor: AppColors.black6,
                          txt: "Send Gift",
                          onPressed: () async {
                            print(quantityController.text);
                            print("----------------------");
                            // final code = await GiftCardServices.findCode(widget.model.gId,int.parse(quantityController.text));
                            AddIds.toGiftCard(widget.model.gId).then(
                                  (value) {},
                            );
                          })),),
                ],
              ),
              Space.spacer(0.02),
              Text(
                "Product Features",
                style: AppTextStyles.h1withnormal(color: AppColors.black2),
              ),
              Space.spacer(0.01),
              Text(
                '''
- Amazon Pay Gift Cards are valid for 365 days from the date of purchase and carry no fees.
- Gift cards have great designs for every occasion. Customers can write down their personal wishes for their loved ones.
- Customers can choose any denomination ranging from €10–€10000 as a gifting amount.
- Receiver can apply the 14 digit alpha-numeric code (for e.g. 8U95-Y3E8CQ-29MPQ) on amazon.in/addgiftcard and add the Amazon Pay balance in their account.
- Amazon Pay Gift Cards cannot be refunded or returned.
- Amazon Pay Gift cards are redeemable across all products on Amazon except apps, certain global store products, and other Amazon Pay gift cards.
                ''',
                style: AppTextStyles.bodySmallest(color: AppColors.black2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/giftCards/data/models/gift_card_model.dart';
import 'package:atelier_admin/features/giftCards/presentation/widgets/gift_card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/warnings.dart';
import '../../../../global_firebase.dart';

class CustomGiftCard extends StatefulWidget {
  final GiftCardModel model;

  const CustomGiftCard({
    super.key,
    required this.model,
  });

  @override
  State<CustomGiftCard> createState() => _CustomGiftCardState();
}

class _CustomGiftCardState extends State<CustomGiftCard> {
  @override
  Widget build(BuildContext context) {
    final quantity = widget.model.quantity == "" ? '1' : widget.model.quantity;
    return Card(
      color: AppColors.black6,
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(widget.model.imageUrl,width: 120,height: 90,fit: BoxFit.contain,filterQuality: FilterQuality.high,))),

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.model.title,style: AppTextStyles.bodyBig(color: AppColors.black1),overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 5,),
                    RichText(text: TextSpan(text: "Status:\t",style: AppTextStyles.bodySmall(color: AppColors.black2_5),children: [
                      TextSpan(text: "${ widget.model.status ? "Active" : "Expired"}",style: AppTextStyles.bodySmall(color: widget.model.status ? AppColors.successColor : AppColors.errorColor),)
                    ])),
                    SizedBox(height: 5,),
                    Text("Stock: $quantity",overflow: TextOverflow.ellipsis,style: AppTextStyles.bodySmall(color: AppColors.black3)),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/calender.svg'),
                        SizedBox(width: 4,),
                        Text(widget.model.expiryDate,style: AppTextStyles.bodySmall(color: AppColors.black3))
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: PopupMenuButton(
                color: Colors.white,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(child: TextButton(
                      onPressed: (){

                      },
                      child: Text("Edit",style: AppTextStyles.bodySmallNormal(color: Colors.black),),
                    )),
                    PopupMenuItem(child: TextButton(
                      onPressed: (){
                        Get.to(GiftCardPage(model: widget.model));
                      },
                      child: Text("Preview",style: AppTextStyles.bodySmallNormal(color: Colors.black),),
                    )),
                    PopupMenuItem(child: TextButton(
                      onPressed: (){
                        GlobalFirebase.cloud.collection("takeaway").doc(widget.model.gId).delete().then((value) {
                          Warnings.onSuccess("Successfully deleted");
                        },);
                      },
                      child: Text("Delete",style: AppTextStyles.bodySmallNormal(color: Colors.black),),
                    )),
                  ];
                },
                child: Icon(Icons.more_vert,color: AppColors.brandColor,),
              ),
            )
          ],
        ),
      ),
    );
  }
}

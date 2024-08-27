import 'package:atelier_user/global/global_models/store_model.dart';
import 'package:atelier_user/global/global_models/takeaway_model.dart';
import 'package:atelier_user/global/global_widgets/custom_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_function/add_ids.dart';
import '../../../../global/global_widgets/custom_elevated_button.dart';

class StoreSheet extends StatefulWidget {
  final StoreModel model;
  const StoreSheet({super.key,required this.model});

  @override
  State<StoreSheet> createState() => _StoreSheetState();
}

class _StoreSheetState extends State<StoreSheet> {
  TextEditingController counter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.black6,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
        ),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Space.spacer(0.02),
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(widget.model.imageUrl,width: double.infinity,)),
              Space.spacer(0.02),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.successColor, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.all(4),
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: AppColors.successColor,
                ),
              ),
              Space.spacer(0.005),
              Text(widget.model.title.toString().substring(0,1).toUpperCase() + widget.model.title.toString().substring(1).toLowerCase(),style: AppTextStyles.bodyMain14_2(color: AppColors.black1),),
              Space.spacer(0.005),
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
              Space.spacer(0.005),
              Text("€ ${widget.model.price}",style: AppTextStyles.bodyMain14_2(color: AppColors.black2),),
              Space.spacer(0.005),
              Text(widget.model.description,
                softWrap: true,
                maxLines: 3,
                textAlign: TextAlign.left,
                style: AppTextStyles.bodySmallest(color: AppColors.black1),
              ),
              Space.spacer(0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: CustomCounter(controller: counter,quantity: int.parse(widget.model.stockQuantity))),
                  Space.width(0.02),
                  CustomElevatedButton(
                      backColor: AppColors.tertiaryColor,
                      txtColor: AppColors.black6,
                      txt: "Add Item € ${widget.model.price}",
                      onPressed: () {
                        AddIds.toStore(widget.model.sId);
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

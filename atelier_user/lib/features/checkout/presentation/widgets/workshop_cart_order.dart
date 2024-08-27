import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/global/global_models/workshop_model.dart';
import 'package:atelier_user/global/global_widgets/custom_counter.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../../constraints/space.dart';

class WorkshopCartOrder extends StatefulWidget {
  final WorkshopModel model;
  final TextEditingController controller;
  const WorkshopCartOrder({super.key,required this.model,required this.controller});

  @override
  State<WorkshopCartOrder> createState() => _WorkshopCartOrderState();
}

class _WorkshopCartOrderState extends State<WorkshopCartOrder> {
  @override
  Widget build(BuildContext context) {
    print("successfully started");
    return Container(
      height: 120,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.black6,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(widget.model.imageUrl))),
          Space.width(0.03),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.model.title,maxLines: 1,style: AppTextStyles.bodyMain14_1(color: AppColors.black2)),
                Space.spacer(0.03),
                Text("Price : \$${widget.model.price}",style: AppTextStyles.bodySmall(color: AppColors.black2))
              ],
            ),
          )
        ],
      ),
    );
  }
}

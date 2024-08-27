import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/checkout/presentation/widgets/checkout_counter.dart';
import 'package:atelier_user/global/global_models/store_model.dart';
import 'package:atelier_user/global/global_models/takeaway_model.dart';
import 'package:atelier_user/global/global_models/workshop_model.dart';
import 'package:atelier_user/global/global_widgets/custom_counter.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../../constraints/space.dart';

class StoreCartOrder extends StatefulWidget {
  final StoreModel model;
  final ValueChanged<int> onValueChange;
  const StoreCartOrder({super.key,required this.model, required this.onValueChange});

  @override
  State<StoreCartOrder> createState() => _WorkshopCartOrderState();
}

class _WorkshopCartOrderState extends State<StoreCartOrder> {
  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.model.title,style: AppTextStyles.bodyMain14_1(color: AppColors.black2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Price : \$${widget.model.price}",style: AppTextStyles.bodySmall(color: AppColors.black2)),
                    CheckoutCounter( quantity: int.parse(widget.model.stockQuantity), onValueChange:widget.onValueChange,)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

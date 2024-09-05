import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/checkout/presentation/widgets/checkout_counter.dart';
import 'package:atelier_user/global/global_models/takeaway_model.dart';
import 'package:atelier_user/global/global_models/workshop_model.dart';
import 'package:atelier_user/global/global_widgets/custom_counter.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../../constraints/space.dart';

class TakeawayCartOrder extends StatefulWidget {
  final TakeawayModel model;
  final ValueChanged<int> onValueChange;
  final ValueChanged<String> onPickupTimeSelect;

  const TakeawayCartOrder(
      {super.key,
      required this.model,
      required this.onValueChange,
      required this.onPickupTimeSelect});

  @override
  State<TakeawayCartOrder> createState() => _WorkshopCartOrderState();
}

class _WorkshopCartOrderState extends State<TakeawayCartOrder> {
  String? _selectedPickUpTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.black6, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
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
                    Text(widget.model.title,
                        style: AppTextStyles.bodyMain14_1(
                            color: AppColors.black2)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price: \$${widget.model.price}",
                            style: AppTextStyles.bodySmall(
                                color: AppColors.black2)),
                        CheckoutCounter(onValueChange: widget.onValueChange),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Space.spacer(0.02),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 8.0, // Space between each item
            runSpacing: 4.0, // Space between rows
            children: List.generate(widget.model.pickUpTimings.length, (index) {
              final timing = widget.model.pickUpTimings[index];
              final isSelected = timing ==
                  _selectedPickUpTime; // Check if this timing is selected

              return ChoiceChip(
                label: Text(
                  timing,
                  style: AppTextStyles.bodySmallest(
                    color: isSelected ? Colors.white : AppColors.black1,
                  ),
                ),
                selected: isSelected,
                backgroundColor: AppColors.brandColor.withOpacity(0.2),
                selectedColor: AppColors.brandColor,
                onSelected: (selected) {
                  setState(() {
                    _selectedPickUpTime = timing;
                    widget.onPickupTimeSelect(
                        timing); // Pass the selected timing to the callback
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

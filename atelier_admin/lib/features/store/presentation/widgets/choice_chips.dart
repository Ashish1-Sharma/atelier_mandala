import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/store/data/controller/store_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CustomChoiceChips extends StatefulWidget {
  const CustomChoiceChips({super.key});

  @override
  State<CustomChoiceChips> createState() => _CustomChoiceChipsState();
}

class _CustomChoiceChipsState extends State<CustomChoiceChips> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 5,
        children: List.generate(
          StoreController.tags.length,
          (index) {
            return ChoiceChip(
                showCheckmark: false,
                disabledColor: AppColors.black6,
                onSelected: (value) {
                  StoreController.isTagSelected[index] = value;
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none),
                selectedColor: AppColors.brandColor,
                label: Text(
                  StoreController.tags[index],
                  style: AppTextStyles.bodySmallest(
                      color: StoreController.isTagSelected[index]
                          ? AppColors.black6
                          : AppColors.black1),
                ),
                selected: StoreController.isTagSelected[index]);
          },
        ),
      ),
    );
  }
}

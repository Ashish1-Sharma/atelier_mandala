import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/homepage/data/home_page_controller.dart';
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
    return Container(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: HomePageController.chips.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(
              () => ChoiceChip(
                showCheckmark: false,
                backgroundColor: AppColors.black5,
                selectedColor: AppColors.brandColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(width: 0, color: AppColors.black5)),
                label: Text(
                  HomePageController.chips[index],
                  style: AppTextStyles.bodyMain16(
                      color: HomePageController.is_selected[index]
                          ? AppColors.black6
                          : AppColors.black1),
                ),
                selected: HomePageController.is_selected[index],
                onSelected: (value) {
                  HomePageController.is_selected.setAll(0, List.filled(HomePageController.chips.length, false));
                  HomePageController.is_selected[index] = value;
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

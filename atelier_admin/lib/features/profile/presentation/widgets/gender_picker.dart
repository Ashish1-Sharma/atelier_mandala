import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/features/takeways/data/controller/takeaway_controller.dart';
import 'package:flutter/material.dart';

import '../../../../constraints/fonts.dart';
import '../../controller/profile_controller.dart';

class GenderPicker extends StatefulWidget {
  final TextEditingController controller;
  const GenderPicker({super.key,required this.controller});

  @override
  State<GenderPicker> createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  // String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.black6,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.infoColor, width: 1.5),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black4, width: 1.5),
            borderRadius: BorderRadius.circular(5)),
        hintText: "Select Gender",
        hintStyle: AppTextStyles.bodySmall(color: AppColors.black3),
        suffixIcon: DropdownButtonFormField(
          padding: EdgeInsets.only(left: 10),
          icon: Icon(Icons.keyboard_arrow_down,color: AppColors.brandColor,),
          decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderSide:
                  BorderSide.none)
          ),
          value: ProfileController.selectedValue.value,
          items: ProfileController.genders.map(
                (e) {
              return DropdownMenuItem(
                child: Text(e),
                value: e,
              );
            },
          ).toList(),
          onChanged: (value) {
            ProfileController.selectedValue.value = value!;
          },
        ),
      ),
      readOnly: true,
      onTap: () {},
    );
    // return Te;
  }

  // void showDropDownItems() {}
}

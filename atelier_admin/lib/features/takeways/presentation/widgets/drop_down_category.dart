import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/features/takeways/data/controller/takeaway_controller.dart';
import 'package:flutter/material.dart';

import '../../../../constraints/fonts.dart';

class DropDownCategory extends StatefulWidget {
  final TextEditingController controller;
  const DropDownCategory({super.key,required this.controller});

  @override
  State<DropDownCategory> createState() => _DropDownCategoryState();
}

class _DropDownCategoryState extends State<DropDownCategory> {
  String? _selectedCategory;

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
        hintText: "Select Category",
        hintStyle: AppTextStyles.bodySmall(color: AppColors.black3),
        suffixIcon: DropdownButtonFormField(
           dropdownColor: AppColors.black6,
          hint: Text("select"),
          padding: EdgeInsets.only(left: 10),
          icon: Icon(Icons.keyboard_arrow_down,color: AppColors.brandColor,),
          decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderSide:
                  BorderSide.none)
          ),
          value: TakeawayController.selectedValue.value,
          items: TakeawayController.categories.map(
            (e) {
              return DropdownMenuItem(
                child: Text(e,style: AppTextStyles.bodySmallNormal(color: AppColors.black1),),
                value: e,
              );
            },
          ).toList(),
          onChanged: (value) {
            TakeawayController.selectedValue.value = value!;
            widget.controller.text = TakeawayController.selectedValue.value;
          },
        ),
      ),
      readOnly: true,
      onTap: () {},
    );
    // return Te;
  }

}

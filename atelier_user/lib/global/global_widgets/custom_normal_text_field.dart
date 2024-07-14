
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constraints/colors.dart';
import '../../constraints/fonts.dart';

class CustomNormalTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  const CustomNormalTextField(
      {super.key, required this.controller, required this.hint,this.validator});

  @override
  State<CustomNormalTextField> createState() => _CustomNormalTextFieldState();
}

class _CustomNormalTextFieldState extends State<CustomNormalTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: AppTextStyles.bodyMain16(color: AppColors.black1),
      validator: widget.validator,
      decoration: InputDecoration(
        filled: true,
          fillColor: AppColors.black6,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.infoColor, width: 1.5),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black2, width: 1.5),
              borderRadius: BorderRadius.circular(5)),
          hintText: widget.hint,
          hintStyle: AppTextStyles.bodySmall(color: AppColors.black3)),
    );
  }
}

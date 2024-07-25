import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constraints/colors.dart';
import '../../constraints/fonts.dart';

class CustomNormalTextField extends StatefulWidget {
  // final AutofillHints? fillHints;
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  const CustomNormalTextField(
      {super.key,
      required this.controller,
      required this.hint,
      this.validator});

  @override
  State<CustomNormalTextField> createState() => _CustomNormalTextFieldState();
}

class _CustomNormalTextFieldState extends State<CustomNormalTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: [widget.controller.text],
      controller: widget.controller,
      style: AppTextStyles.bodyMain16(color: AppColors.black1),
      validator: widget.validator,
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.black6,
          errorStyle: AppTextStyles.bodySmallest(color: AppColors.errorColor),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: AppColors.infoColor, width: 1.5),
              borderRadius: BorderRadius.circular(5)),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(
              width: 1,
            ),
          ),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                width: 1,
                color: AppColors.errorColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.black3, width: 1),
              borderRadius: BorderRadius.circular(5)),
          hintText: widget.hint,
          hintStyle:
              AppTextStyles.bodySmallwithNormal(color: AppColors.black3)),
    );
  }
}

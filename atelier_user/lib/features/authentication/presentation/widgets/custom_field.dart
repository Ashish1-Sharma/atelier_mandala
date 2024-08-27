import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';

class CustomField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String txt;
  final IconData? icon1;
  final IconData? icon2;

  const CustomField(
      {super.key,
      required this.controller,
      required this.validator,
      required this.txt,
      this.icon1,
      this.icon2});

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
          autofillHints: [AutofillHints.username],
          controller: widget.controller,
          obscureText: ShowController.show.value,
          validator: widget.validator,
          style: AppTextStyles.bodyMain16(color: AppColors.black1),
          decoration: InputDecoration(
            hintText: widget.txt,
            hintStyle:
                AppTextStyles.bodySmallNormal(color: AppColors.black3),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide:
                  const BorderSide(color: AppColors.infoColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                color: AppColors.black3,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.errorColor, width: 1),
                borderRadius: BorderRadius.circular(7)),
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
            suffixIcon: IconButton(
                onPressed: () {
                  ShowController.show.value = !ShowController.show.value;
                },
                icon: Icon(
                  ShowController.show.value ? widget.icon2 : widget.icon1,
                  color: AppColors.tertiaryColor,
                  weight: 100,
                )),
          )),
    );
  }
}

class ShowController extends GetxController {
  static RxBool show = true.obs;
}

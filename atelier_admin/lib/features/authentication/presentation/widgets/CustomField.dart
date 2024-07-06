import 'package:atelier_admin/constraints/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constraints/fonts.dart';

class CustomField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String?) validator;
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
  // bool show = true;
  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> TextFormField(
        controller: widget.controller,
        obscureText: ShowController.show.value,
        style: AppTextStyles.bodyMain16(color: AppColors.black1),
        decoration: InputDecoration(
            hintText: widget.txt,
            hintStyle: AppTextStyles.bodyMain16(color: AppColors.black3),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                color: AppColors.black2,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(
                color: AppColors.black2,
                width: 1,
              ),
            ),

            suffixIcon:IconButton(
                  onPressed: () {
                    ShowController.show.value = !ShowController.show.value;
                  },
                  icon: Icon(
                    ShowController.show.value ? widget.icon1 : widget.icon2,
                    color: AppColors.brandColor,
                    weight: 100,
                  )),)
      ),
    );
  }
}

class ShowController extends GetxController{
  static RxBool show = false.obs;
}

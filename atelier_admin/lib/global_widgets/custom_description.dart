import 'package:flutter/material.dart';

import '../constraints/colors.dart';

class CustomDescription extends StatefulWidget {
  final TextEditingController controller;
  const CustomDescription({super.key, required this.controller});

  @override
  State<CustomDescription> createState() => _CustomDescriptionState();
}

class _CustomDescriptionState extends State<CustomDescription> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        maxLines: 4,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.black6,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.infoColor, width: 1.5),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black4, width: 1.5),
              borderRadius: BorderRadius.circular(5)),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constraints/colors.dart';

class CustomTimePicker extends StatefulWidget {
  final TextEditingController controller;
  const CustomTimePicker({super.key, required this.controller});

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: "hour : minute",
        fillColor: AppColors.black6,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black4, width: 1.5),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black4, width: 1.5),
            borderRadius: BorderRadius.circular(5)),
        // suffixIcon: const Icon(
        //   Icons.keyboard_arrow_down_sharp,
        //   color: AppColors.brandColor,
        // ),
      ),
      readOnly: true,
      onTap: () {
        selectTime();
      },
    );
  }

  Future<void> selectTime() async {
    // await TimePickerDialog(initialTime: TimeOfDay.now());
    await showTimePicker(context: context, initialTime: TimeOfDay.now()).then(
      (value) {
        if (value != null) {
          print("picked");
          widget.controller.text = value.format(context);
          print(widget.controller.text);
        }
      },
    );
  }
}

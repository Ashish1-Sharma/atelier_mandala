import 'package:atelier_admin/constraints/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DobPicker extends StatefulWidget {
  final TextEditingController controller;
  const DobPicker({super.key, required this.controller});

  @override
  State<DobPicker> createState() => _DobPickerState();
}

class _DobPickerState extends State<DobPicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: "day - date month",
        fillColor: AppColors.black6,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black4, width: 1.5),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black4, width: 1.5),
            borderRadius: BorderRadius.circular(5)),
        suffixIcon: const Icon(
          Icons.calendar_month,
          color: AppColors.brandColor,
        ),
      ),
      readOnly: true,
      onTap: () {
        selectDate();
      },
    );
  }

  Future<void> selectDate() async {
    // final Widget? child;
    await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: AppColors.brandColor,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(DateTime.now().year + 1),
    ).then(
          (value) {
        if (value != null) {
          DateFormat formatter = DateFormat("EEE - d MMMM");
          widget.controller.text = formatter.format(value);
          print(widget.controller.text);
        }
      },
    );
  }
}

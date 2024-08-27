import 'package:atelier_admin/constraints/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  const CustomDatePicker({super.key, required this.controller});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: "Select Date",
        fillColor: AppColors.black6,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black4, width: 1.5),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black4, width: 1.5),
            borderRadius: BorderRadius.circular(5)),

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
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(DateTime.now().year + 1),
    ).then(
      (value) {
        if (value != null) {
          // DateFormat formatter = DateFormat("EEE - d MMMM");
          // widget.controller.text = formatter.format(value);
          // print(widget.controller.text);
          print(DateTime.fromMillisecondsSinceEpoch(value.millisecondsSinceEpoch));
// Assuming you want to format the DateTime to a specific format before setting it to the controller
          widget.controller.text = (value.millisecondsSinceEpoch).toString();

        }
      },
    );
  }
}

import 'package:atelier_admin/constraints/colors.dart';
import 'package:flutter/material.dart';

import '../constraints/fonts.dart';

class CustomOutlinedButton extends StatefulWidget {
  final Color sideColor;
  final Color txtColor;
  final String txt;
  final VoidCallback onPressed;

  const CustomOutlinedButton(
      {super.key,
      required this.sideColor,
      required this.txtColor,
      required this.txt,
      required this.onPressed});

  @override
  State<CustomOutlinedButton> createState() => _CustomOutlinedButtonState();
}

class _CustomOutlinedButtonState extends State<CustomOutlinedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.black5),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: widget.sideColor,
                width: 2
              )
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            widget.txt,
            style: AppTextStyles.bodyBig(color: widget.txtColor),
          ),
        ),
      ),
    );
  }
}

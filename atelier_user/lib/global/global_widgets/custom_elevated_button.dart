import 'package:flutter/material.dart';

import '../../constraints/fonts.dart';

class CustomElevatedButton extends StatefulWidget {
  final Color backColor;
  final Color txtColor;
  final String txt;
  final VoidCallback onPressed;

  const CustomElevatedButton(
      {super.key,
      required this.backColor,
      required this.txtColor,
      required this.txt,
      required this.onPressed});

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(widget.backColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          widget.txt,
          style: AppTextStyles.bodyBig(color: widget.txtColor),
        ),
      ),
    );
  }
}

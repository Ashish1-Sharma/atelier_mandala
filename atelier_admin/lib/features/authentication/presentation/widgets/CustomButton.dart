import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String str;
  final VoidCallback onPressed;
  const CustomButton({super.key,required this.str,required this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            )),
            backgroundColor: WidgetStateProperty.all(AppColors.brandColor)
          ),
          onPressed: widget.onPressed, child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(widget.str,style: AppTextStyles.bodyBig(color: AppColors.black5),),
          )),
    );
  }
}

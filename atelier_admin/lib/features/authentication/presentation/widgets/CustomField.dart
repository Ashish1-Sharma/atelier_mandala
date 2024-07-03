import 'package:atelier_admin/constraints/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String?) validator ;
  final String txt;
  final IconData? icon;


  const CustomField({super.key,required this.controller,required this.validator,required this.txt,this.icon});

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.txt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
            color: AppColors.black3,
            width: 1,
          ),
        ),
        suffixIcon: Icon(widget.icon,color: AppColors.brandColor,weight: 100,)
      ),
    );
  }
}

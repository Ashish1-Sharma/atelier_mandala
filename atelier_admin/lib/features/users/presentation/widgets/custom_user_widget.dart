import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class CustomUserWidget extends StatefulWidget {
  final bool image;
  final String name;
  final String email;
  final DateTime time;
  const CustomUserWidget(
      {super.key,
      required this.image,
      required this.name,
      required this.email,
      required this.time});

  @override
  State<CustomUserWidget> createState() => _CustomUserWidgetState();
}

class _CustomUserWidgetState extends State<CustomUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.brandColor,
              child: Text(
                widget.name.toString().substring(0, 1).toUpperCase(),
                style: AppTextStyles.bodyBig(color: AppColors.black6),
              ),
            ),
            SizedBox(width: 10), // spacing between image and text
            // Text section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: AppTextStyles.bodyMain16(color: Colors.black),
                  ),
                  Text(
                    widget.email,
                    style:
                        AppTextStyles.bodySmallest(color: AppColors.black3),
                  ),
                ],
              ),
            ),
            // Trailing icon
            Text(
              "${DateFormat('yyyy-MM-dd').format(widget.time)}",
              style: AppTextStyles.bodyMain16(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

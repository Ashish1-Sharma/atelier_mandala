import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomUploadImage extends StatefulWidget {
  const CustomUploadImage({super.key});

  @override
  State<CustomUploadImage> createState() => _CustomUploadImageState();
}

class _CustomUploadImageState extends State<CustomUploadImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: Get.height*0.06),
      decoration: BoxDecoration(
        color: AppColors.black6,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.black4,
          width: 1.5
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: AppColors.black4,
                    width: 1.5
                )
            ),
            child: Icon(Icons.upload),
          ),
          SizedBox(height: 10,),
          Text("Click to upload",style: AppTextStyles.bodySmall(color: AppColors.black3)),
          Text("JPG , PNG or GIF (max, 800x400)",style: AppTextStyles.bodySmall(color: AppColors.black3),)

        ],
      )
    );
  }
}

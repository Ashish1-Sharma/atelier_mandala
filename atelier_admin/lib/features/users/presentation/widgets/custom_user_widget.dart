import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomUserWidget extends StatefulWidget {
  const CustomUserWidget({super.key});

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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Leading image
                Image.asset(
                  "assets/images/users/user1.png",
                  width: 40, // adjust width and height as needed
                  height: 40,
                ),
                SizedBox(width: 10), // spacing between image and text
                // Text section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ashish Sharma",
                        style: AppTextStyles.bodyMain16(color: Colors.black),
                      ),
                      Text(
                        "wwwviveksharma45@gmail.com",
                        style: AppTextStyles.bodySmallest(color: AppColors.black3),
                      ),
                    ],
                  ),
                ),
                // Trailing icon
                Icon(
                  Icons.more_vert,
                  color: AppColors.brandColor,
                ),
              ],
            ),
            SizedBox(height: Get.height*0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Event',style: AppTextStyles.bodyMain16(color: Colors.black),),
                Text("Data Analysis",style: AppTextStyles.bodyMain16(color: Colors.black),)
              ],
            ),
            SizedBox(height: Get.height*0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment',style: AppTextStyles.bodyMain16(color: Colors.black),),
                Text("€ 299",style: AppTextStyles.bodyMain16(color: Colors.black))
              ],
            ),
            SizedBox(height: Get.height*0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status',style: AppTextStyles.bodyMain16(color: Colors.black),),
                Text("Failed",style: AppTextStyles.bodyMain16(color: AppColors.errorColor))
              ],
            ),

          ],
        ),
      ),
    );
  }
}

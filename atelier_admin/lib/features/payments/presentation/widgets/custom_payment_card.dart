import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomPaymentCard extends StatefulWidget {
  const CustomPaymentCard({super.key});

  @override
  State<CustomPaymentCard> createState() => _CustomPaymentCardState();
}

class _CustomPaymentCardState extends State<CustomPaymentCard> {
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
                Text('Payment Status',style: AppTextStyles.bodyMain16(color: Colors.black),),
                Text("Completed",style: AppTextStyles.bodyMain16(color: AppColors.successColor))
              ],
            ),
            SizedBox(height: Get.height*0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Purchased Date',style: AppTextStyles.bodyMain16(color: Colors.black),),
                Text("Sat-17Apr2024",style: AppTextStyles.bodyMain16(color: AppColors.black1))
              ],
            ),
            SizedBox(height: Get.height*0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Purchased Time',style: AppTextStyles.bodyMain16(color: Colors.black),),
                Text("10:30 AM",style: AppTextStyles.bodyMain16(color: AppColors.black1))
              ],
            ),

          ],
        ),
      ),
    );
  }
}

import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../data/models/purchase_model.dart';

class CustomPaymentCard extends StatefulWidget {
  final PurchaseModel model;

  const CustomPaymentCard(
      {super.key,
        required this.model});


  @override
  State<CustomPaymentCard> createState() => _CustomPaymentCardState();
}

class _CustomPaymentCardState extends State<CustomPaymentCard> {
  @override
  Widget build(BuildContext context) {
    final date = DateFormat("dd MMM yyyy").format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.model.purchasedDate)));
    final time = DateFormat("hh:mm a").format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.model.purchasedDate)));
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
                        widget.model.name,
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
                Text("€ ${widget.model.price}",style: AppTextStyles.bodyMain16(color: Colors.black))
              ],
            ),
            SizedBox(height: Get.height*0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Payment Status',style: AppTextStyles.bodyMain16(color: Colors.black),),
                Text(widget.model.paymentStatus.isEmpty ? "Failed" : widget.model.paymentStatus,style: AppTextStyles.bodyMain16(color: AppColors.errorColor))
              ],
            ),
            SizedBox(height: Get.height*0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Purchased Date',style: AppTextStyles.bodyMain16(color: Colors.black),),
                Text("${date ?? ''}",style: AppTextStyles.bodyMain16(color: AppColors.black1))
              ],
            ),
            SizedBox(height: Get.height*0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Purchased Time',style: AppTextStyles.bodyMain16(color: Colors.black),),
                Text("${time}",style: AppTextStyles.bodyMain16(color: AppColors.black1))
              ],
            ),

          ],
        ),
      ),
    );
  }
}

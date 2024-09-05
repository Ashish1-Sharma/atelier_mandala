import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/constraints/warnings.dart';
import 'package:atelier_user/features/homepage/presentation/screens/home_page.dart';
import 'package:atelier_user/features/homepage/presentation/screens/home_page_screen.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../constraints/space.dart';

class AfterPurchasedPage extends StatefulWidget {
  final int price;
  final String couponCode; // Add a field to store the coupon code
  const AfterPurchasedPage({super.key, required this.price, required this.couponCode});

  @override
  State<AfterPurchasedPage> createState() => _AfterPurchasedPageState();
}

class _AfterPurchasedPageState extends State<AfterPurchasedPage> {
  String copiedText = ""; // Store the copied text

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDateTime = DateFormat('dd-MM-yyyy, HH:mm:ss').format(now);

    return Scaffold(
      backgroundColor: AppColors.black6,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.black3,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green,
                    ),
                    child: Icon(Iconsax.tick_circle, color: Colors.white, size: 100),
                  ),
                  Text(
                    'Thanks for your order',
                    style: AppTextStyles.h3500(color: AppColors.black1),
                  ),
                  Space.spacer(0.01),
                  const DottedLine(
                    dashColor: AppColors.black3,
                    lineThickness: 1.5,
                    dashLength: 4.0,
                    dashGapLength: 3.0,
                  ),
                  Space.spacer(0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Time: ",
                        style: AppTextStyles.bodyMain16400(color: AppColors.black1),
                      ),
                      Text(
                        "$formattedDateTime",
                        style: AppTextStyles.bodyMain16400(color: AppColors.black1),
                      ),
                    ],
                  ),
                  Space.spacer(0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Method: ",
                        style: AppTextStyles.bodyMain16400(color: AppColors.black1),
                      ),
                      Text(
                        "Credit Card",
                        style: AppTextStyles.bodyMain16400(color: AppColors.black1),
                      ),
                    ],
                  ),
                  Space.spacer(0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Amount: ",
                        style: AppTextStyles.bodyMain16400(color: AppColors.black1),
                      ),
                      Text(
                        "€\t${widget.price}",
                        style: AppTextStyles.bodyMain16400(color: AppColors.black1),
                      ),
                    ],
                  ),
                  Space.spacer(0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Coupon Code: ",
                        style: AppTextStyles.bodyMain16400(color: AppColors.black1),
                      ),
                      Text(
                        "${widget.couponCode}",
                        style: AppTextStyles.bodyMain16400(color: AppColors.black1),
                      ),
                    ],
                  ),
                  Space.spacer(0.01),
                  GestureDetector(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: widget.couponCode));
                      Warnings.onSuccess("Successfully Copied to clipboard.");
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.black2,
                          width: 1
                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.copy),
                          Text(
                            "Tap To copy to Clipboard",
                            style: AppTextStyles.bodyMain16400(color: AppColors.black1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Add other details from the image using Text widgets

                ],
              ),
            ),
            Space.spacer(0.01),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                backColor: AppColors.tertiaryColor,
                txtColor: AppColors.black6,
                txt: "Go back to Home",
                onPressed: () {
                  Get.off(() => HomePageScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
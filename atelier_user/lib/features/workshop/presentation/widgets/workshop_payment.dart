import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/warnings.dart';
import 'package:atelier_user/features/workshop/data/workshop_controller.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/workshop_qr_page.dart';
import 'package:atelier_user/global/global_firebase.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../global/global_models/workshop_model.dart';
import '../../../checkout/data/stripe_service.dart';

class WorkshopPayment extends StatefulWidget {
  final WorkshopModel model;
  final Map attendeeData;

  const WorkshopPayment({
    Key? key,
    required this.model,
    required this.attendeeData,
  }) : super(key: key);

  @override
  State<WorkshopPayment> createState() => _WorkshopPaymentState();
}

class _WorkshopPaymentState extends State<WorkshopPayment> {
  TextEditingController couponCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final price = int.parse(widget.model.price);
    final length = widget.attendeeData.length;
    final totalMoney = price * length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          "Payment Checkout",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _workshopCart(widget.model),
            SizedBox(height: 20),
            Divider(thickness: 1),
            SizedBox(height: 10),
            _buildSummaryRow("Items:", "${widget.attendeeData.length}"),
            SizedBox(height: 10),
            Divider(thickness: 1),
            SizedBox(height: 10),
            Obx(()=> _buildSummaryRow("Order Total:", "€${totalMoney-WorkshopController.couponAmount.value}")),
            SizedBox(height: 10),
            Divider(thickness: 1),
            SizedBox(height: 10),
            _buildPromoCodeField(),
            Spacer(),
            Container(
              width: double.infinity,
              child: CustomElevatedButton(backColor: AppColors.tertiaryColor, txtColor: AppColors.black6, txt:
                  'Buy Now', onPressed: () async {
                // Get.to(()=>WorkshopQrPage(model: widget.model,attendeeData: widget.attendeeData,));

                try {
                  print("Initializing payment sheet...");
                  final price = totalMoney-WorkshopController.couponAmount.value;
                  print(price);
                  await StripeService.initPaymentSheet(price.toInt().toString(), "usd");
                  print("Presenting payment sheet...");
                  await StripeService.presentPaymentSheet().then((value) {
                    addWorkshopToPurchase();
                    Get.to(()=>WorkshopQrPage(model: widget.model,attendeeData: widget.attendeeData,));
                  },);
                  print("Payment sheet presented.");
                } catch (e) {
                  print("Failed to initialize payment sheet: $e");
                  Get.snackbar("Alert", "$e");
                }
              })
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _workshopCart(WorkshopModel model) {
    return Container(
      height: 120,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(model.imageUrl, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title.toUpperCase(),
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Price : €${model.price}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(fontSize: 16, color: Colors.black)),
      ],
    );
  }

  Widget _buildPromoCodeField() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: couponCode,
            style: TextStyle(fontSize: 14, color: AppColors.black4),
            decoration: InputDecoration(
              hintText: "Promo code",
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.black3, width: 1),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.black3, width: 1),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange, // Customize button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              GlobalFirebase.checkCouponPrice(couponCode.text).then((value) {
                WorkshopController.couponAmount.value = value;
                couponCode.clear();
              },);
            },
            child: Text(
              "Apply",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> addWorkshopToPurchase() async {

    List emails = widget.attendeeData.values
        .map((data) => data['Email'] ?? '')
        .where((email) => email.isNotEmpty)
        .toList();
    await GlobalFirebase.cloud
        .collection("Users")
        .doc(GlobalFirebase.auth.currentUser!.uid)
        .collection("purchasedItems")
        .doc(GlobalFirebase.auth.currentUser!.uid)
        .collection("workshop")
        .doc(widget.model.wId)
        .set({'wId': widget.model.wId,'emails' : emails
    });
}
}

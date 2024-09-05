import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/warnings.dart';
import 'package:atelier_user/features/gift_card/presentation/widgets/gift_card_page.dart';
import 'package:atelier_user/features/homepage/presentation/screens/home_page.dart';
import 'package:atelier_user/features/workshop/data/workshop_controller.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/workshop_qr_page.dart';
import 'package:atelier_user/global/global_firebase.dart';
import 'package:atelier_user/global/global_models/gift_card_model.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../global/global_models/workshop_model.dart';
import '../../../checkout/data/cart_controller.dart';
import '../../../checkout/data/stripe_service.dart';
import 'after_purchased_page.dart';

class GiftCardBuyPage extends StatefulWidget {
  final GiftCardModel model;

  const GiftCardBuyPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<GiftCardBuyPage> createState() => _GiftCardBuyPageState();
}

class _GiftCardBuyPageState extends State<GiftCardBuyPage> {
  TextEditingController couponCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final price = int.parse(widget.model.price);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
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
            _giftCart(widget.model),
            SizedBox(height: 20),
            Divider(thickness: 1),
            SizedBox(height: 10),
            _buildSummaryRow("Total:", "€ ${widget.model.price}"),
            SizedBox(height: 10),
            Divider(thickness: 1),
          //   SizedBox(height: 10),
          // _buildSummaryRow("Order Total:", "€${widget.model.price}"),
          //   SizedBox(height: 10),
          //   Divider(thickness: 1),
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
                    // final price = totalMoney-WorkshopController.couponAmount.value;
                    print(price);
                    await StripeService.initPaymentSheet(price.toInt().toString(), "usd");
                    print("Presenting payment sheet...");
                    await StripeService.presentPaymentSheet().then((value) {
                      Warnings.onSuccess("Gift Card Successfully Purchased");
                      addGiftCardToPurchase();
                      Get.to(()=>AfterPurchasedPage(price:int.parse(widget.model.price), couponCode: widget.model.code,));

                    },);
                    print("Payment sheet presented.");
                  } catch (e) {
                    print("Failed to initialize payment sheet: $e");
                    Get.snackbar("Alert", "Something is Wrong");
                  }
                })
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _giftCart(GiftCardModel model) {
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
          flex: 4,
          child: TextField(
            controller: couponCode,
            style: TextStyle(fontSize: 16, color: Colors.black),
            decoration: InputDecoration(
              hintText: "Promo code",
              hintStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            ),
          ),
        ),
        SizedBox(width: 8), // Adjust spacing to match the design
        Expanded(
          flex: 2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandColor, // Apply button color
              padding: EdgeInsets.symmetric(vertical: 12), // Adjust button padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Match button border radius
              ),
            ),
            onPressed: () {
              GlobalFirebase.checkCouponPrice(couponCode.text).then((value) {
                CartController.isCouponUsed.value = true;
                CartController.couponValue.value=value;
                couponCode.clear();
              });
            },
            child: Text("Apply", style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Future<void> addGiftCardToPurchase() async {

    // List emails = widget.attendeeData.values
    //     .map((data) => data['Email'] ?? '')
    //     .where((email) => email.isNotEmpty)
    //     .toList();
    await GlobalFirebase.cloud
        .collection("Users")
        .doc(GlobalFirebase.auth.currentUser!.uid)
        .collection("purchasedItems")
        .doc(GlobalFirebase.auth.currentUser!.uid)
        .collection("gift_cards")
        .doc(widget.model.gId)
        .set({'gId': widget.model.gId,'code':widget.model.code,'price':int.parse(widget.model.price)
    });
    
    await GlobalFirebase.cloud.collection("gift_cards").doc(widget.model.gId).update(
        {
          'isPurchased' : true
        });
  }

}

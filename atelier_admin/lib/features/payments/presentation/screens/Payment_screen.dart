import 'package:atelier_admin/features/payments/data/models/purchase_model.dart';
import 'package:atelier_admin/features/payments/presentation/widgets/custom_payment_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../global_firebase.dart';
import '../../../../global_models/user_model.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: GlobalFirebase.cloud.collection("payments").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show progress indicator while waiting for data
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle errors (optional)
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length, // Use data.length directly
            reverse: true,
            itemBuilder: (context, index) {
              final docSnapshot = data[index]; // Access data directly
              final purchaseModel = PurchaseModel.fromJson(docSnapshot.data());
              return Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: CustomPaymentCard(model: purchaseModel),
              );
            },
          );
        }
      },
    );

  }
}

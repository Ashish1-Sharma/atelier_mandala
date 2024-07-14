import 'dart:convert';

import 'package:atelier_admin/global_widgets/custom_elevated_button.dart';
import 'package:atelier_admin/global_widgets/custom_normal_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../global_firebase.dart';
import '../../../../global_models/user_model.dart';
import '../../../payments/data/models/purchase_model.dart';

class CreateUsers extends StatefulWidget {
  const CreateUsers({super.key});

  @override
  State<CreateUsers> createState() => _CreateUsersState();
}

class _CreateUsersState extends State<CreateUsers> {
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  DateTime? time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: key,
          child:Column(
            children: [
              CustomNormalTextField(
                controller: name,
                hint: "Enter your name",
                // Pre-fill with dummy name for demonstration
                // initialValue: "John Doe",
              ),
              CustomNormalTextField(
                controller: email,
                hint: "Enter your email",
                // Pre-fill with dummy email for demonstration
                // initialValue: "johndoe@example.com",
              ),
              ElevatedButton(
                onPressed: () async {
                  // Validate user input before creating a PurchaseModel instance
                  if (name.text.isEmpty) {
                    // Handle invalid input (e.g., show a snackbar or dialog)
                    return;
                  }

                  final purchaseModel = PurchaseModel(
                    name: name.text,
                    email: email.text,
                    event: "Placeholder Event", // Replace with actual event name
                    price: 230, // Replace with actual payment amount
                    paymentStatus: "Pending", // Replace with actual payment status
                    purchasedDate: DateFormat("dd MMM yyyy").format(DateTime.fromMillisecondsSinceEpoch(int.parse(DateTime.now().millisecondsSinceEpoch.toString()))),
                    // purchasedTime: TimeOfDay.now(),
                  );

                  // Send purchaseModel data to Firebase (assuming GlobalFirebase is configured)
                  await GlobalFirebase.cloud
                      .collection("payments") // Update collection name if needed
                      .doc(purchaseModel.purchasedDate)
                      .set(purchaseModel.toJson())
                      .then((_) {
                    // Clear text fields after successful creation (optional)
                    name.clear();
                    email.clear();
                  });
                },
                child: Text("Create"),
              ),
            ],
          ),

        ),
      ),
    );
  }
}

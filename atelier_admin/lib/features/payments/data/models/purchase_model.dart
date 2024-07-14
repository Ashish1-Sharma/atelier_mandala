import 'package:flutter/material.dart';

class PurchaseModel {
  final String name;
  final String email;
  final String event;
  final int price;
  final String paymentStatus;
  final String purchasedDate;

  PurchaseModel({
    required this.name,
    required this.email,
    required this.event,
    required this.price,
    required this.paymentStatus,
    required this.purchasedDate,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      name: json['name'] ?? '',
      email: json['email']?? '',
      event: json['event']?? '',
      price: json['price'] ?? 0,
      paymentStatus: json['paymentStatus']?? '',
      purchasedDate: json['purchasedDate'] ?? '',
      // purchasedTime: TimeOfDay(
      //   hour: int.parse(json['purchasedTime'].split(":")[0]?? ''),
      //   minute: int.parse(json['purchasedTime'].split(":")[1].split(" ")[0]?? ''),
      // ),
    );}

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'event': event,
    'price': price,
    'paymentStatus': paymentStatus,
    'purchasedDate': purchasedDate, // Convert DateTime to milliseconds
    // 'purchasedTime': purchasedTime.toString(), // Convert TimeOfDay to string
  };
}
import 'dart:convert';

import 'package:atelier_user/constraints/fonts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../constraints/constants.dart';

class StripeService{
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret = "sk_test_51K3MhlBE3pq73oUMBiObewRNivGWP26rSpgudxoVKkASiHrFZeHQZLQwPDPTTaruVWcrwcJB20VF44M97joAq0t800HFkKNIBS";

  static Map<String , String> headers = {
    'Authorization' : 'Bearer ${StripeService.secret}',
    "Content-Type": 'application/x-www-form-urlencoded'
  };
  // static init(){
  //   Stripe.publishableKey = "pk_test_51K3MhlBE3pq73oUMGjRV8bv2m1bK8HLT2idleBy8RQWDZQDM4ypg7t9WRKEHx9hS8yJmB4RttRWMwiXaTz4k7ITx00r7dTzuu4";
  // }
  static Future<Map<String,dynamic>> createPaymentIntent(
      String amount , String currency) async {
    try{
      Map<String,dynamic> body = {
        'amount' : (int.parse(amount) * 100).toString(),
        'currency' :  currency,
        'payment_method_types[]' : 'card',
      };
      var response = await http.post(Uri.parse(StripeService.paymentApiUrl),
      body: body,
      headers: StripeService.headers);

      return jsonDecode(response.body);
    } catch(e){
      // print(e);
      throw Exception("Failed to create payment Intent");
    }
  }
   static Future<void> initPaymentSheet(String amount , String currency) async{
    try{
      final paymentIntent = await createPaymentIntent(amount, currency);
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent['client_secret'],
        merchantDisplayName: 'Ashish sharma',
        style: ThemeMode.system,
        billingDetails: BillingDetails.fromJson(paymentIntent),
        customerId: paymentIntent['id']
      ));
    } catch (e){
      throw Exception("Failed to initialize payment sheet");
    }
   }
  static Future<void> presentPaymentSheet() async {
    try {
      print("checking 123");
      await Stripe.instance.presentPaymentSheet().then((value) {
        print("hello present payment sheet successfully opened");
      },);
      // await Stripe.instance.confirmPaymentSheetPayment();
      print("Payment sheet presented successfully.");
    } catch (e) {
      throw Exception("Failed to present payment sheet: $e");
    }
  }
}
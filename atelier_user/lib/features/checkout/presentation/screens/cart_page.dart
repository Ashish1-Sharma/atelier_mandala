import 'dart:convert';

import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/constants.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/checkout/data/cart_controller.dart';
import 'package:atelier_user/features/checkout/data/cart_services.dart';
import 'package:atelier_user/features/checkout/presentation/widgets/gift_cart_card.dart';
import 'package:atelier_user/features/checkout/presentation/widgets/store_cart_order.dart';
import 'package:atelier_user/features/checkout/presentation/widgets/takeaway_cart_order.dart';
import 'package:atelier_user/features/checkout/presentation/widgets/workshop_cart_order.dart';
import 'package:atelier_user/global/global_firebase.dart';
import 'package:atelier_user/global/global_models/gift_card_model.dart';
import 'package:atelier_user/global/global_models/store_model.dart';
import 'package:atelier_user/global/global_models/takeaway_model.dart';
import 'package:atelier_user/global/global_widgets/custom_counter.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

import '../../../../constraints/space.dart';
import '../../../../global/global_models/workshop_model.dart';
import '../../data/stripe_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<TextEditingController> workshopController = [];
  List<String> workshopPrice = [];
  List<TextEditingController> takeawayController = [];
  List<String> takeawayPrice = [];
  List<TextEditingController> storeController = [];
  List<String> storePrice = [];
  List<TextEditingController> giftController = [];
  List<String> giftPrice = [];
  TextEditingController couponCode = TextEditingController();
  // int items =0;
  Map<String, List<Map<String, dynamic>>> data = {
    'workshops': [],
    'takeaway': [],
    'storeItems': [],
    'giftcards': [],
  };
  // double totalPrice = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration.zero);
    CartController.isClicked.value = false;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black5,
      body: SafeArea(
        child: Container(
          // color: Colors.red,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space.spacer(0.01),
                Text(
                  "Products",
                  style: AppTextStyles.bodyMain14_1(
                      color: AppColors.tertiaryColor),
                ),
                Space.spacer(0.01),
                _workshopBuilder(),
                _takeawayBuilder(),
                _storeBuilder(),
                _giftCardBuilder(),
                Space.spacer(0.02),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: couponCode,
                        style:
                            AppTextStyles.bodyMain14_2(color: AppColors.black2),
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "Enter Coupon Code",
                          hintStyle: AppTextStyles.bodyMain14_2(
                              color: AppColors.black4),
                          filled: true,
                          fillColor: AppColors.black6,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(0)),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(AppColors.brandColor),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          onPressed: () {
                            CartServices.checkCouponPrice(couponCode.text).then((value) {
                              couponCode.clear();
                            },);
                          },
                          child: Text(
                            "Apply",
                            style: AppTextStyles.bodyMain14_1(
                                color: AppColors.black6),
                          )),
                    ),
                  ],
                ),
                Space.spacer(0.02),
                Text(
                  "Price Details",
                  style: AppTextStyles.bodyMain14_1(
                      color: AppColors.tertiaryColor),
                ),
                Space.spacer(0.015),
                Obx(()=> CartController.isClicked.value ? calculations() : SizedBox()),
                Space.spacer(0.01),
                Container(
                    width: double.infinity,
                    child: CustomElevatedButton(
                        backColor: AppColors.brandColor,
                        txtColor: AppColors.black6,
                        txt: "Calculate",
                        onPressed: () {
                          CartController.isClicked.value = true;
                          calculateTotalItems(data);
                          calculateTotalPrice(data);
                          // CartController.totalPrice.value = calculateTotalPrice();
                        })),
                Space.spacer(0.01),
                Container(
                    width: double.infinity,
                    child: CustomElevatedButton(
                        backColor: AppColors.brandColor,
                        txtColor: AppColors.black6,
                        txt: "Check Out",
                        onPressed: () async {
                          print("-----------------------------------------------");
                          print("hello");
                          try {
                            print("Initializing payment sheet...");
                            final price = CartController.totalPrice.value;
                            print(price);
                            await StripeService.initPaymentSheet(price.toInt().toString(), "usd");
                            print("Presenting payment sheet...");
                            await StripeService.presentPaymentSheet().then((value) {
                              CartServices.addPurchaseItems(data);
                              Get.snackbar("alert", "Payment successfully done");
                              CartController.totalItems.value = 0;
                              CartController.totalPrice.value = 0.0;
                            },);
                            print("Payment sheet presented.");
                          } catch (e) {
                            print("Failed to initialize payment sheet: $e");
                            Get.snackbar("Alert", "$e");
                          }
                          // await StripeService.instance.makePayment();
                         // await intpayment(email: "zohaib6778@gmail.com", amount: 10);
                        })),
                Space.spacer(0.04),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        print(data);
    },)
    );
  }

   Widget _workshopBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('workshop')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final cartItems = snapshot.data!.docs;
        final length = cartItems.length;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              final data = cartItem.data() as Map<String, dynamic>? ?? {};
              final workshopId = data['wId'];
              final controller = TextEditingController();
              controller.text = '1';
              workshopController.add(controller);
               

              return StreamBuilder(
                stream: GlobalFirebase.cloud
                    .collection("workshops")
                    .where("wId", isEqualTo: workshopId)
                    .snapshots(),
                builder: (context, workshopSnapshot) {
                  if (workshopSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (workshopSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${workshopSnapshot.error}'));
                  }

                  if (!workshopSnapshot.hasData ||
                      workshopSnapshot.data!.docs.isEmpty) {
                    return Center(child: Text('Workshop item not found.'));
                  }

                  final workshopData = workshopSnapshot.data!.docs.first.data();
                  final workshopModel = WorkshopModel.fromMap(workshopData);
                  workshopPrice.add(workshopModel.price);


                  addItem('workshops',  {
                    'id' : workshopModel.wId,
                    'price' : int.parse(workshopModel.price),
                    'quantity' : 1
                  });
                  return Dismissible(
                    background: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15)),
                      child: Icon(
                        Icons.delete,
                        color: AppColors.black6,
                      ),
                    ),
                    key: ValueKey<String>(workshopId),
                    onDismissed: (DismissDirection direction) async {
                      controller.text = "0";
                      removeItem('workshops', workshopModel.wId.toString());
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('cart')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('workshop')
                          .doc(workshopId)
                          .delete()
                          .then(
                        (value) {
                           
                        },
                      );
                    },
                    child: WorkshopCartOrder(
                      model: workshopModel,
                      controller: controller,
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _takeawayBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: GlobalFirebase.cloud
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('takeaway')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final cartItems = snapshot.data!.docs;
        final length = cartItems.length;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              final data = cartItem.data() as Map<String, dynamic>? ?? {};
              final id = data['tId'];
              TextEditingController controller = TextEditingController();
              controller.text = "1";
              takeawayController.add(controller);
              // CartController.totalItems.value += int.parse(controller.text);

              return StreamBuilder<QuerySnapshot>(
                stream: GlobalFirebase.cloud
                    .collection("takeaway")
                    .where("tId", isEqualTo: id)
                    .snapshots(),
                builder: (context, takeawaySnapshot) {
                  if (takeawaySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (takeawaySnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${takeawaySnapshot.error}'));
                  }

                  if (!takeawaySnapshot.hasData ||
                      takeawaySnapshot.data!.docs.isEmpty) {
                    return Center(child: Text('Takeaway item not found.'));
                  }

                  final takeawayData = takeawaySnapshot.data!.docs.first.data()
                      as Map<String, dynamic>;
                  final takeawayModel = TakeawayModel.fromMap(takeawayData);
                  takeawayPrice.add(takeawayModel.price);

                  int quantity = 1;
                  addItem('takeaway',  {
                    'id' : takeawayModel.tId.toString(),
                    'quantity' : quantity,
                    'price' : int.parse(takeawayModel.price)
                  });
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Dismissible(
                      background: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          Icons.delete,
                          color: AppColors.black6,
                        ),
                      ),
                      key: ValueKey<String>(id),
                      onDismissed: (DismissDirection direction) {
                        controller.text = "0";
                        removeItem('takeaway', takeawayModel.tId.toString());
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('cart')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('takeaway')
                            .doc(id)
                            .delete();
                      },
                      child: TakeawayCartOrder(
                        model: takeawayModel,
                        onValueChange: (int value){
                          updateItem('takeaway',takeawayModel.tId.toString() , value);
                      }
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _storeBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: GlobalFirebase.cloud
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('store')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final cartItems = snapshot.data!.docs;
        // List<String> quantity = cartItems[]
        final length = cartItems.length;
        CartController.totalItems.value += length;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              final data = cartItem.data() as Map<String, dynamic>? ?? {};
              final id = data['sId'];
              final controller = TextEditingController();
              controller.text = "1";
              storeController.add(controller);


              return StreamBuilder(
                stream: GlobalFirebase.cloud
                    .collection("store")
                    .where("sId", isEqualTo: id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final data = snapshot.data!.docs.first.data();
                  final model = StoreModel.fromMap(data);
                  storePrice.add(model.price);


                  int quantity = 1;
                  addItem("storeItems", {
                    'id' : model.sId.toString(),
                    'quantity' : quantity,
                    'price' : int.parse(model.price)
                  });
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Dismissible(
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.delete,
                            color: AppColors.black6,
                          ),
                        ),
                        key: ValueKey<String>(id),
                        onDismissed: (DismissDirection direction) {
                          controller.text = "0";
                          removeItem('storeItems', model.sId.toString());
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('cart')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('store')
                              .doc(id)
                              .delete();
                        },
                        // margin: EdgeInsets.symmetric(vertical: 5),
                        child: StoreCartOrder(
                          model: model,
                            onValueChange: (int value){
                              updateItem('storeItems',model.sId.toString() , value);
                            }
                        ),
                      ));
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _giftCardBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: GlobalFirebase.cloud
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('gift_cards')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final cartItems = snapshot.data!.docs;
        final length = cartItems.length;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              final data = cartItem.data() as Map<String, dynamic>? ?? {};
              final id = data['gId'];

              TextEditingController controller = TextEditingController();
              controller.text = "1";
              giftController.add(controller);
              // CartController.totalItems.value += int.parse(controller.text);

              return StreamBuilder(
                stream: GlobalFirebase.cloud
                    .collection("gift_cards")
                    .where("gId", isEqualTo: id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final data = snapshot.data!.docs.first.data();
                  final model = GiftCardModel.fromMap(data);
                  giftPrice.add(model.price);
                   

                  int quantity = 1;
                  addItem('giftcards', {
                    'id' : model.gId.toString(),
                    'quantity' : quantity,
                    'price' : int.parse(model.price)

                  });

                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Dismissible(
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15)),
                          child: Icon(
                            Icons.delete,
                            color: AppColors.black6,
                          ),
                        ),
                        key: ValueKey<String>(id),
                        onDismissed: (DismissDirection direction) {
                          controller.text = "0";
                          removeItem('giftcards', model.gId.toString());
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('cart')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('gift_cards')
                              .doc(id)
                              .delete();
                        },
                        child: GiftCartCard(
                          model: model,
                            onValueChange: (int value){
                              updateItem('giftcards',model.gId.toString() , value);
                            }
                        ),
                      ));
                },
              );
            },
          ),
        );
      },
    );
  }

  void calculateTotalItems(Map<String, dynamic> data) {
    double totalItems = 0;
    for (var items in data.values) {
      for (var item in items) {
        totalItems += item['quantity'];
      }
    }
    CartController.totalItems.value = totalItems.toInt();
    print("total item successfully counted");
  }

  void calculateTotalPrice(Map<String, dynamic> data) {
    try{
      double totalPrice = 0;
      for (var items in data.values) {
        for (var item in items) {
          totalPrice += (item['quantity'] ?? 1) * (item['price'] ?? 0);
        }
      }
      CartController.totalPrice.value = totalPrice;
    } catch (e){
      print(e);
    }
    // return totalPrice;
  }

  Widget calculations() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppColors.black6),
      child: Column(
        children: [
          Obx(
          ()=> Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Item (${CartController.totalItems.value == 0 ? 0 : CartController.totalItems.value})",
                  style: AppTextStyles.bodyMain14_2(color: AppColors.black3),
                ),
                Text(
                  "€ ${CartController.totalPrice.value == 0.0 ? 0.0 : CartController.totalPrice.value}",
                  style: AppTextStyles.bodyMain14_2(color: AppColors.black3),
                ),
              ],
            ),
          ),
          // Space.spacer(0.01),
          // Obx(
          //       ()=> Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Total Price",
          //         style: AppTextStyles.bodyMain14_1(color: AppColors.black2),
          //       ),
          //       Text(
          //         "€ ${CartController.totalPrice.value == 0.0 ? 0.0 : CartController.totalPrice.value}",
          //         style: AppTextStyles.bodyMain14_1(color: AppColors.brandColor),
          //       ),
          //     ],
          //   ),
          // ),
          Space.spacer(0.01),
        ],
      )
    );
  }

  void addItem(String category,Map<String,dynamic> item){
    data[category]?.add(item);
  }

  void removeItem(String category,String id){
    final items = data[category];
    if(items != null){
      items.removeWhere((item)=>item['id'] == id);
    }
  }

  void updateItem(String category, String id, int quantity) {
    final items = data[category];
    if (items != null) {
      final index = items.indexWhere((item) => item['id'] == id);
      if (index != -1) {
        items[index]['quantity'] = quantity;
      }
    }
  }


}

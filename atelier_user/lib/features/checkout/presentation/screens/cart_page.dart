import 'dart:convert';

import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/constants.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/constraints/warnings.dart';
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
import 'package:atelier_user/global/global_svg.dart';
import 'package:atelier_user/global/global_widgets/custom_counter.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

import '../../../../constraints/space.dart';
import '../../../../global/global_errors/empty_cart.dart';
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
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration.zero);
    CartController.isClicked.value = false;
    // tabController = TabController(length: 2, vsync: ScaffoldState());
    // tabController.addListener(() {
    //   if (tabController.indexIsChanging) {
    //     CartController.isClicked.value = false;
    //     // Reset the price and items when the tab changes
    //     CartController.totalPrice.value = 0.0;
    //     CartController.totalItems.value = 0;
    //     CartController.isClicked.value = false;
    //     print(tabController);
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        backgroundColor: AppColors.black6,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black1,
              size: 20,
            )),
        title: Text("Cart Orders"),
      ),
      body: SafeArea(
        child: Container(
          // color: Colors.red,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Obx(
                () => Row(
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              CartController.tabIdx.value == 0
                                  ? AppColors.tertiaryColor
                                  : AppColors.black6)),
                      onPressed: () {
                        CartController.isClicked.value = false;
                        CartController.tabIdx.value = 0;
                        print("Takeaway items are ${data['takeaway']}");
                        data['storeItems']?.clear();
                      },
                      child: Text("Takeaway",
                          style: AppTextStyles.bodyMain16500(
                              color: CartController.tabIdx.value == 1
                                  ? AppColors.tertiaryColor
                                  : AppColors.black6)),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              CartController.tabIdx.value == 1
                                  ? AppColors.tertiaryColor
                                  : AppColors.black6)),
                      onPressed: () {
                        CartController.isClicked.value = false;
                        CartController.tabIdx.value = 1;
                        print("store items are ${data['storeItems']}");
                        data['takeaway']?.clear();
                      },
                      child: Text("Ecommerce",
                          style: AppTextStyles.bodyMain16500(
                              color: CartController.tabIdx.value == 0
                                  ? AppColors.tertiaryColor
                                  : AppColors.black6)),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Container(
                        child: CartController.tabIdx.value == 0
                            ? _takeawayBuilder()
                            : _storeBuilder())),
                    Space.spacer(0.02),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: couponCode,
                            style: AppTextStyles.bodyMain14_2(
                                color: AppColors.black2),
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
                                  backgroundColor: WidgetStateProperty.all(
                                      AppColors.brandColor),
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              onPressed: () {
                                CartServices.checkCouponPrice(couponCode.text)
                                    .then(
                                  (value) {
                                    couponCode.clear();
                                    CartController.couponValue.value = value;
                                    CartController.isCouponUsed.value = true;
                                  },
                                );
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
                    Obx(() => CartController.isClicked.value
                        ? calculations()
                        : SizedBox()),
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
                              print(
                                  "-----------------------------------------------");
                              print("hello");

                              try {
                                if (!isTimingsExist()) {
                                  print("Initializing payment sheet...");
                                  final price = CartController.totalPrice.value;
                                  print(price);
                                  await StripeService.initPaymentSheet(
                                      price.toInt().toString(), "usd");
                                  print("Presenting payment sheet...");
                                  await StripeService.presentPaymentSheet()
                                      .then(
                                    (value) {
                                      CartServices.addPurchaseItems(data);
                                      Get.snackbar(
                                          "alert", "Payment successfully done");
                                      CartController.totalItems.value = 0;
                                      CartController.totalPrice.value = 0.0;
                                    },
                                  );
                                  print("Payment sheet presented.");
                                } else {
                                  Warnings.onError("Pls select timings");
                                }
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
            ],
          ),
        ),
      ),
      //   floatingActionButton: FloatingActionButton(onPressed: (){
      //     print(data);
      // },)
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
                    // return Center(child: Text('Takeaway item not found.'));
                    return SizedBox();
                  }

                  final takeawayData = takeawaySnapshot.data!.docs.first.data()
                      as Map<String, dynamic>;
                  final takeawayModel = TakeawayModel.fromMap(takeawayData);
                  takeawayPrice.add(takeawayModel.price);

                  int quantity = 1;

                  addItem('takeaway', {
                    'id': takeawayModel.tId.toString(),
                    'quantity': quantity,
                    'price': int.parse(takeawayModel.price)
                  });
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
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
                          onValueChange: (int value) {
                            updateItem('takeaway', takeawayModel.tId.toString(),
                                value);
                          },
                          onPickupTimeSelect: (String timing) {
                            updateTiming('takeaway',
                                takeawayModel.tId.toString(), timing);
                          }),
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
                  data['takeaway']?.add();
                  addItem("storeItems", {
                    'id': model.sId.toString(),
                    'quantity': quantity,
                    'price': int.parse(model.price)
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
                            onValueChange: (int value) {
                              updateItem(
                                  'storeItems', model.sId.toString(), value);
                            },
                            onPickupTimeSelect: (String timing) {
                              updateTiming(
                                  'storeItems', model.sId.toString(), timing);
                            }),
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
    print(data['takeaway'].toString().isEmpty);
    print(data['workshops'].toString().length);
    print(data);
    CartController.totalItems.value = totalItems.toInt();
    print("total item successfully counted");
  }

  void calculateTotalPrice(Map<String, dynamic> data) {
    try {
      double totalPrice = 0;
      for (var items in data.values) {
        for (var item in items) {
          totalPrice += (item['quantity'] ?? 1) * (item['price'] ?? 0);
        }
      }
      CartController.totalPrice.value =
          totalPrice - CartController.couponValue.value;
    } catch (e) {
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
              () => Row(
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
        ));
  }

  void addItem(String category, Map<String, dynamic> item) {
    data[category]?.add(item);
  }

  void removeItem(String category, String id) {
    final items = data[category];
    if (items != null) {
      items.removeWhere((item) => item['id'] == id);
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

  void updateTiming(String category, String id, String timing) {
    final items = data[category];
    if (items != null) {
      final index = items.indexWhere((item) => item['id'] == id);
      if (index != -1) {
        items[index]['timing'] = timing;
      }
    }
  }

  bool isTimingsExist() {
    if (data['takeaway'] != null) {
      for (var item in data['takeaway']!) {
        if (item.containsKey('timing') && item['timing'] != null) {
          return false; // Timings exist
        }
      }
    }

    // Check if `storeItems` list contains any items with `timing` field
    if (data['storeItems'] != null) {
      for (var item in data['storeItems']!) {
        if (item.containsKey('timing') && item['timing'] != null) {
          return false; // Timings exist
        }
      }
    }
    return true;
  }

  Widget emptyWidget(){
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: SvgPicture.string(
            GlobalSvg.emptyCatyIllustration,
            fit: BoxFit.contain,
            height: 200,
            width: 200,
          ),
        ),
        Text(
          "Empty !",
          style: AppTextStyles.bodyMain14(color: AppColors.black2),
        ),
        const SizedBox(height: 16),
        Text(
          "It seems like Nothing is Available.",
          style: AppTextStyles.bodySmall(color: AppColors.black2),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/takeaway/presentation/widgets/custom_takeaway_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_firebase.dart';
import '../../../../global/global_models/store_model.dart';
import '../../../../global/global_models/takeaway_model.dart';
import '../../../../global/global_models/workshop_model.dart';
import '../../../checkout/presentation/widgets/takeaway_cart_order.dart';
import '../../../checkout/presentation/widgets/workshop_cart_order.dart';
import 'custom_purchased_takeaway_card.dart';

class FavoriteItemPage extends StatefulWidget {
  const FavoriteItemPage({super.key});

  @override
  State<FavoriteItemPage> createState() => _FavoriteItemPageState();
}

class _FavoriteItemPageState extends State<FavoriteItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        backgroundColor: AppColors.black6,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: AppColors.black1,size: 20,)),
        title: Text("Favorite Items"),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // _workshopBuilder(),
              _takeawayBuilder(),
              // _storeBuilder()
            ],
          ),
        ),
      ),
    );
  }


  Widget _workshopBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('purchasedItems')
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
                  final qrData = "${data['wId']}_${GlobalFirebase.uId}_${data['emails']}";
                  final DateFormat formatter = DateFormat('d MMM yyyy');
                  final date = formatter.format(DateTime.fromMillisecondsSinceEpoch(int.parse(workshopModel.startDate)));

                  return InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          print(qrData);
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text("Your QR Code"),
                            content: Container(
                              width: 300,
                              height: 300,
                              child: QrImageView(
                                data: qrData,
                                size: 300,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.black3, width: 1),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          QrImageView(
                            data: qrData,
                            size: 100,
                          ),
                          SizedBox(width: 10), // Add some spacing between the QR code and the text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Space.spacer(0.01),
                                Text(
                                  workshopModel.title.toUpperCase(),
                                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1, // Ensures the text does not overflow
                                ),
                                Text(
                                  "Date $date",
                                  style: AppTextStyles.bodySmallest(color: AppColors.black1),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1, // Ensures the text does not overflow
                                ),
                                // Uncomment and handle overflow for additional text if needed
                                // Text(
                                //   "Timing ${data['timing']}",
                                //   style: AppTextStyles.bodySmallest(color: AppColors.black1),
                                //   overflow: TextOverflow.ellipsis,
                                //   maxLines: 1,
                                // ),
                                // Text(
                                //   "Location ${StoreModel.location}",
                                //   style: AppTextStyles.bodySmallest(color: AppColors.black1),
                                //   overflow: TextOverflow.ellipsis,
                                //   maxLines: 1,
                                // ),
                              ],
                            ),
                          ),
                        ],
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

  Widget _takeawayBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: GlobalFirebase.cloud
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorite')
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
                  final qrData = "${data['id']}_${GlobalFirebase.uId}_${data['price']}_${data['quantity']}_${data['timing']}";
                  final takeawayModel = TakeawayModel.fromMap(takeawayData);
                  final DateFormat formatter = DateFormat('d MMM yyyy');
                  final date = formatter.format(DateTime.fromMillisecondsSinceEpoch(int.parse(takeawayModel.date)));
                  return CustomTakeawayCard(model: takeawayModel);
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
          .collection('purchasedItems')
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

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              final purchasedData = cartItem.data() as Map<String, dynamic>? ?? {};
              // print(data);
              final id = purchasedData['sId'];

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
                  print("asdfkjlsflj ${data}");
                  final model = StoreModel.fromMap(data);
                  final qrData = "${purchasedData['id']}_${GlobalFirebase.uId}_${purchasedData['price']}_${purchasedData['quantity']}_${purchasedData['timing']}";
                  final DateFormat formatter = DateFormat('d MMM yyyy');
                  final date = formatter.format(DateTime.fromMillisecondsSinceEpoch(int.parse(model.date)));


                  return InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          print(qrData);
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text("Your QR Code"),
                            content: Container(
                              width: 300,
                              height: 300,
                              child: QrImageView(
                                data: qrData,
                                size: 300,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.black3, width: 1),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
                        children: [
                          QrImageView(
                            data: qrData,
                            size: 100,
                          ),
                          SizedBox(width: 10), // Adds space between QR code and text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align text at the start
                              children: [
                                Space.spacer(0.01),
                                Text(
                                  model.title,
                                  style: AppTextStyles.bodySmall(color: AppColors.black1),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1, // Ensure title does not overflow
                                ),
                                Text(
                                  "Date $date",
                                  style: AppTextStyles.bodySmallest(color: AppColors.black1),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1, // Ensure date does not overflow
                                ),
                                Text(
                                  "Timing ${purchasedData['timing']}",
                                  style: AppTextStyles.bodySmallest(color: AppColors.black1),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1, // Ensure timing does not overflow
                                ),
                                // Uncomment and handle overflow for location if needed
                                // Text(
                                //   "Location ${StoreModel.location}",
                                //   style: AppTextStyles.bodySmallest(color: AppColors.black1),
                                //   overflow: TextOverflow.ellipsis,
                                //   maxLines: 1,
                                // ),
                              ],
                            ),
                          ),
                        ],
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
}

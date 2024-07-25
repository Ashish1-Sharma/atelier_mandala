import 'package:atelier_user/features/authentication/presentation/screens/log_in.dart';
import 'package:atelier_user/features/gift_card/presentation/widgets/custom_gift_card.dart';
import 'package:atelier_user/features/store/presentation/widgets/custom_store_card.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/custom_workshop_card.dart';
import 'package:atelier_user/global/global_firebase.dart';
import 'package:atelier_user/global/global_models/gift_card_model.dart';
import 'package:atelier_user/global/global_models/store_model.dart';
import 'package:atelier_user/global/global_models/takeaway_model.dart';
import 'package:atelier_user/global/global_models/workshop_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../takeaway/presentation/widgets/custom_takeaway_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.black6,
        title: Text(
          "Hello! Ashish sharma",
          style: AppTextStyles.h3Normal(color: AppColors.black2),
        ),
        // centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () {
                showMenu<String>(
                  context: context,
                  color: AppColors.black6,
                  items: [
                    PopupMenuItem(
                      onTap: () {
                        Get.toNamed("/edit_profile");
                      },
                      value: 'Item 1',
                      child: Text(
                        'Edit Profile',
                        style: AppTextStyles.bodySmallest(color: Colors.black),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Item 2',
                      child: Text(
                        'Help',
                        style: AppTextStyles.bodySmallest(color: Colors.black),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        GlobalFirebase.auth.signOut().then(
                          (value) {
                            Get.offAll(LogIn());
                          },
                        );
                      },
                      value: 'Item 3',
                      child: Text(
                        'Log out',
                        style: AppTextStyles.bodySmallest(color: Colors.black),
                      ),
                    ),
                  ],
                  position: const RelativeRect.fromLTRB(1, 0, 0, 1),
                );
              },
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset("assets/users/u_one.png")))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Space.spacer(0.02),
              Row(
                children: [
                  const Icon(
                    Icons.explore,
                    color: AppColors.black2,
                    size: 28,
                  ),
                  Space.width(0.03),
                  Text(
                    "Explore",
                    style: AppTextStyles.h3MoreNormal(color: AppColors.black2),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 30, bottom: 15),
                child: Text(
                  "Recommended Workshops",
                  style: AppTextStyles.h3MoreNormal(color: AppColors.black2),
                ),
              ),
              FutureBuilder(
                future: GlobalFirebase.cloud
                    .collection('workshops')
                    .limit(1)
                    .get(), // Get all documents
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child:
                          CircularProgressIndicator(), // Use default indicator
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    final documents = snapshot
                        .data!.docs; // Safe access after checking error state
                    final docSnapshot = documents[0];
                    final model = WorkshopModel.fromMap(docSnapshot.data());
                    return CustomWorkshopCard(model: model);
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 30, bottom: 15),
                child: Text(
                  "Are you hungry?",
                  style: AppTextStyles.h3MoreNormal(color: AppColors.black2),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                    color: AppShades.black200,
                    borderRadius: BorderRadius.circular(15)),
                child: FutureBuilder(
                  future: GlobalFirebase.cloud
                      .collection('takeaway')
                      .limit(2)
                      .get(), // Get all documents
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child:
                            CircularProgressIndicator(), // Use default indicator
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      final documents = snapshot
                          .data!.docs; // Safe access after checking error state
                      return Wrap(
                        children: List.generate(
                          snapshot.data!.size,
                          (index) {
                            final docSnapshot = documents[index];
                            final model =
                                TakeawayModel.fromMap(docSnapshot.data());

                            return CustomTakeawayCard(model: model);
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 30, bottom: 15),
                child: Text(
                  "Our Gift Cards",
                  style: AppTextStyles.h3MoreNormal(color: AppColors.black2),
                ),
              ),
              FutureBuilder(
                future: GlobalFirebase.cloud
                    .collection('gift_cards')
                    .limit(2)
                    .get(), // Get all documents
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child:
                          CircularProgressIndicator(), // Use default indicator
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    final documents = snapshot
                        .data!.docs; // Safe access after checking error state
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        runSpacing: 10,
                        children: List.generate(
                          snapshot.data!.size,
                          (index) {
                            final docSnapshot = documents[index];
                            final model =
                                GiftCardModel.fromMap(docSnapshot.data());

                            return CustomGiftCard(model: model);
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 30, bottom: 15),
                child: Text(
                  "Bestseller products in Shop",
                  style: AppTextStyles.h3MoreNormal(color: AppColors.black2),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                    color: AppShades.black200,
                    borderRadius: BorderRadius.circular(15)),
                child: FutureBuilder(
                  future: GlobalFirebase.cloud
                      .collection('store')
                      .limit(2)
                      .get(), // Get all documents
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child:
                            CircularProgressIndicator(), // Use default indicator
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      final documents = snapshot
                          .data!.docs; // Safe access after checking error state
                      return Wrap(
                        children: List.generate(
                          snapshot.data!.size,
                          (index) {
                            final docSnapshot = documents[index];
                            final model =
                                StoreModel.fromMap(docSnapshot.data());

                            return CustomStoreCard(model: model);
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              Space.spacer(0.1),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<QueryDocumentSnapshot>> getTopTwoOrAll() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('takeaway').limit(2).get();

    return querySnapshot.docs;
  }
}

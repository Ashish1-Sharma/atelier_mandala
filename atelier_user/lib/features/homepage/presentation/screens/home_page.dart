import 'package:atelier_user/features/homepage/data/home_page_services.dart';
import 'package:atelier_user/features/homepage/presentation/widgets/home_store_card.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/custom_workshop_card.dart';
import 'package:atelier_user/global/global_models/store_model.dart';
import 'package:atelier_user/global/global_models/takeaway_model.dart';
import 'package:atelier_user/global/global_models/workshop_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../takeaway/presentation/widgets/custom_takeaway_card.dart';
import '../widgets/home_page_shrimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      body: FutureBuilder(
        future: HomePageServices.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return HomePageShrimmer();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List<dynamic>).isEmpty) {
            return Center(child: Text('No data available.'));
          } else {
            final data = snapshot.data as List<dynamic>;

            // Initialize models with safe defaults
            WorkshopModel? workshopModel;
            List<TakeawayModel> takeawayModels = [];
            List<StoreModel> storeModels = [];

            // Check if data is available and assign accordingly
            if (data.isNotEmpty && data[0].data() != null) {
              workshopModel = WorkshopModel.fromMap(data[0].data());
            }

            if (data.length > 1 && data[1].data() != null) {
              takeawayModels = List.generate(
                  1, // Only one takeaway expected
                      (index) => TakeawayModel.fromMap(data[1].data())
              );
            }

            if (data.length > 2 && data[2].data() != null) {
              storeModels = List.generate(
                  data.length - 2, // Calculate the number of store models
                      (index) => StoreModel.fromMap(data[2 + index].data())
              );
            }

            return Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5, top: 30, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Curated For You",
                            style: AppTextStyles.h3500(color: AppColors.black2),
                          ),
                          Text(
                            "View",
                            style: AppTextStyles.bodySmallest(color: AppColors.black2),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 20,
                        children: workshopModel != null
                            ? [CustomWorkshopCard(model: workshopModel)]
                            : [Text('No workshops available')],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5, top: 30, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Today's Special",
                            style: AppTextStyles.h3500(color: AppColors.black2),
                          ),
                          Text(
                            "View",
                            style: AppTextStyles.bodySmallest(color: AppColors.black2),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Wrap(
                        runSpacing: 10,
                        children: takeawayModels.isNotEmpty
                            ? [CustomTakeawayCard(model: takeawayModels.first)]
                            : [Text('No takeaways available')],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5, top: 30, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Atelier's Choice",
                            style: AppTextStyles.h3500(color: AppColors.black2),
                          ),
                          Text(
                            "View",
                            style: AppTextStyles.bodySmallest(color: AppColors.black2),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Wrap(
                        spacing: 10,
                        children: storeModels.isNotEmpty
                            ? storeModels.map((model) => HomeStoreCard(model: model)).toList()
                            : [Text('No stores available')],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<QueryDocumentSnapshot>> getTopTwoOrAll() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('takeaway').limit(2).get();
    return querySnapshot.docs;
  }
}

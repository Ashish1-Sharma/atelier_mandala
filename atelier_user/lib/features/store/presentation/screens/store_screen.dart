import 'package:atelier_user/features/store/data/store_services.dart';
import 'package:atelier_user/features/store/presentation/widgets/custom_store_card.dart';
import 'package:atelier_user/features/store/presentation/widgets/store_page.dart';
import 'package:atelier_user/features/store/presentation/widgets/store_shimmer.dart';
import 'package:atelier_user/global/global_errors/lost_in_space.dart';
import 'package:atelier_user/global/global_models/store_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_controller.dart';
import '../../../../global/global_firebase.dart';
import '../../../../global/global_widgets/nothing_is_available.dart';
import '../../../workshop/presentation/widgets/workshop_page.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      body: Container(
        margin: EdgeInsets.all(10),
        child: Obx(
    ()=> GlobalController.isConnect.value ? FutureBuilder<List<StoreModel>>(
          future: StoreServices.fetchStoreItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return StoreShimmer();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              final storeModels = snapshot.data!;
              return storeModels.isEmpty ? Center(
                child: NothingIsAvailable(),
              ) : SingleChildScrollView(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 15,
                  children: storeModels.map((model) => CustomStoreCard(model: model)).toList(),
                ),
              );
            }
          },
        ): Error404Screen(),)
      ),
    );
  }
}

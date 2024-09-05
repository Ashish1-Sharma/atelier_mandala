import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/features/takeaway/data/takeaway_service.dart';
import 'package:atelier_user/features/takeaway/presentation/widgets/custom_takeaway_card.dart';
import 'package:atelier_user/features/takeaway/presentation/widgets/takeaway_page.dart';
import 'package:atelier_user/features/takeaway/presentation/widgets/takeaway_sheet.dart';
import 'package:atelier_user/features/takeaway/presentation/widgets/takeaway_shimer.dart';
import 'package:atelier_user/global/global_errors/lost_in_space.dart';
import 'package:atelier_user/global/global_models/takeaway_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_controller.dart';
import '../../../../global/global_firebase.dart';
import '../../../../global/global_widgets/nothing_is_available.dart';

class TakeawayScreen extends StatefulWidget {
  const TakeawayScreen({super.key});

  @override
  State<TakeawayScreen> createState() => _TakeawayScreenState();
}

class _TakeawayScreenState extends State<TakeawayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      body: Container(
          margin: EdgeInsets.all(10),
          child: Obx(
            () => GlobalController.isConnect.value
                ? FutureBuilder<List<TakeawayModel>>(
                    future: TakeawayService.fetchTakeaways(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return TakeawayShimer(); // Use your existing Shimmer widget here
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else {
                        final takeawayModels = snapshot.data!;
                        return takeawayModels.isEmpty
                            ? Center(
                                child: NothingIsAvailable(),
                              )
                            : SingleChildScrollView(
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 15,
                                  children: takeawayModels
                                      .map((model) =>
                                          CustomTakeawayCard(model: model))
                                      .toList(),
                                ),
                              );
                      }
                    },
                  )
                : Error404Screen(),
          )),
    );
  }
}

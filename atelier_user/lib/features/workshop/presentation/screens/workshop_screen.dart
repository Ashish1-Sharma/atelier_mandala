import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/workshop/data/workshop_service.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/custom_waiting_workshop.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/custom_workshop_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_firebase.dart';
import '../../../../global/global_models/workshop_model.dart';

class WorkshopScreen extends StatefulWidget {
  const WorkshopScreen({super.key});

  @override
  State<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends State<WorkshopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      body: FutureBuilder<List<WorkshopModel>>(
        future: WorkshopService.fetchWorkshops(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomWaitingWorkshop(); // Use your existing indicator here
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            final workshopModels = snapshot.data!;
            return SingleChildScrollView(
              child: Wrap(
                children: workshopModels.map((model) {
                  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(model.wId.toString()));
                  String month = DateFormat('MMM').format(dateTime);
                  String day = DateFormat('d').format(dateTime);
                 return Center(
                   child: Row(
                     mainAxisSize: MainAxisSize.min,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Container(
                             // alignment: Alignment.center,
                             // width: Get.width*0.2,
                             // height: Get.width*0.2,
                             padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                             decoration: BoxDecoration(
                               color: AppColors.black6,
                               borderRadius: BorderRadius.circular(10),
                               border: Border.all(
                                 width: 1,
                                 color: AppColors.black4
                               )
                             ),
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 Text("${month.toUpperCase()}",style: AppTextStyles.bodyMain16500(color: AppColors.black1),),
                                 Text("${day}",style: AppTextStyles.bodyMain16500(color: AppColors.black1),),
                               ],
                             ),
                           ),
                           Container(
                             width: 1,
                             color: AppColors.black4,
                             height: Get.height*0.3,
                           )
                         ],
                       ),
                       Space.width(0.06),
                       CustomWorkshopCard(model: model)
                     ],
                   ),
                 );
                }).toList(),
              ),
            );
          }
        },
      ),

    );
  }
}

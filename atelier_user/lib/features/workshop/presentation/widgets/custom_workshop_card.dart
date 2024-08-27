import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/workshop_page.dart';
import 'package:atelier_user/global/global_firebase.dart';
import 'package:atelier_user/global/global_function/search_ids.dart';
import 'package:atelier_user/global/global_models/workshop_model.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constraints/space.dart';

class CustomWorkshopCard extends StatefulWidget {
  final WorkshopModel model;
  const CustomWorkshopCard({super.key, required this.model});

  @override
  State<CustomWorkshopCard> createState() => _CustomWorkshopCardState();
}

class _CustomWorkshopCardState extends State<CustomWorkshopCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Get.width*0.62);
    return GestureDetector(
      onTap: () {
        Get.to(WorkshopPage(model: widget.model));
      },
      child: Container(
        width: Get.width*0.6,
        // margin: EdgeInsets.symmetric(vertical: 10,),
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.black6,
            border: Border.all(color: AppColors.black3, width: 0.5),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.network(
                      widget.model.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: (){
                            print("sucessfully added to favorite");
                          },
                          child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(Icons.favorite_border, color: AppColors.black6)),
                        )
                    )
                  ],
                )),

            Space.spacer(0.015),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      maxLines: 2,
                      widget.model.title,
                      style: AppTextStyles.bodyMain16500(color: AppColors.black1),
                    ),
                  ),
                  Space.spacer(0.01),
                  Row(
                    children: [
                      // Space.width(0.01),
                      const Icon(
                        Iconsax.location,
                        size: 20,
                        color: AppColors.black1,
                      ),
                      Space.width(0.01),
                      Text(
                        "Offline",
                        style: AppTextStyles.bodySmallest(
                            color: AppColors.black1),
                      ),
                      Space.width(0.01),
                      const Icon(
                        size: 20,
                        Icons.calendar_month,
                        color: AppColors.black1,
                      ),
                      Space.width(0.02),
                      Text(
                        DateFormat('dd MMM yyyy').format(DateTime.fromMicrosecondsSinceEpoch(int.parse(widget.model.startDate))),
                        style: AppTextStyles.bodySmallest(
                            color: AppColors.black1),
                      ),
                    ],
                  ),
                  Space.spacer(0.015),
                  Container(
                      padding: EdgeInsets.only(left: 2),
                      child: Text("€ ${widget.model.price}",style: AppTextStyles.bodyMain14_2(color: AppColors.black1))),
                  Space.spacer(0.015),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

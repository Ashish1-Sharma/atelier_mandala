import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/constraints/warnings.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/workshop_page.dart';
import 'package:atelier_user/global/global_firebase.dart';
import 'package:atelier_user/global/global_function/search_ids.dart';
import 'package:atelier_user/global/global_models/workshop_model.dart';
import 'package:atelier_user/global/global_svg.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
    print(widget.model.title);
    print(Get.width*0.62);
    return GestureDetector(
      onTap: () async {
        var connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult.first == ConnectivityResult.none) {
          print("No Internet Connection");
          Warnings.onError("Check your Internet Connection");
          throw Exception("no internet connection");
        } else{
          Get.to(WorkshopPage(model: widget.model));
        }

      },
      child: Container(
        width: Get.width*0.6,
        decoration: BoxDecoration(
            color: AppColors.black6,
            border: Border.all(color: AppColors.black3, width: 0.5),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.model.imageUrl,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Return the loaded image
                  } else {
                    return Image.asset("assets/loading_images/load_image.jpg",width: double.infinity,height: 150,); // Show a placeholder while loading
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return SvgPicture.string(
                    GlobalSvg.error404Illistration,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 150,
                  ); // Show an error illustration on failure
                },
              ),
            ),

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
                        DateFormat('dd MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.model.startDate))),
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

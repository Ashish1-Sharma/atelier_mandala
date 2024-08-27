import 'package:atelier_admin/features/workshop/presentation/widgets/workshop_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../constraints/warnings.dart';
import '../../../../global_firebase.dart';
import '../../data/models/workshop_model.dart';
import 'create_new_workshop.dart';

class CustomWorkshopCard extends StatefulWidget {
  final WorkshopModel model;

  const CustomWorkshopCard({Key? key, required this.model}) : super(key: key);

  @override
  State<CustomWorkshopCard> createState() => _CustomWorkshopCardState();
}

class _CustomWorkshopCardState extends State<CustomWorkshopCard> {
  @override
  Widget build(BuildContext context) {

    final startDate = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.model.startDate));
    DateFormat formatter = DateFormat('MMM d, yyyy', 'en_US');
    String formattedDate = formatter.format(startDate);


    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
          color: AppColors.yellow1,
            border: Border.all(
                color: AppColors.black2,
                width: 1
            ),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.model.imageUrl,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: Icon(Icons.image, color: Colors.grey[600]),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.model.title,
                  style: AppTextStyles.bodyMain16(color: AppColors.black1),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                Text(
                  formattedDate,
                  style: AppTextStyles.bodySmallest(color: AppColors.black3),
                ),
               Space.width(0.07),

                    Text(
                      "${widget.model.startTime} - ${widget.model.endTime}",
                      style: AppTextStyles.bodySmallest(color: AppColors.black3),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "${widget.model.users} Members",
                  style: AppTextStyles.bodySmall3(color: AppColors.black1),
                ),

              ],
            ),
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => Get.to(CreateNewWorkshop(model: widget.model)),
              child: Text("Edit", style: AppTextStyles.bodySmallest(color: AppColors.black1)),
            ),
            TextButton(
              onPressed: () => Get.to(WorkshopPage(model: widget.model)),
              child: Text("Preview", style: AppTextStyles.bodySmallest(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                GlobalFirebase.cloud.collection("workshops").doc(widget.model.wId).delete().then((value) {
                  Warnings.onSuccess("Successfully deleted");
                });
              },
              child: Text("Delete", style: AppTextStyles.bodySmallest(color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }
}

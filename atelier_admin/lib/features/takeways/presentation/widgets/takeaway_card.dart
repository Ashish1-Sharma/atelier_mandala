import 'package:atelier_admin/features/takeways/data/models/takeaway_model.dart';
import 'package:atelier_admin/features/takeways/presentation/widgets/create_new_takeaway.dart';
import 'package:atelier_admin/features/takeways/presentation/widgets/takeaway_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/warnings.dart';
import '../../../../global_firebase.dart';
import '../../../workshop/presentation/widgets/create_new_workshop.dart';

class TakeawayCard extends StatefulWidget {
  final TakeawayModel model;

  const TakeawayCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<TakeawayCard> createState() => _TakeawayCardState();
}

class _TakeawayCardState extends State<TakeawayCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
            color: AppColors.yellow1,
              border: Border.all(
                color: AppColors.black2,
                width: 1
              ),
              borderRadius: BorderRadius.circular(15)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.model.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 80,
                        width: 80,
                        color: Colors.grey[300],
                        child: Icon(Icons.image, color: Colors.grey[600]),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                    color: AppColors.successColor, width: 1)),
                            child: CircleAvatar(
                              radius: 3,
                              backgroundColor: AppColors.successColor,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            widget.model.title.isEmpty
                                ? "Title"
                                : widget.model.title,
                            style: AppTextStyles.bodySmall2(color: AppColors.black1),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        widget.model.description.isEmpty
                            ? "description"
                            : widget.model.description,
                        style: AppTextStyles.bodyMini3(color: AppColors.black3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () => Get.to(CreateNewTakeaway(model: widget.model)),
                child: Text("Edit",
                    style:
                    AppTextStyles.bodySmallest(color: AppColors.black1)),
              ),
              TextButton(
                onPressed: () => Get.to(TakeawayPage(model: widget.model)),
                child: Text("Preview",
                    style: AppTextStyles.bodySmallest(color: Colors.blue)),
              ),
              TextButton(
                onPressed: () {
                  GlobalFirebase.cloud
                      .collection("takeaway")
                      .doc(widget.model.tId)
                      .delete()
                      .then((value) {
                    Warnings.onSuccess("Successfully deleted");
                  });
                },
                child: Text("Delete",
                    style: AppTextStyles.bodySmallest(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

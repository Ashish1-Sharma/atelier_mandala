import 'package:atelier_admin/features/store/data/models/store_model.dart';
import 'package:atelier_admin/features/store/presentation/widgets/create_new_store_item.dart';
import 'package:atelier_admin/features/store/presentation/widgets/store_page.dart';
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

class CustomStoreCard extends StatefulWidget {
  final StoreModel model;

  const CustomStoreCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<CustomStoreCard> createState() => _CustomStoreCardState();
}

class _CustomStoreCardState extends State<CustomStoreCard> {
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
                    widget.model.imageUrl ?? '',
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
                          // SizedBox(width: 8.0),
                          Text(
                            widget.model.title.isEmpty
                                ? "Title"
                                : widget.model.title,
                            style: AppTextStyles.bodySmall2(color: AppColors.black1)
                          ),
                        ],
                      ),
                      // SizedBox(height: 8.0),
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
                onPressed: () => Get.to(CreateNewStoreItem(model: widget.model)),
                child: Text("Edit",
                    style:
                    AppTextStyles.bodySmallest(color: AppColors.black1)),
              ),
              TextButton(
                onPressed: () => Get.to(StorePage(model: widget.model)),
                child: Text("Preview",
                    style: AppTextStyles.bodySmallest(color: Colors.blue)),
              ),
              TextButton(
                onPressed: () {
                  GlobalFirebase.cloud
                      .collection("takeaway")
                      .doc(widget.model.sId)
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

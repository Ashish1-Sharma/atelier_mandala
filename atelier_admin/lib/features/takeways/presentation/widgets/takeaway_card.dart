import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/constraints/warnings.dart';
import 'package:atelier_admin/features/takeways/data/models/takeaway_model.dart';
import 'package:atelier_admin/features/takeways/presentation/widgets/takeaway_page.dart';
import 'package:atelier_admin/features/workshop/data/models/workshop_model.dart';
import 'package:atelier_admin/features/workshop/presentation/widgets/workshop_page.dart';
import 'package:atelier_admin/global_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TakeawayCard extends StatefulWidget {
  final TakeawayModel model;

  const TakeawayCard({super.key, required this.model});

  @override
  State<TakeawayCard> createState() => _TakeawayCardState();
}

class _TakeawayCardState extends State<TakeawayCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.black6,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.model.imageUrl,
                      width: 100,
                      height: 90,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null)
                          return child; // Image is loaded

                        return Container(
                          width: 100,
                          height: 90,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                          .toDouble()
                                  : null, // Handle cases where total bytes aren't available
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(
                            'Error loading image!',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      },
                    ))),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model.title,
                      style: AppTextStyles.bodyMain18(color: AppColors.black1),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.model.users} People Enrolled",
                          style: AppTextStyles.bodySmallest(
                              color: AppColors.black3),
                        ),
                        // SizedBox(width: Get.width*0.1,),/
                        Text(
                          "€ ${widget.model.price}",
                          style:
                              AppTextStyles.bodySmall(color: AppColors.black1),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/calender.svg'),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                            child: Text(widget.model.date,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodySmallest(
                                        color: AppColors.black3)
                                    .copyWith(letterSpacing: 0.3)))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/clock.svg'),
                        SizedBox(
                          width: 4,
                        ),
                        Text(widget.model.duration,
                            style: AppTextStyles.bodySmallest(
                                color: AppColors.black3))
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: PopupMenuButton(
                color: Colors.white,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Edit",
                        style:
                            AppTextStyles.bodySmallNormal(color: Colors.black),
                      ),
                    )),
                    PopupMenuItem(
                        child: TextButton(
                      onPressed: () {
                        Get.to(TakeawayPage(model: widget.model));
                      },
                      child: Text(
                        "Preview",
                        style:
                            AppTextStyles.bodySmallNormal(color: Colors.black),
                      ),
                    )),
                    PopupMenuItem(
                        child: TextButton(
                      onPressed: () {
                        GlobalFirebase.cloud
                            .collection("takeaway")
                            .doc(widget.model.tId)
                            .delete()
                            .then(
                          (value) {
                            Warnings.onSuccess("Successfully deleted");
                          },
                        );
                      },
                      child: Text(
                        "Delete",
                        style:
                            AppTextStyles.bodySmallNormal(color: Colors.black),
                      ),
                    )),
                  ];
                },
                child: Icon(
                  Icons.more_vert,
                  color: AppColors.brandColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

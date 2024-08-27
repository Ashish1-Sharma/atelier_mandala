import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../data/models/workshop_model.dart';

class WorkshopPage extends StatefulWidget {
  final WorkshopModel? model;
  const WorkshopPage({super.key, required this.model});

  @override
  State<WorkshopPage> createState() => _WorkshopPageState();
}

class _WorkshopPageState extends State<WorkshopPage> {
  @override
  Widget build(BuildContext context) {
    final startDate = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.model!.startDate));
    DateFormat formatter = DateFormat('MMM d, yyyy', 'en_US');
    String formattedDate = formatter.format(startDate);

    return Scaffold(
      backgroundColor: AppColors.black6,
      body: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    widget.model!.imageUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/loading_images/store.png",
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Positioned(
                      left: 10,
                      top: 40,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: AppColors.black6,
                                borderRadius: BorderRadius.circular(15)),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.black1,
                              size: 15,
                            )),
                      ))
                ],
              ),
              Space.spacer(0.01),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Design",
                      style: AppTextStyles.bodyMain16(color: AppColors.black3),
                    ),
                    Space.spacer(0.01),
                    Text(
                      widget.model!.title,
                      style: AppTextStyles.h2(color: AppColors.black1),
                    ),
                    Space.spacer(0.01),
                    Text(
                      "€  ${widget.model!.price}",
                      style: AppTextStyles.h3(color: Colors.black),
                    ),
                    Space.spacer(0.01),
                    Divider(
                      thickness: 2,
                      color: AppColors.black4,
                    ),
                    // Space.spacer(0.01),
                    Space.spacer(0.01),
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: AppColors.black5,
                            child: const Icon(
                              Icons.calendar_month,
                              color: AppColors.black1,
                              size: 20,
                            )),
                        Space.width(0.03),
                        Text(
                          formattedDate,
                          style: AppTextStyles.bodySmallNormal(
                              color: AppColors.black1),
                        ),
                      ],
                    ),
                    Space.spacer(0.01),
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: AppColors.black5,
                            child: const Icon(
                              Icons.access_time,
                              color: AppColors.black1,
                              size: 20,
                            )),
                        Space.width(0.03),
                        Text(
                          "${widget.model!.startTime} To ${widget.model!.endTime}",
                          style: AppTextStyles.bodySmallNormal(
                              color: AppColors.black1),
                        )
                      ],
                    ),
                    Space.spacer(0.01),
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: AppColors.black5,
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.black1,
                              size: 20,
                            )),
                        Space.width(0.03),
                        Text(
                          widget.model!.location,
                          style: AppTextStyles.bodySmallNormal(
                              color: AppColors.black1),
                        ),
                      ],
                    ),
                    Space.spacer(0.01),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

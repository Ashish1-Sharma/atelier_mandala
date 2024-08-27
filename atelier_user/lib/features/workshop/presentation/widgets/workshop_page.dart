import 'package:atelier_user/global/global_function/add_ids.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_function/search_ids.dart';
import '../../../../global/global_models/workshop_model.dart';
import '../../../../global/global_widgets/custom_elevated_button.dart';
import '../../../../global/global_widgets/custom_outlined_button.dart';
import 'add_workshop.dart';

class WorkshopPage extends StatefulWidget {
  final WorkshopModel model;
  const WorkshopPage({super.key, required this.model});

  @override
  State<WorkshopPage> createState() => _WorkshopPageState();
}

class _WorkshopPageState extends State<WorkshopPage> {
  @override
  Widget build(BuildContext context) {
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
                    widget.model.imageUrl,
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
                      widget.model.title,
                      style: AppTextStyles.h2(color: AppColors.black1),
                    ),
                    Space.spacer(0.01),
                    Text(
                      "€  ${widget.model.price}",
                      style: AppTextStyles.h3MoreNormal(color: Colors.black),
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
                          "${widget.model.startDate}",
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
                          "${widget.model.startTime} To ${widget.model.endTime}",
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
                          widget.model.location,
                          style: AppTextStyles.bodySmallNormal(
                              color: AppColors.black1),
                        ),
                      ],
                    ),
                    Space.spacer(0.01),
                    Container(
                        width: double.infinity,
                        child: CustomElevatedButton(
                            backColor: AppColors.tertiaryColor,
                            txtColor: AppColors.black6,
                            txt: "Enroll Now",
                            onPressed: () {
                              Get.to(()=>AddWorkshop(model: widget.model,));
                              // AddIds.toWorkshop(widget.model.wId);
                            })),
                    Space.spacer(0.04),
                    Text("Add to Calender",style: AppTextStyles.bodyMain16500(color: AppColors.black1),),
                    SvgPicture.asset("assets/calender.svg"),
                    // Row(
                    //   children: [
                    //     Expanded(child: CustomOutlinedButton(sideColor: AppColors.brandColor, txtColor: AppColors.brandColor, txt: "\$ ${widget.model.price}", onPressed: (){})),
                    //     Space.width(0.03),
                    //     Expanded(child:
                    //     FutureBuilder(future: SearchIds.fromWorkshop(widget.model.wId), builder: (context, snapshot) {
                    //       final value = snapshot.data ?? false;
                    //       return value ? CustomElevatedButton(
                    //           backColor: AppColors.brandColor,
                    //           txtColor: AppColors.black6,
                    //           txt: "Enrolled",
                    //           onPressed: () {
                    //             print("---------------");
                    //           }) : CustomElevatedButton(
                    //           backColor: AppColors.brandColor,
                    //           txtColor: AppColors.black6,
                    //           txt: "Enroll Now",
                    //           onPressed: () {
                    //             print("---------------");
                    //             AddIds.toWorkshop(widget.model.wId);
                    //           });
                    //     }))
                    //
                    //   ],
                    // ),
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

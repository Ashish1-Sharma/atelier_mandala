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

import '../../../../constraints/space.dart';

class CustomWorkshopCard extends StatefulWidget {
  final WorkshopModel model;
  const CustomWorkshopCard({super.key,required this.model});

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
    return GestureDetector(
      onTap: (){
        Get.to(WorkshopPage(model: widget.model));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.black6,
          border: Border.all(
            color: AppColors.black3,
            width: 0.5
          ),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              fit: StackFit.loose,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.model.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )),
                Positioned(
                  left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10,bottom: 10,top: 30),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black.withOpacity(1)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                    ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                size: 20,
                                Icons.calendar_month,
                                color: AppColors.brandColor,
                              ),Space.width(0.02),
                              Text(
                                widget.model.startDate,
                                style: AppTextStyles.bodySmallest(
                                    color: AppColors.black6),
                              ),Space.width(0.03),
                              const Icon(
                                size: 20,
                                Icons.access_time_outlined,
                                color: AppColors.brandColor,
                              ),
                              Space.width(0.02),
                              Text(
                                widget.model.startTime,
                                style: AppTextStyles.bodySmallest(
                                    color: AppColors.black6),
                              ),
                            ],
                          ),
                          Space.spacer(0.01),
                          Flexible(
                              child: Text(
                            widget.model.title,
                            style: AppTextStyles.h2(color: AppColors.black6),
                          )),
                          Space.spacer(0.01),
                          Row(
                            children: [
                              Space.width(0.01),
                              const Icon(
                                Iconsax.location,
                                size: 20,
                                color: AppColors.brandColor,
                              ),
                              Space.width(0.01),
                              Text(
                                "Offline",
                                style: AppTextStyles.bodySmallest(
                                    color: AppColors.black6),
                              ),
                              Space.width(0.01),
                              const Icon(
                                size: 20,
                                Icons.attach_money,
                                color: AppColors.brandColor,
                              ),
                              Space.width(0.01),
                              Text(
                                widget.model.price,
                                style: AppTextStyles.bodySmallest(
                                    color: AppColors.black6),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            Space.spacer(0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "People Attending",
                        style: AppTextStyles.bodyBig(color: AppColors.black1),
                      ),
                      Container(
                        width: 100,
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage("assets/users/u_one.png"),
                            ),
                            const Positioned(
                              left: 20,
                              child: CircleAvatar(
                                backgroundImage: AssetImage("assets/users/u_two.png"),
                              ),
                            ),
                            const Positioned(
                              left: 40,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage("assets/users/u_one.png"),
                              ),
                            ),
                            Positioned(
                                left: 60,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text("1.2K+",style: AppTextStyles.bodySmallest(color: AppColors.black6),),

                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(
                    Icons.share,
                    color: AppColors.brandColor,
                  ),
                )
              ],
            ),
            Space.spacer(0.015),
            FutureBuilder(future: SearchIds.fromWorkshop(widget.model.wId), builder: (context, snapshot) {
              final value = snapshot.data ?? false;
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: value ? CustomElevatedButton(
                    backColor: AppColors.brandColor,
                    txtColor: AppColors.black6,
                    txt: "Booked",
                    onPressed: () {}) :  CustomElevatedButton(
                    backColor: AppColors.brandColor,
                    txtColor: AppColors.black6,
                    txt: "Book Now",
                    onPressed: () {Get.to(()=>WorkshopPage(model: widget.model));}),
              );
            },),

            Space.spacer(0.015),
          ],
        ),
      ),
    );
  }

}

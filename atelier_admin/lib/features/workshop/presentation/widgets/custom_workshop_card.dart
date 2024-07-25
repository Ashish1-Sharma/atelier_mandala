import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/constraints/warnings.dart';
import 'package:atelier_admin/features/workshop/data/models/workshop_model.dart';
import 'package:atelier_admin/features/workshop/presentation/widgets/workshop_page.dart';
import 'package:atelier_admin/global_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomWorkshopCard extends StatefulWidget {
  final WorkshopModel model;

  const CustomWorkshopCard({
    Key? key,
    required this.model
  }) : super(key: key);

  @override
  State<CustomWorkshopCard> createState() => _CustomWorkshopCardState();
}

class _CustomWorkshopCardState extends State<CustomWorkshopCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.black6,
      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(widget.model.imageUrl,width: 100,height: 90,fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child; // Image is loaded

                      return Container(
                        width: 100,
                        height: 90,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!.toDouble()
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
                    Text(widget.model.title,style: AppTextStyles.bodyMain18(color: AppColors.black1),overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${widget.model.users} People Enrolled",style: AppTextStyles.bodySmallest(color: AppColors.black3),),
                        // SizedBox(width: Get.width*0.1,),/
                        Text("€ ${widget.model.price}",style: AppTextStyles.bodySmall(color: AppColors.black1),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/calender.svg'),
                        SizedBox(width: 4,),
                        Expanded(child: Text("${widget.model.startDate} To ${widget.model.endDate}",overflow: TextOverflow.ellipsis,style: AppTextStyles.bodySmallest(color: AppColors.black3).copyWith(letterSpacing: 0.3)))
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/clock.svg'),
                        SizedBox(width: 4,),
                        Text("${widget.model.startTime} To ${widget.model.endTime}",style: AppTextStyles.bodySmallest(color: AppColors.black3))
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
                    PopupMenuItem(child: Text("Edit",style: AppTextStyles.bodySmallNormal(color: Colors.black),)),
                    PopupMenuItem(child: TextButton(
                      onPressed: (){
                        Get.to(WorkshopPage(model: widget.model));
                      },
                      child: Text("Preview",style: AppTextStyles.bodySmallNormal(color: Colors.black),),
                    )),
                    PopupMenuItem(child: TextButton(
                      onPressed: (){
                        GlobalFirebase.cloud.collection("workshops").doc(widget.model.wId).delete().then((value) {
                          Warnings.onSuccess("Successfully deleted");
                        },);
                      },
                      child: Text("Delete",style: AppTextStyles.bodySmallNormal(color: Colors.black),),
                    )),
                  ];
                },
                child: Icon(Icons.more_vert,color: AppColors.brandColor,),
              ),
            )
          ],
        ),
      ),
    );
  }
}

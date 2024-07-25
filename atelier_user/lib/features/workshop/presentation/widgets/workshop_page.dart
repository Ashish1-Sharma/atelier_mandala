import 'package:atelier_user/global/global_function/add_ids.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_function/search_ids.dart';
import '../../../../global/global_models/workshop_model.dart';
import '../../../../global/global_widgets/custom_elevated_button.dart';
import '../../../../global/global_widgets/custom_outlined_button.dart';

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
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.black6,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.brandColor,),
        ),
        title: const Text("Workshop Page"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.model.imageUrl,
              ),
              Space.spacer(0.01),
              Text("Design",style: AppTextStyles.bodyMain16(color: AppColors.black3),),
              Space.spacer(0.01),
              Text(widget.model.title,style: AppTextStyles.h2(color: AppColors.black1),),
              Space.spacer(0.01),
              Text(widget.model.description,style: AppTextStyles.bodyMain16(color: AppColors.black3),),
              Space.spacer(0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.black,
                            width: 0.5
                        )
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("View more",style: AppTextStyles.bodyMain16(color: AppColors.black1),),
                        const Icon(Icons.keyboard_arrow_down_sharp,color: AppColors.brandColor,)
                      ],
                    ),
                  )
                ],
              ),
              Space.spacer(0.01),
              Text("About Workshop",style: AppTextStyles.h4(color: AppColors.black2),),
              ListTile(
                leading: const Icon(Icons.location_on_outlined,color: AppColors.brandColor,size: 30,),
                title: Text("Location",style: AppTextStyles.bodyBig(color: AppColors.black1),),
                subtitle: Text(widget.model.location,style: AppTextStyles.bodySmall(color: AppColors.black3),),
              ),
              Space.spacer(0.01),
              ListTile(
                leading: const Icon(Icons.calendar_month,color: AppColors.brandColor,size: 30,),
                title: Text("Date",style: AppTextStyles.bodyBig(color: AppColors.black1),),
                subtitle: Text("${widget.model.startDate} To ${widget.model.endDate}",style: AppTextStyles.bodySmall(color: AppColors.black3),),
              ),
              Space.spacer(0.01),
              ListTile(
                leading: const Icon(Icons.access_time,color: AppColors.brandColor,size: 30,),
                title: Text("Location",style: AppTextStyles.bodyBig(color: AppColors.black1),),
                subtitle: Text("${widget.model.startTime} To ${widget.model.endTime}",style: AppTextStyles.bodySmall(color: AppColors.black3),),
              ),
              Space.spacer(0.01),
              ListTile(
                leading: const Icon(Icons.euro,color: AppColors.brandColor,size: 30,),
                title: Text("Price",style: AppTextStyles.bodyBig(color: AppColors.black1),),
                subtitle: Text(widget.model.price,style: AppTextStyles.bodySmall(color: AppColors.black3),),
              ),

              Space.spacer(0.01),
              Row(
                children: [
                  Expanded(child: CustomOutlinedButton(sideColor: AppColors.brandColor, txtColor: AppColors.brandColor, txt: "\$ ${widget.model.price}", onPressed: (){})),
                  Space.width(0.03),
                  Expanded(child:
                  FutureBuilder(future: SearchIds.fromWorkshop(widget.model.wId), builder: (context, snapshot) {
                    final value = snapshot.data!;
                    return value ? CustomElevatedButton(
                        backColor: AppColors.brandColor,
                        txtColor: AppColors.black6,
                        txt: "Enrolled",
                        onPressed: () {
                        }) : CustomElevatedButton(
                        backColor: AppColors.brandColor,
                        txtColor: AppColors.black6,
                        txt: "Enroll Now",
                        onPressed: () {
                          AddIds.toWorkshop(widget.model.wId);
                        });
                  }))

                ],
              ),
              Space.spacer(0.01),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/space.dart';

class UpcomingWorkshops extends StatefulWidget {
  const UpcomingWorkshops({super.key});

  @override
  State<UpcomingWorkshops> createState() => _UpcomingWorkshopsState();
}

class _UpcomingWorkshopsState extends State<UpcomingWorkshops> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Space.spacer(0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Upcoming Workshop',style: AppTextStyles.h4(color: Colors.black),),
            Text('View All',style: TextStyle(color: AppColors.brandColor),),
          ],
        ),
        Space.spacer(0.01),
        Card(
          color: AppColors.black6,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.account_circle_rounded),
                title: Text("Data and Data Science",style: AppTextStyles.bodyMain16(color: AppColors.black1),),
                subtitle: Row(
                  children: [
                    Text("324 People Enrolled",style: AppTextStyles.bodySmallest(color: AppColors.black3)),
                   SizedBox(width: Get.width*0.05,),
                    Text("Free",style: AppTextStyles.bodySmallest(color: AppColors.black3)),
                  ],
                ),
              );
            },),
        )
      ],
    );
  }
}

import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class InfoGrid extends StatefulWidget {
  const InfoGrid({super.key});

  @override
  State<InfoGrid> createState() => _InfoGridState();
}

class _InfoGridState extends State<InfoGrid> {
  final List<String> infoText = [
    "Total User",
    "Total Enrolled",
    'Takeaway Order',
    "Total Purchase",
    "Store Order",
    "Total Notification"
  ];

  // final
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // controller: d,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5
      ),
      itemCount: 6,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          color: AppColors.black6,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.user,color: AppColors.brandColor,size: 30,),
              Text("${infoText[index]}",style: AppTextStyles.bodyBig(color: Colors.black),),
              Text("470",style: AppTextStyles.h3(color: Colors.black),)
            ],
          ),
        );
      },


    );
  }
}

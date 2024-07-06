import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constraints/space.dart';

class LatestPurchases extends StatefulWidget {
  const LatestPurchases({super.key});

  @override
  State<LatestPurchases> createState() => _LatestPurchasesState();
}

class _LatestPurchasesState extends State<LatestPurchases> {
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
            Text('Latest Purchases',style: AppTextStyles.h4(color: Colors.black),),
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
                title: Text("Event Name",style: AppTextStyles.bodyMain16(color: AppColors.black1),),
                subtitle: Text("Ashish sharma",style: AppTextStyles.bodySmallest(color: AppColors.black3)),
                trailing: Text("€ 299" , style: AppTextStyles.h4(color: Colors.black),),
              );
            },),
        )
      ],
    );
  }
}

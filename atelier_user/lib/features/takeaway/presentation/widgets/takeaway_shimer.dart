
import 'package:atelier_user/constraints/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constraints/space.dart';

class TakeawayShimer extends StatefulWidget {
  const TakeawayShimer({super.key});

  @override
  State<TakeawayShimer> createState() => _TakeawayShimerState();
}

class _TakeawayShimerState extends State<TakeawayShimer> {

  Color darkBlack = AppColors.black5;
  Color lightBlack = AppColors.black5;
  // late AnimationController _controller;
  // ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(baseColor: AppColors.black4, highlightColor: AppColors.black6, child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(4, (index) {
          return singleItem();
        },),
      ),
    ));
  }
  Widget singleItem(){
    return Container(
      width: Get.width*0.46,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: AppColors.black5,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: darkBlack,
            width: 0.5
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
                color: AppColors.black4,
                borderRadius: BorderRadius.circular(15)
            ),
          ),
          Space.spacer(0.01),
          Container(
            width: double.infinity,
            height: 15,
            decoration: BoxDecoration(
                color: AppColors.black5,
                borderRadius: BorderRadius.circular(20)
            ),
          ),
          Space.spacer(0.01),
          Container(
            width: 100,
            height: 15,
            decoration: BoxDecoration(
                color: AppColors.black5,
                borderRadius: BorderRadius.circular(20)
            ),
          ),
          Space.spacer(0.01),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: AppColors.black5,
                borderRadius: BorderRadius.circular(20)
            ),
          )
        ],
      ),
    );
  }
}

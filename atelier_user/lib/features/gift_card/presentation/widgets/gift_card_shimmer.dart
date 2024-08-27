import 'package:atelier_user/constraints/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constraints/space.dart';

class GiftCardShimmer extends StatefulWidget {
  const GiftCardShimmer({super.key});

  @override
  State<GiftCardShimmer> createState() => _GiftCardShimmerState();
}

class _GiftCardShimmerState extends State<GiftCardShimmer> with TickerProviderStateMixin{

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
    // Color startColor = darkBlack;
    // Color midColor = lightBlack;
    // Color endColor = lightBlack;
    return Shimmer.fromColors(baseColor: AppColors.black4, highlightColor: AppColors.black6, child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Wrap(
        runSpacing: 10,
        children: List.generate(2, (index) {
          return singleItem();
        },),
      ),
    ));
  }
  Widget singleItem(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: AppColors.black5,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: darkBlack,
            width: 0.5
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                color: AppColors.black4,
                borderRadius: BorderRadius.circular(15)
            ),
          ),
          Space.spacer(0.01),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.black4,
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
              Space.width(0.03),
              Expanded(
                flex: 2,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.black5,
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
              Space.width(0.03),
              Expanded(
                flex: 2,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.black5,
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
            ],
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

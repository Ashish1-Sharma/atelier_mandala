import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/takeaway/presentation/widgets/takeaway_page.dart';
import 'package:atelier_user/features/takeaway/presentation/widgets/takeaway_sheet.dart';
import 'package:atelier_user/global/global_models/takeaway_model.dart';
import 'package:atelier_user/global/global_widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constraints/space.dart';

class CustomPurchasedTakeawayCard extends StatefulWidget {
  final TakeawayModel model;
  const CustomPurchasedTakeawayCard({super.key,required this.model});

  @override
  State<CustomPurchasedTakeawayCard> createState() => _CustomPurchasedTakeawayCardState();
}

class _CustomPurchasedTakeawayCardState extends State<CustomPurchasedTakeawayCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return Container(
         
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Space.spacer(0.005),
                    Text(widget.model.title.toString().substring(0,1).toUpperCase() + widget.model.title.toString().substring(1).toLowerCase(),style: AppTextStyles.bodyMain14_2(color: AppColors.black1),),
                    Space.spacer(0.005),
                    Text("€ ${widget.model.price}",style: AppTextStyles.bodyMain14_2(color: AppColors.black2),),
                  ],
                ),
              ),
        
            ],
          ),
        );
      }
    );
  }
}

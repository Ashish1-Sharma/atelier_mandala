import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/global/global_models/store_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeStoreCard extends StatefulWidget {
  final StoreModel model;
  const HomeStoreCard({super.key,required this.model});

  @override
  State<HomeStoreCard> createState() => _HomeStoreCardState();
}

class _HomeStoreCardState extends State<HomeStoreCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width*0.44,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(widget.model.imageUrl,height:Get.width*0.44,fit: BoxFit.cover,),
          ),
          Text("€ ${widget.model.price}",style: AppTextStyles.bodySmallH2(color: AppColors.black1),),
          Text(widget.model.title,maxLines: 1,style: AppTextStyles.bodySmallH2(color: AppColors.black1),)
        ],
      ),
    );
  }
}

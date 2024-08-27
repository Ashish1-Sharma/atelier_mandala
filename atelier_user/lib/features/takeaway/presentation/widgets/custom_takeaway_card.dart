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

class CustomTakeawayCard extends StatefulWidget {
  final TakeawayModel model;
  const CustomTakeawayCard({super.key, required this.model});

  @override
  State<CustomTakeawayCard> createState() => _CustomTakeawayCardState();
}

class _CustomTakeawayCardState extends State<CustomTakeawayCard> {
  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: () {
    //     Get.to(() => TakeawayPage(model: widget.model));
    //   },
    //   child: Container(
    //     width: Get.width * 0.46,
    //     // margin: EdgeInsets.symmetric(horizontal: 3),
    //     decoration: BoxDecoration(
    //         color: AppColors.black6, borderRadius: BorderRadius.circular(15)),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         ClipRRect(
    //             borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(10),
    //                 topRight: Radius.circular(10)),
    //             child: Image.network(
    //               widget.model.imageUrl,
    //               width: double.infinity,
    //               height: 130,
    //               fit: BoxFit.cover,
    //               errorBuilder: (context, error, stackTrace) {
    //                 return Image.asset("assets/loading_images/takeaway.png",width: double.infinity,height: 130,fit: BoxFit.cover,);
    //               },
    //               loadingBuilder: (BuildContext context, Widget child,
    //                   ImageChunkEvent? loadingProgress) {
    //                 if (loadingProgress == null) return child;
    //                 return Container(
    //                   foregroundDecoration: BoxDecoration(
    //                     color: Colors.grey,
    //                     backgroundBlendMode: BlendMode.saturation,
    //                   ),
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.only(
    //                         topLeft: Radius.circular(10),
    //                         topRight: Radius.circular(10)),
    //                     child: Image.asset(
    //                       "assets/loading_images/takeaway.png",
    //                       width: double.infinity,
    //                       height: 130,
    //                     ),
    //                   ),
    //                 );
    //               },
    //             )),
    //         Container(
    //           margin: const EdgeInsets.all(5),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 widget.model.title,
    //                 overflow: TextOverflow.ellipsis,
    //                 style: AppTextStyles.bodyBig(color: Colors.black),
    //               ),
    //               const Row(
    //                 children: [
    //                   Icon(
    //                     Icons.star,
    //                     color: Colors.yellow,
    //                     size: 16,
    //                   ),
    //                   Icon(
    //                     Icons.star,
    //                     color: Colors.yellow,
    //                     size: 16,
    //                   ),
    //                   Icon(
    //                     Icons.star,
    //                     color: Colors.yellow,
    //                     size: 16,
    //                   ),
    //                   Icon(
    //                     Icons.star,
    //                     color: Colors.yellow,
    //                     size: 16,
    //                   ),
    //                   Icon(
    //                     Icons.star,
    //                     color: Colors.yellow,
    //                     size: 16,
    //                   ),
    //                 ],
    //               ),
    //               Text(
    //                 "Price - \$${widget.model.price}",
    //                 style: AppTextStyles.bodyMain16(color: Colors.black),
    //               ),
    //               Space.spacer(0.01),
    //               Container(
    //                 width: double.infinity,
    //                 margin: EdgeInsets.symmetric(horizontal: 5),
    //                 child: ElevatedButton(
    //                   onPressed: () {
    //                     Get.to(() => TakeawayPage(model: widget.model));
    //                   },
    //                   style: ButtonStyle(
    //                     backgroundColor:
    //                         WidgetStateProperty.all(AppShades.red100),
    //                     shape: WidgetStateProperty.all(
    //                       RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(10),
    //                           side: const BorderSide(
    //                               color: AppColors.brandColor, width: 1)),
    //                     ),
    //                   ),
    //                   child: Container(
    //                     margin: const EdgeInsets.symmetric(vertical: 15),
    //                     child: Text(
    //                       "Buy Now",
    //                       style: AppTextStyles.bodyBig(
    //                           color: AppColors.brandColor),
    //                     ),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //         Space.spacer(0.01),
    //       ],
    //     ),
    //   ),
    // );
    return GestureDetector(
      onTap: (){
        customBottomSheet();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.black3, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.successColor, width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.all(4),
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor: AppColors.successColor,
                    ),
                  ),
                  Space.spacer(0.005),
                  Text(widget.model.title.toString().substring(0,1).toUpperCase() + widget.model.title.toString().substring(1).toLowerCase(),style: AppTextStyles.bodyMain14_2(color: AppColors.black1),),
                  Space.spacer(0.005),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.black2,
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.black2,
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.black2,
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.black2,
                        size: 16,
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.black2,
                        size: 16,
                      ),
                      Text("4.4",style: AppTextStyles.bodySmallest(color: AppColors.black2),)
                    ],
                  ),
                  Space.spacer(0.005),
                  Text("€ ${widget.model.price}",style: AppTextStyles.bodyMain14_2(color: AppColors.black2),),
                  Space.spacer(0.005),
                  Text(widget.model.description,
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: AppTextStyles.bodySmallest(color: AppColors.black1),
                  )

                ],
              ),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.network(
                      widget.model.imageUrl,
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: (){
                            print("sucessfully added to favorite");
                          },
                          child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(Icons.favorite_border, color: AppColors.black6)),
                        )
                            )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void customBottomSheet(){
    showModalBottomSheet<dynamic>(context: context,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
      ),
      builder: (context) {
      return Container(
        height: Get.height*0.68,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.center,
              child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.brandColor)
                  ),
                  onPressed: (){
                    Get.back();
                  }, icon: Icon(Icons.clear,color: AppColors.black6,size: 25,)),
            ),
            TakeawaySheet(model:widget.model,),
          ],
        ),
      );
    },);
  }
}

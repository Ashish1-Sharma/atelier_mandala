import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomCard extends StatefulWidget {
  final String image;
  final String title;
  final String subTitle1;
  final String price;
  final bool subIcon2;
  final String subTitle2;
  final SvgPicture subIcon3;
  final String subTitle3;

  const CustomCard({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle1,
    required this.price,
    required this.subIcon2,
    required this.subTitle2,
    required this.subIcon3,
    required this.subTitle3,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
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
                    child: Image.network(widget.image,width: 100,height: 90,fit: BoxFit.cover,))),

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,style: AppTextStyles.bodyMain18(color: AppColors.black1),overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.subTitle1,style: AppTextStyles.bodySmallest(color: AppColors.black3),),
                        // SizedBox(width: Get.width*0.1,),/
                        Text(widget.price,style: AppTextStyles.bodySmall(color: AppColors.black1),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        widget.subIcon2 == true ? SvgPicture.asset('assets/icons/calender.svg') : SizedBox(),
                        SizedBox(width: 4,),
                        Expanded(child: Text(widget.subTitle2,overflow: TextOverflow.ellipsis,style: AppTextStyles.bodySmallest(color: AppColors.black3).copyWith(letterSpacing: 0.3)))
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        widget.subIcon3,
                        SizedBox(width: 4,),
                        Text(widget.subTitle3,style: AppTextStyles.bodySmallest(color: AppColors.black3))
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
                    PopupMenuItem(child: Text("Edit")),
                    PopupMenuItem(child: Text("Preview")),
                    PopupMenuItem(child: Text("Delete")),
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

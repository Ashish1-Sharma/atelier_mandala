import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomGiftCard extends StatefulWidget {
  final String image;
  final String title;
  final String subTitle1;
  final String status;
  final String subTitle2;
  final SvgPicture subIcon3;
  final String subTitle3;

  const CustomGiftCard({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle1,
    required this.status,
    required this.subTitle2,
    required this.subIcon3,
    required this.subTitle3,
  }) : super(key: key);

  @override
  State<CustomGiftCard> createState() => _CustomGiftCardState();
}

class _CustomGiftCardState extends State<CustomGiftCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.black6,
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(widget.image,width: 120,height: 90,fit: BoxFit.contain,filterQuality: FilterQuality.high,))),

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,style: AppTextStyles.bodyBig(color: AppColors.black1),overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(widget.subTitle1,style: AppTextStyles.bodySmallest(color: AppColors.black3),),
                        Text(widget.status,style: AppTextStyles.bodySmall(color: widget.status == "Active" ? AppColors.successColor : AppColors.errorColor),)
                      ],
                    ),
                    SizedBox(height: 5,),
                    Text(widget.subTitle2,overflow: TextOverflow.ellipsis,style: AppTextStyles.bodySmall(color: AppColors.black3)),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        widget.subIcon3,
                        SizedBox(width: 4,),
                        Text(widget.subTitle3,style: AppTextStyles.bodySmall(color: AppColors.black3))
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

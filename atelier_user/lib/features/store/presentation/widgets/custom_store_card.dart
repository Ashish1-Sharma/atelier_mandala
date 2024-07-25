import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/store/presentation/widgets/store_page.dart';
import 'package:atelier_user/global/global_models/store_model.dart';
import 'package:atelier_user/global/global_widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/space.dart';

class CustomStoreCard extends StatefulWidget {
  final StoreModel model;
  const CustomStoreCard({super.key, required this.model});

  @override
  State<CustomStoreCard> createState() => _CustomStoreCardState();
}

class _CustomStoreCardState extends State<CustomStoreCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(StorePage(model: widget.model));
      },
      child: Container(
        width: Get.width*0.44,
        margin: EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
            color: AppColors.black6,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15)
              ),
              child: Image.network(widget.model.imageUrl,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.model.title,overflow: TextOverflow.ellipsis,style: AppTextStyles.bodyBig(color: Colors.black),),
                  const Row(
                    children: [
                      Icon(Icons.star,color: Colors.yellow,size: 20,),
                      Icon(Icons.star,color: Colors.yellow,size: 20,),
                      Icon(Icons.star,color: Colors.yellow,size: 20,),
                      Icon(Icons.star,color: Colors.yellow,size: 20,),
                      Icon(Icons.star,color: Colors.yellow,size: 20,),
                    ],
                  ),
                  Text("Price - \$${widget.model.price}",style: AppTextStyles.bodyMain16(color: Colors.black),),
                  Space.spacer(0.01),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      onPressed: (){Get.to(StorePage(model: widget.model));

                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(AppShades.red100),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: AppColors.brandColor,
                                  width: 1
                              )
                          ),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Text("Buy Now",
                          style: AppTextStyles.bodyBig(color: AppColors.brandColor),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Space.spacer(0.01),
          ],
        ),
      ),
    );
  }
}

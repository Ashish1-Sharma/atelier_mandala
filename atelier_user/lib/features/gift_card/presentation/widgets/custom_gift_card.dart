import 'package:atelier_user/features/gift_card/presentation/widgets/gift_card_page.dart';
import 'package:atelier_user/global/global_models/gift_card_model.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../constraints/warnings.dart';
import 'mail_sender.dart';

class CustomGiftCard extends StatefulWidget {
  final GiftCardModel model;
  const CustomGiftCard({super.key, required  this.model});

  @override
  State<CustomGiftCard> createState() => _CustomGiftCardState();
}

class _CustomGiftCardState extends State<CustomGiftCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult.first == ConnectivityResult.none) {
          print("No Internet Connection");
          Get.closeAllSnackbars();
          Warnings.onError("Check your Internet Connection");
          throw Exception("no internet connection");
        } else{
          Get.to(()=>GiftCardPage(model: widget.model));
        }

      },

      child: Container(
        padding: EdgeInsets.all(10),
        // decoration: BoxDecoration(
        color: AppColors.black6,
        //     borderRadius: BorderRadius.circular(15),
        //     border: Border.all(color: AppColors.black3, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image.network(
                      widget.model.imageUrl,
                      width: 150,
                      height: 100,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // Return the loaded image
                        } else {
                          return Image.asset("assets/loading_images/g_one.jpg",width: 150,height: 100,); // Show a placeholder while loading
                        }
                      },
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
                )),
            Space.width(0.02),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Space.spacer(0.01),
                  Text(widget.model.title.toString().substring(0,1).toUpperCase() + widget.model.title.toString().substring(1).toLowerCase(),style: AppTextStyles.bodySmallH2(color: AppColors.black1),),
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
                  Text("€ ${widget.model.price}",style: AppTextStyles.bodySmallH2(color: AppColors.black2),),


                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

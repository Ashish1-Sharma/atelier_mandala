
import 'package:atelier_admin/features/store/data/models/store_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global_widgets/custom_counter.dart';
import '../../../../global_widgets/custom_elevated_button.dart';

class StorePage extends StatefulWidget {
  final StoreModel model;
  const StorePage({super.key, required this.model});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    Counter.value.value = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black5,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.brandColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.model.imageUrl,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                      right: 15,
                      top: 15,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.favorite_border,
                            color: AppColors.brandColor,
                          ),
                          Space.spacer(0.01),
                          const Icon(
                            Icons.share,
                            color: AppColors.brandColor,
                          ),
                        ],
                      ))
                ],
              ),
              Space.spacer(0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Space.spacer(0.02),
                  Text(
                    widget.model.title,
                    style: AppTextStyles.h3Normal(color: AppColors.black2_5),
                  ),
                  Space.spacer(0.02),
                  Text(
                    widget.model.description,
                    style: AppTextStyles.bodySmallNormal(color: AppColors.black2_5),
                  ),
                  Space.spacer(0.02),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Text("(3.5K)",style: AppTextStyles.bodySmallest(color: AppColors.black3),)
                    ],
                  ),
                ],
              ),
              Space.spacer(0.04),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Colour",
                          style:
                          AppTextStyles.bodyMain14(color: AppColors.black1),
                        ),
                        Space.spacer(0.02),
                        // const CustomColorPicker()
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Quantity",
                          style:
                          AppTextStyles.bodyMain14(color: AppColors.black1),
                        ),
                        // Space.spacer(0.02),
                        // CustomCounter(controller: controller)
                        Text(
                          widget.model.stockQuantity == "" ? '1' :widget.model.stockQuantity,
                          style: AppTextStyles.bodyMain16(color: AppColors.black1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Space.spacer(0.04),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:atelier_admin/features/takeways/data/models/takeaway_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global_widgets/custom_counter.dart';

class TakeawayPage extends StatefulWidget {
  final TakeawayModel model;
  const TakeawayPage({super.key, required this.model});

  @override
  State<TakeawayPage> createState() => _TakeawayPageState();
}

class _TakeawayPageState extends State<TakeawayPage> {
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
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.model.imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
              Space.spacer(0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Space.spacer(0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                            widget.model.title,
                            style: AppTextStyles.h3Normal(color: AppColors.black2_5),
                          )),
                      Space.width(0.03),
                      Row(
                        children: [
                          const Icon(
                            Icons.favorite_border,
                            color: AppColors.brandColor,
                          ),
                          Space.width(0.05),
                          const Icon(
                            Icons.share,
                            color: AppColors.brandColor,
                          ),
                          Space.width(0.02),
                        ],
                      )
                    ],
                  ),
                  Space.spacer(0.02),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Text("(3.5K)",style: AppTextStyles.bodySmallest(color: AppColors.black3),)
                    ],
                  ),
                  Space.spacer(0.02),
                  Text(
                    widget.model.description,
                    style: AppTextStyles.bodySmallNormal(color: AppColors.black2_5),
                  ),
                ],
              ),
              Space.spacer(0.04),
            ],
          ),
        ),
      ),
    );
  }
}

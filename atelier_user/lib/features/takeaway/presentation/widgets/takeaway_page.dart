import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/constraints/space.dart';
import 'package:atelier_user/features/store/presentation/widgets/custom_color_picker.dart';
import 'package:atelier_user/global/global_function/add_ids.dart';
import 'package:atelier_user/global/global_models/takeaway_model.dart';
import 'package:atelier_user/global/global_widgets/custom_counter.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../gift_card/presentation/screens/gift_card_screen.dart';

class TakeawayPage extends StatefulWidget {
  final TakeawayModel model;
  const TakeawayPage({super.key,required this.model});

  @override
  State<TakeawayPage> createState() => _TakeawayPageState();
}

class _TakeawayPageState extends State<TakeawayPage> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    // Counter.value.value = 1;
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.model.imageUrl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/loading_images/takeaway.png",width: double.infinity,height: 250,fit: BoxFit.cover,);
                    },
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
                          style: AppTextStyles.h3Normal(color: AppColors.black2),
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
                    Space.spacer(0.02),
                    Text(
                      widget.model.description,
                      style: AppTextStyles.bodySmallNormal(color: AppColors.black2),
                    ),
                  ],
                ),
                Space.spacer(0.04),
                Row(
                  children: [
                    // Expanded(
                    //     child: Container(
                    //         alignment: Alignment.center,
                    //         child: CustomCounter(controller: controller,quantity: int.parse(widget.model.quantity)))),
                    // Space.width(0.02),
                    Expanded(
                        child: CustomElevatedButton(
                            backColor: AppColors.brandColor,
                            txtColor: AppColors.black6,
                            txt: "Buy Now",
                            onPressed: () {
                              AddIds.toTakeaway(widget.model.tId);
                            }))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

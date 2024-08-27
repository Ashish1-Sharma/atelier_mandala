import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/gift_card/data/gift_card_services.dart';
import 'package:atelier_user/features/gift_card/presentation/widgets/custom_gift_card.dart';
import 'package:atelier_user/features/gift_card/presentation/widgets/gift_card_page.dart';
import 'package:atelier_user/features/gift_card/presentation/widgets/gift_card_shimmer.dart';
import 'package:atelier_user/global/global_models/gift_card_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/space.dart';
import '../../../../global/global_firebase.dart';

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({super.key});

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      body:Container(
        margin: EdgeInsets.all(10),
        child: FutureBuilder<List<GiftCardModel>>(
          future: GiftCardServices.fetchGiftCards(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return GiftCardShimmer(); // Use your existing indicator here
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              final model = snapshot.data!;
              return SingleChildScrollView(
                child: Wrap(
                  runSpacing: 10,
                  children: model.map((model) => CustomGiftCard(model: model)).toList(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

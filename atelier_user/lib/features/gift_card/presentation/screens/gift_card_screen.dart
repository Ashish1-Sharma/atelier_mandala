import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/gift_card/presentation/widgets/custom_gift_card.dart';
import 'package:atelier_user/features/gift_card/presentation/widgets/gift_card_page.dart';
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
      backgroundColor: AppColors.black5,
      appBar: AppBar(
        backgroundColor: AppColors.infoColor,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.brandColor,),
        ),
      ),
      body:Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: GlobalFirebase.cloud
                    .collection('gift_cards')
                    .snapshots(),
                builder: (context, snapshot) {
                  // print(_TempController.item.value);
                  final data = snapshot.data?.docs;
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.errorColor,
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Wrap(
                      runSpacing: 20,
                      children: List.generate(snapshot.data!.docs.length, (index) {
                        final docSnapshot = data?[index]; // Access data directly
                        final model =
                        GiftCardModel.fromMap(docSnapshot!.data());
                        return CustomGiftCard(model: model);
                      },),
                    ),
                  );
                },
              ),
            ),
            Space.spacer(0.1),
          ],
        ),
      ),
    );
  }
}

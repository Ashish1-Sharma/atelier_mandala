import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/features/takeaway/presentation/widgets/custom_takeaway_card.dart';
import 'package:atelier_user/features/takeaway/presentation/widgets/takeaway_page.dart';
import 'package:atelier_user/global/global_models/takeaway_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_firebase.dart';

class TakeawayScreen extends StatefulWidget {
  const TakeawayScreen({super.key});

  @override
  State<TakeawayScreen> createState() => _TakeawayScreenState();
}

class _TakeawayScreenState extends State<TakeawayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black5,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.black5,
        leading: SvgPicture.asset("assets/navIcons/cart.svg",color: AppColors.black1,),
        title: Text("Food Takeaway",
          style: AppTextStyles.h3(color: Colors.black),),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: GlobalFirebase.cloud
                    .collection('takeaway')
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
                      children: List.generate(snapshot.data!.docs.length, (index) {
                        final docSnapshot = data?[index]; // Access data directly
                        final workshopModel =
                        TakeawayModel.fromMap(docSnapshot!.data());
                        return CustomTakeawayCard(model: workshopModel);
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

import 'package:atelier_user/features/store/presentation/widgets/custom_store_card.dart';
import 'package:atelier_user/features/store/presentation/widgets/store_page.dart';
import 'package:atelier_user/global/global_models/store_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_firebase.dart';
import '../../../workshop/presentation/widgets/workshop_page.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black5,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.black5,
        leading: SvgPicture.asset("assets/navIcons/store.svg",color: AppColors.black1,),
        title: Text("Store",
          style: AppTextStyles.h2Normal(color: AppColors.tertiaryColor),),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: GlobalFirebase.cloud
                    .collection('store')
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
                        StoreModel.fromMap(docSnapshot!.data());
                        return CustomStoreCard(model: workshopModel);
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

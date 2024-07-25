import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/features/homepage/presentation/widgets/CustomChoiceChips.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/custom_workshop_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_firebase.dart';
import '../../../../global/global_models/workshop_model.dart';
import '../widgets/workshop_page.dart';

class WorkshopScreen extends StatefulWidget {
  const WorkshopScreen({super.key});

  @override
  State<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends State<WorkshopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.black6,
        toolbarHeight: 60,
        leading: SvgPicture.asset("assets/navIcons/workshop.svg",color: AppColors.black1,),
        title: const Text("Workshops"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: GlobalFirebase.cloud
                    .collection('workshops')
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
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data?.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final docSnapshot = data?[index]; // Access data directly
                      final workshopModel =
                      WorkshopModel.fromMap(docSnapshot!.data());
                      return CustomWorkshopCard(model: workshopModel);
                    },
                  );
                },
              ),
            ),
          Space.spacer(0.1),
        ],
      ),

    );
  }
}

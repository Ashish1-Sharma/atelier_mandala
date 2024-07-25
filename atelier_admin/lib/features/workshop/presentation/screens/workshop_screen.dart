import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/features/workshop/data/models/workshop_model.dart';
import 'package:atelier_admin/features/workshop/presentation/widgets/custom_workshop_card.dart';
import 'package:atelier_admin/global_firebase.dart';
import 'package:atelier_admin/global_widgets/custom_card.dart';
import 'package:atelier_admin/global_widgets/custom_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:iconsax/iconsax.dart';

class WorkshopScreen extends StatefulWidget {
  const WorkshopScreen({super.key});

  @override
  State<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends State<WorkshopScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // var item = "";
    return Container(
      color: AppColors.black5,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    _TempController.item.value = value;
                  },
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Iconsax.search_normal,
                        color: AppColors.brandColor,
                      ),
                      hintText: "Search",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none)),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: PopupMenuButton(
                      color: Colors.white,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(child: Text("Upcoming")),
                          PopupMenuItem(child: Text("Expired")),
                        ];
                      },
                      child: SvgPicture.asset(
                        'assets/icons/filter.svg',
                        width: 30,
                      ))),
            ],
          ),
          Expanded(
            child: Obx(
              () => StreamBuilder(
                stream: GlobalFirebase.cloud
                    .collection('workshops')
                    .orderBy('title')
                    .startAt([_TempController.item.value]).endAt(
                        ["${_TempController.item.value}\uf8ff"]).snapshots(),
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
          )
        ],
      ),
    );
  }
}

class _TempController extends GetxController {
  static RxString item = "".obs;
}

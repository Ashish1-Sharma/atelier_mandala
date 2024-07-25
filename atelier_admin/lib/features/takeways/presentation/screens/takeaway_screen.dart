import 'package:atelier_admin/features/takeways/data/models/takeaway_model.dart';
import 'package:atelier_admin/features/takeways/presentation/widgets/takeaway_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constraints/colors.dart';
import '../../../../global_firebase.dart';
import '../../../../global_widgets/custom_card.dart';
import '../../../../global_widgets/custom_search_bar.dart';

class TakeawayScreen extends StatefulWidget {
  const TakeawayScreen({super.key});

  @override
  State<TakeawayScreen> createState() => _TakeawayScreenState();
}

class _TakeawayScreenState extends State<TakeawayScreen> {
  TextEditingController searchController = TextEditingController();

  // TextEditingController controller = TextEditingController();/
  @override
  Widget build(BuildContext context) {
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
                    .collection('takeaway_orders')
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
                    itemCount: snapshot.data?.docs.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final docSnapshot = data?[index]; // Access data directly
                      final model =
                      TakeawayModel.fromMap(docSnapshot!.data());
                      return TakeawayCard(model: model);
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

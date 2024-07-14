import 'package:atelier_admin/features/store/data/models/store_model.dart';
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

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  TextEditingController searchController = TextEditingController();

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
              ),Container(
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
                    .collection('store')
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
                      StoreModel.fromMap(docSnapshot!.data());
                      return CustomCard(
                        image: model
                            .imageUrl, // Assuming imageUrl is a property in model
                        title: model.title,
                        subTitle1:
                        "324 People Enrolled", // Only show if enrolledCount exists
                        price: model.price.isNotEmpty
                            ? "€ ${model.price}"
                            : "", // Only show if price exists
                        subIcon2:
                        false, // Assuming hasHighlighter is a property in model
                        subTitle2:
                        "Stock: ${model.stockQuantity}", // Assuming dateRange is a property in model
                        subIcon3: SvgPicture.asset('assets/icons/clock.svg'),
                        subTitle3:
                        "${model.time}", // Assuming timeRange is a property in WorkshopModel
                      );
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

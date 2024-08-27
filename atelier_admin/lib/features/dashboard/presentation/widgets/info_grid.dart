import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/dashboard/data/dashboard_controller.dart';
import 'package:atelier_admin/features/dashboard/data/data_source/dashboard_data.dart';
import 'package:atelier_admin/features/homepage/data/HomePageController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

class InfoGrid extends StatefulWidget {
  const InfoGrid({super.key});

  @override
  State<InfoGrid> createState() => _InfoGridState();
}

class _InfoGridState extends State<InfoGrid> {
  final List<String> infoText = [
    "Total User",
    "Total Enrolled",
    'Takeaway Order',
    "Total Purchase",
    "Store Order",
    "Total Notification"
  ];

  final List<String> _icons = [
    'users',
    'enrolled',
    't_orders',
    'payments',
    's_orders',
  ];
  // final
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // controller: d,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),

      itemCount: 5,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return StreamBuilder<int>( // Specify the data type as int (assuming stream emits integers)
          stream: DashboardData.streamCounters(index),
          builder: (context, snapshot) {
            return Container(
              color: Color(0xFFFAFAFA),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/dashboard_icons/${_icons[index]}.svg",
                    width: 40,
                  ),
                  Text(
                    "${infoText[index]}",
                    style: AppTextStyles.bodyMain16(color: Colors.black),
                  ),
                  snapshot.hasError
                      ? CircularProgressIndicator(color: AppColors.black1)
                      : Text(
                    snapshot.hasData ? "${snapshot.data}" : "-", // Display '-' if no data
                    style: AppTextStyles.h3(color: AppColors.tertiaryColor),
                  ),
                ],
              ),
            );
          },
        );

      },


    );
  }
}

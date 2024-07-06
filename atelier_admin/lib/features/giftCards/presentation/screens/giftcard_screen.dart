import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/global_widgets/custom_card.dart';
import 'package:atelier_admin/global_widgets/custom_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

import '../widgets/custom_gift_card.dart';

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({super.key});

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black5,
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: CustomSearchBar(controller: controller)),
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
            Wrap(
              children: List.generate(7, (index) {
                return CustomGiftCard(
                  image: "assets/images/workshops/g_one.png",
                  title: "Amazon Gift Card",
                  subTitle1: "Status : ",
                  status: "Active",
                  subTitle2: "Value: 6",
                  subIcon3: SvgPicture.asset('assets/icons/calender.svg'),
                  subTitle3: "Expiry on:10 Nov 2024",
                );
              },),
            )
          ],
        ),
      ),
    );
  }
}

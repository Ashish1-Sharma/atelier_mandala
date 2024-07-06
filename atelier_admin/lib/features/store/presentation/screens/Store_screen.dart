import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constraints/colors.dart';
import '../../../../global_widgets/custom_card.dart';
import '../../../../global_widgets/custom_search_bar.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
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
                return CustomCard(
                  image: "assets/images/workshops/s_one.png",
                  title: "Sveroom Chair",
                  subTitle1: "647 People Buy",
                  price: "€ 299", // Assuming 'price' and 'highlighter' are the same
                  subIcon2: false,
                  subTitle2: "Stock; 13",
                  subIcon3: SvgPicture.asset('assets/icons/calender.svg'),
                  subTitle3: "Sun-23 May",
                );
              },),
            )
          ],
        ),
      ),
    );
  }
}

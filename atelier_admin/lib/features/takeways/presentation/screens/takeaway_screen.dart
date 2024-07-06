import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constraints/colors.dart';
import '../../../../global_widgets/custom_card.dart';
import '../../../../global_widgets/custom_search_bar.dart';

class TakeawayScreen extends StatefulWidget {
  const TakeawayScreen({super.key});

  @override
  State<TakeawayScreen> createState() => _TakeawayScreenState();
}

class _TakeawayScreenState extends State<TakeawayScreen> {
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
             runSpacing: 2,
             children: List.generate(7, (index) {
               return  CustomCard(
                 image: "assets/images/workshops/t_one.png",
                 title: "Mix Vegetable",
                 subTitle1: "Type: Food",
                 price: "€ 130", // Assuming 'price' and 'highlighter' are the same
                 subIcon2: true,
                 subTitle2: "Mon-16 Jun",
                 subIcon3: SvgPicture.asset('assets/icons/clock.svg'),
                 subTitle3: "30 Minutes",
               );
             },),
           )
          ],
        ),
      ),
    );
  }
}

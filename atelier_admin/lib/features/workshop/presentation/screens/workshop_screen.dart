import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/global_widgets/custom_card.dart';
import 'package:atelier_admin/global_widgets/custom_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

class WorkshopScreen extends StatefulWidget {
  const WorkshopScreen({super.key});

  @override
  State<WorkshopScreen> createState() => _WorkshopScreenState();
}

class _WorkshopScreenState extends State<WorkshopScreen> {
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
              runSpacing: 5,
              children: List.generate(8, (index) {
                return CustomCard(
                  image: "assets/images/workshops/w_one.png",
                  title: "Data and Data Science",
                  subTitle1: "324 People Enrolled",
                  price:
                  "€ 299", // Assuming 'price' and 'highlighter' are the same
                  subIcon2: true,
                  subTitle2: "Sun-27 Apr  To  Sun-27 Apr",
                  subIcon3: SvgPicture.asset('assets/icons/clock.svg'),
                  subTitle3: "10:AM To 2:00PM",
                );
              },),
            )
          ],
        ),
      ),
    );
  }
}

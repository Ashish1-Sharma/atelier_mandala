import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/homepage/data/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/space.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<String> navTexts = [
    "Home",
    "Workshop",
    "Takeaway",
    "Store",
    "Gift card"
  ];
  List<String> navIcons = [
   "home",
    "workshop",
    "cart",
    "store",
    "gift"
  ];
  String selectedValue = "";
  PageStorageBucket bucket = PageStorageBucket();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomePageController.is_nav_selected[0] = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx(()=> PageStorage(bucket: bucket, child: HomePageController.screens[HomePageController.screenIdx.value])),
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: Card(
                elevation: 5,
                color: AppColors.black1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: (){
                          HomePageController.is_nav_selected.setAll(0, List.filled(HomePageController.is_nav_selected.length, false));
                          HomePageController.is_nav_selected[index] = !HomePageController.is_nav_selected[index];
                          HomePageController.screenIdx.value = index;
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Obx(
                            ()=> Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset("assets/navIcons/${navIcons[index]}.svg",width: 30,color: HomePageController.is_nav_selected[index]? AppColors.brandColor : AppColors.black6,),
                                Space.spacer(0.003),
                                Text("${navTexts[index]}",style: AppTextStyles.bodyMini(color: HomePageController.is_nav_selected[index]? AppColors.brandColor : AppColors.black6,),)
                              ],
                            ),
                          ),
                        ),
                      );
                    },),
                  ),
                ),
              ),
            )
          ],
                ),

      ),
    );
  }
}

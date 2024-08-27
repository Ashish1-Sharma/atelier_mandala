import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/checkout/presentation/screens/cart_page.dart';
import 'package:atelier_user/features/homepage/data/home_page_controller.dart';
import 'package:atelier_user/features/profile/presentation/screens/profile_screen.dart';
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
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.black6,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello Ashish,",style: AppTextStyles.bodyMain16400(color: AppColors.black1),),
            Text("Welcome to Atelier",style: AppTextStyles.h3500(color: AppColors.black1),)
          ],
        ),
        actions: [
          IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.black5)
              ),
              onPressed: (){
                Get.to(()=>const CartPage());
              }, icon: SvgPicture.asset("assets/icons/shopping_cart.svg",height: 25,)),
          GestureDetector(
            onTap: (){
              Get.to(()=>ProfileScreen());
            },
            child: Image.asset("assets/users/u_one.png",width: 50,),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(()=> PageStorage(bucket: bucket, child: HomePageController.screens[HomePageController.screenIdx.value])),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.black6,
        height: 85,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      SvgPicture.asset("assets/navIcons/${navIcons[index]}.svg",width: 30,color: HomePageController.is_nav_selected[index]? AppColors.tertiaryColor : AppColors.black3,),
                      Space.spacer(0.003),
                      Text("${navTexts[index]}",style: AppTextStyles.bodySmallestBold(color: HomePageController.is_nav_selected[index]? AppColors.tertiaryColor : AppColors.black3,),)
                    ],
                  ),
                ),
              ),
            );
          },),
        )
      ),
    );
  }
  
}

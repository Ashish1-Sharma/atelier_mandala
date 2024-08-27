import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:atelier_admin/features/giftCards/presentation/screens/giftcard_screen.dart';
import 'package:atelier_admin/features/homepage/data/HomePageController.dart';
import 'package:atelier_admin/features/password/presentation/screens/change_password.dart';
import 'package:atelier_admin/features/payments/presentation/screens/Payment_screen.dart';
import 'package:atelier_admin/features/profile/presentation/screens/edit_profile.dart';
import 'package:atelier_admin/features/store/presentation/screens/Store_screen.dart';
import 'package:atelier_admin/features/takeways/presentation/screens/takeaway_screen.dart';
import 'package:atelier_admin/features/takeways/presentation/widgets/create_new_takeaway.dart';
import 'package:atelier_admin/features/users/presentation/screens/user_page_screen.dart';
import 'package:atelier_admin/features/workshop/presentation/screens/workshop_screen.dart';
import 'package:atelier_admin/features/workshop/presentation/widgets/create_new_workshop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../constraints/colors.dart';
import 'widgets/Custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // HomePageController.isScreenSelected.setAll(0, List.filled(HomePageController.isScreenSelected.length, false));
    HomePageController.isScreenSelected[0] = true;
  }

  final List<dynamic> screens = [
    DashboardScreen(),
    WorkshopScreen(),
    UserPageScreen(),
    PaymentScreen(),
    TakeawayScreen(),
    GiftCardScreen(),
    StoreScreen(),
    // EditProfile(),
    ChangePassword()
  ];

  List<String> menuItems = [
    'Dashboard',
    'Workshop',
    'User',
    'Payment',
    'Manage Takeaway',
    'Publish Gift Card',
    'Manage Store',
    // 'Edit Profile',
    'Change Password',
    'Logout',
  ];

  List<String> floatingRoutes = [
    '/create_workshop',
    '/create_takeaway',
    '/create_gift_card',
    '/create_store_item',
    // '/create_user'
  ];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PageStorageBucket bucket = PageStorageBucket();
  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      key: scaffoldKey,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.black6,
        title: Obx(() => Text(
              menuItems[HomePageController.currScreen.value],
              style: AppTextStyles.h2(color: Colors.black),
            )),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // Scaffold.of(context).hasDrawer;
            scaffoldKey.currentState!.openDrawer();
          },
          icon: SvgPicture.asset("assets/icons/drawer_menu.svg"),
        ),
      ),
      drawer: Drawer(
        child: CustomDrawer(
          scaffoldKey: scaffoldKey,
        ),
      ),
      body: Obx(() => PageStorage(
          bucket: bucket, child: screens[HomePageController.currScreen.value])),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton:  Obx(
          ()=> HomePageController.showFloat.value
                ?  FloatingActionButton(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none),
                      onPressed: () {
                        int idx = HomePageController.currScreen.value;
                        print(idx);
                        if (idx == 1) {
                          // Get.toNamed(floatingRoutes[0]);
                          Get.to(()=>CreateNewWorkshop());
                        } else if (idx == 4) {
                          Get.to(()=>CreateNewTakeaway());

                          // Get.toNamed(floatingRoutes[1]);/
                        } else if (idx == 5) {
                          Get.toNamed(floatingRoutes[2]);
                        } else if (idx == 6) {
                          Get.toNamed(floatingRoutes[3]);
                        }
                      },
                      backgroundColor: AppColors.tertiaryColor,
                      child: Icon(Icons.add,color: AppColors.black6,),
                )
                : Container(),
      ),

    );
  }


}

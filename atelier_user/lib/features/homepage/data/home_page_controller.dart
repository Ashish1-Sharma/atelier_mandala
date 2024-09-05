import 'package:atelier_user/features/gift_card/presentation/screens/gift_card_screen.dart';
import 'package:atelier_user/features/homepage/presentation/screens/home_page.dart';
import 'package:atelier_user/features/store/presentation/screens/store_screen.dart';
import 'package:atelier_user/features/takeaway/presentation/screens/takeaway_screen.dart';
import 'package:atelier_user/features/workshop/presentation/screens/workshop_screen.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController{
  static RxList<String> chips = [
    "All",
    "This Week",
    "Next Week",
    "This month",
    "Next month"
  ].obs;
  static RxList<bool> is_selected = List.generate(chips.length, (index) => false,).obs;
  static RxList screens = [
    HomePage(),
    WorkshopScreen(),
    TakeawayScreen(),
    StoreScreen(),
    GiftCardScreen()
  ].obs;
  static RxInt screenIdx = 0.obs;
  static RxList<bool> is_nav_selected = List.generate(5, (index) => false,).obs;


}
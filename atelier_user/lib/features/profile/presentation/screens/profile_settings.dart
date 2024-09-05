import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/global/global_firebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../constraints/space.dart';
import '../../data/profile_controller.dart';
import '../widgets/alert_box.dart';
import '../widgets/favorite_item_page.dart';
import '../widgets/purchased_items_page.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        backgroundColor: AppColors.black6,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black1,
          ),
        ),
        title: Text(
          "Settings & activity",
          style: AppTextStyles.h3MoreNormal(color: AppColors.black1),
        ),
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Space.spacer(0.02),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space.spacer(0.01),
                  Text(
                    "Account",
                    style: AppTextStyles.bodyMain16500(color: AppColors.black1),
                  ),Space.spacer(0.01),
                  ListTile(
                    leading: Image.asset(
                      "assets/users/u_three.png",
                      width: 50,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      "Manage Account",
                      style:
                          AppTextStyles.bodyMain16400(color: AppColors.black1),
                    ),
                    subtitle: Obx(
                      ()=> Text(
                        ProfileController.email.value,
                        style:
                            AppTextStyles.bodySmallest(color: AppColors.black3),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black1,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Space.spacer(0.02),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "General",
                    style: AppTextStyles.bodyMain16500(color: AppColors.black1),
                  ),Space.spacer(0.01),
                  InkWell(
                    onTap: () {
                      Get.to(() => FavoriteItemPage());
                    },
                    child: ListTile(
                      leading: Icon(Icons.favorite_border),
                      title: Text(
                        "Saved",
                        style:
                            AppTextStyles.bodyMain16400(color: AppColors.black1),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.black1,
                        size: 15,
                      ),
                    ),
                  ),Space.spacer(0.01),
                  ListTile(
                    leading: Icon(Iconsax.notification),
                    title: Text(
                      "Notifications",
                      style:
                          AppTextStyles.bodyMain16400(color: AppColors.black1),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black1,
                      size: 15,
                    ),
                  ),Space.spacer(0.01),
                  InkWell(
                    onTap: () {
                      Get.to(() => PurchasedItemsPage());
                    },
                    child: ListTile(
                      leading: Icon(Iconsax.shop),
                      title: Text(
                        "Purchased Items",
                        style: AppTextStyles.bodyMain16400(
                            color: AppColors.black1),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.black1,
                        size: 15,
                      ),
                    ),
                  ),Space.spacer(0.01),
                  ListTile(
                    leading: Icon(Iconsax.message),
                    title: Text(
                      "Support Center",
                      style:
                          AppTextStyles.bodyMain16400(color: AppColors.black1),
                    ),
                    subtitle: Text(
                      "FAQs, chat with us, help",
                      style:
                          AppTextStyles.bodySmallest(color: AppColors.black3),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.black1,
                      size: 15,
                    ),
                  ),Space.spacer(0.01),
                  InkWell(
                    onTap: (){
                      showCustomDialog(context);
                    },
                    child: ListTile(
                      leading: Icon(Iconsax.logout),
                      title: Text("Log OUT"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.black1,
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

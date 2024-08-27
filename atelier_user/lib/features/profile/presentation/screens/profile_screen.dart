import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/profile/data/profile_controller.dart';
import 'package:atelier_user/features/profile/presentation/screens/profile_settings.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/custom_waiting_workshop.dart';
import 'package:atelier_user/global/global_function/user_info.dart';
import 'package:atelier_user/global/global_models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constraints/space.dart';
import '../../../../global/global_models/workshop_model.dart';
import '../../../homepage/data/home_page_services.dart';
import '../../../homepage/presentation/widgets/home_page_shrimmer.dart';
import '../../../workshop/presentation/widgets/custom_workshop_card.dart';
import '../../data/profile_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // late UserModel model ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileServices.get().then(
      (value) {
        ProfileController.name.value = value.name;
        ProfileController.email.value = value.email;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {
                        Get.to(() => ProfileSettings());
                      },
                      child: SvgPicture.asset("assets/menu.svg")),
                ),
                Space.spacer(0.04),
                Row(
                  children: [
                    Image.asset(
                      "assets/users/u_three.png",
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                    Space.width(0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              "${ProfileController.name}",
                              style:
                                  AppTextStyles.h3Normal(color: AppColors.black1),
                            )),
                        Space.spacer(0.005),
                        Obx(() => Text("${ProfileController.email}",
                            style: AppTextStyles.bodySmallH2(
                                color: AppColors.black1))),
                        // Space.spacer(0.005),
                        // Text("20/08/2002",style: AppTextStyles.bodySmallH2(color: AppColors.black1)),
                      ],
                    )
                  ],
                ),
                Space.spacer(0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your orders",
                      style: AppTextStyles.bodyMain16(color: AppColors.black1),
                    ),
                    Text(
                      "View All",
                      style: AppTextStyles.bodySmallest(color: AppColors.black1),
                    )
                  ],
                ),
                FutureBuilder(
                    future: ProfileServices.fetchWorkshops(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomWaitingWorkshop();
                      } else if (snapshot.hasError) {
                        return const SizedBox();
                      } else {
                        final data = snapshot.data as List<dynamic>;
                        final workshopModel =
                        List.generate(data.length,
                                (index) => WorkshopModel.fromMap(data[index].data()));
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 5, top: 30, bottom: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Curated For You",
                                    style: AppTextStyles.h3500(
                                        color: AppColors.black2),
                                  ),
                                  Text(
                                    "View",
                                    style: AppTextStyles.bodySmallest(
                                        color: AppColors.black2),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
                                  spacing: 20,
                                  children: List.generate(
                                    workshopModel.length,
                                    (index) {
                                      return CustomWorkshopCard(
                                          model: workshopModel[index]);
                                    },
                                  )),
                            ),
                          ],
                        );
                        return SizedBox();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

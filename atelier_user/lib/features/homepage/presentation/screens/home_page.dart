import 'package:atelier_user/features/homepage/data/home_page_services.dart';
import 'package:atelier_user/features/homepage/presentation/widgets/home_store_card.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/custom_workshop_card.dart';
import 'package:atelier_user/global/global_controller.dart';
import 'package:atelier_user/global/global_models/store_model.dart';
import 'package:atelier_user/global/global_models/takeaway_model.dart';
import 'package:atelier_user/global/global_models/workshop_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_errors/lost_in_space.dart';
import '../../../takeaway/presentation/widgets/custom_takeaway_card.dart';
import '../widgets/home_page_shrimmer.dart';

import '../widgets/portrait_video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late VideoPlayerController controller_one;
  late VideoPlayerController controller_two;
  late VideoPlayerController controller_three;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller_one = VideoPlayerController.asset('assets/videos/workshop_2.mp4')
      ..initialize().then((_) {
        controller_one.play();
        controller_two.play();
        //
        controller_one.setLooping(true);
        controller_one.setVolume(0.0);
        Future.delayed(Duration(milliseconds: 100), () {
          print('Controller first initialized and playing');
          setState(() {}); // Ensure the UI updates after initialization
        });
      });
    controller_two = VideoPlayerController.asset('assets/videos/workshop_2.mp4')
      ..initialize().then((_) {
        // controller_two.play();
        //
        controller_two.setLooping(true);
        controller_two.setVolume(0.0);
        Future.delayed(Duration(milliseconds: 200), () {
          print('Controller Two initialized and playing');
          setState(() {}); // Ensure the UI updates after initialization
        });
      });
    // controller_three = VideoPlayerController.asset('assets/videos/workshop_2.mp4')
    //   ..initialize().then((_) {
    //     controller_three.play();
    //     //
    //     controller_three.setLooping(true);
    //     controller_three.setVolume(0.0);
    //   });
  }

  @override
  void dispose() {
    // _controller.dispose();
    controller_one.dispose();
    controller_two.dispose();
    controller_three.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      body: Obx(
        () => GlobalController.isConnect.value
            ? FutureBuilder(
                future: _fetchDataWithConnectivityCheck(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return HomePageShrimmer();
                  } else if (snapshot.hasError) {
                    return Text("hello");
                  } else {
                    final data = snapshot.data as List<dynamic>;

                    // Initialize models with safe defaults
                    WorkshopModel? workshopModel;
                    List<TakeawayModel> takeawayModels = [];
                    List<StoreModel> storeModels = [];

                    // Check if data is available and assign accordingly
                    try {
                      if (data.isNotEmpty && data[0].data() != null) {
                        workshopModel = WorkshopModel.fromMap(data[0].data());
                      }

                      if (data.length > 1 && data[1].data() != null) {
                        takeawayModels = List.generate(
                            1, // Only one takeaway expected
                            (index) => TakeawayModel.fromMap(data[1].data()));
                      }

                      if (data.length > 2 && data[2].data() != null) {
                        storeModels = List.generate(
                            data.length -
                                2, // Calculate the number of store models
                            (index) =>
                                StoreModel.fromMap(data[2 + index].data()));
                      }
                    } catch (e) {
                      print(e);
                    }

                    return Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Space.spacer(0.02),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                      height: 247,
                                      child:  controller_one.value.isInitialized ? AspectRatio(
                                          aspectRatio: 9 / 16,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: VideoPlayer(controller_one),
                                          )) : Text("First video")),
                                  Space.width(0.03),
                                  Container(
                                      height: 247,
                                      child:  controller_two.value.isInitialized ? AspectRatio(
                                          aspectRatio: 9 / 16,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            child: VideoPlayer(controller_two),
                                          )) : Text("second video")),
                                  // Container(
                                  //   height: 247,
                                  //   child:  controller_two.value.isInitialized ? PortraitVideoPlayer(
                                  //     controller: controller_two,
                                  //   ) : Text("Second video"),
                                  // ),
                                  Space.width(0.03),
                                  // Container(
                                  //   height: 247,
                                  //   child: PortraitVideoPlayer(
                                  //     controller: controller_three,
                                  //     videoUrl: 'assets/videos/workshop_2.mp4',
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Space.spacer(0.02),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 5, top: 30, bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                children: workshopModel != null
                                    ? [CustomWorkshopCard(model: workshopModel)]
                                    : [Text('No workshops available')],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 5, top: 30, bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Today's Special",
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
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Wrap(
                                runSpacing: 10,
                                children: takeawayModels.isNotEmpty
                                    ? [
                                        CustomTakeawayCard(
                                            model: takeawayModels.first)
                                      ]
                                    : [Text('No takeaways available')],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 5, top: 30, bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Atelier's Choice",
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
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Wrap(
                                spacing: 10,
                                children: storeModels.isNotEmpty
                                    ? storeModels
                                        .map((model) =>
                                            HomeStoreCard(model: model))
                                        .toList()
                                    : [Text('No stores available')],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              )
            : Error404Screen(),
      ),
    );
  }

  Future<List<dynamic>> _fetchDataWithConnectivityCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.first == ConnectivityResult.none) {
      print("No Internet Connection");
      throw Exception("no internet connection");
    }
    print(connectivityResult[0]);

    return await HomePageServices.fetchData();
  }
}

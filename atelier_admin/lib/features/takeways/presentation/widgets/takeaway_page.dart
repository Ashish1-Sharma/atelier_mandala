import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/fonts.dart';
import '../../../../constraints/space.dart';
import '../../../../global_widgets/custom_counter.dart';
import 'package:atelier_admin/features/takeways/data/models/takeaway_model.dart';

class TakeawayPage extends StatefulWidget {
  final TakeawayModel? model;
  const TakeawayPage({super.key, this.model});

  @override
  State<TakeawayPage> createState() => _TakeawayPageState();
}

class _TakeawayPageState extends State<TakeawayPage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Counter.value.value = 1;
  }

  List<String> _parsePickupTimings(List<dynamic> timings) {
    return timings.map((timing) {
      final parts = timing.toString().split('_');
      if (parts.length == 2) {
        final start = parts[0].trim();
        final end = parts[1].trim();
        return '$start to $end';
      }
      return timing.toString();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pickupTiming = widget.model?.pickUpTimings ?? [];
    final formattedTimings = _parsePickupTimings(pickupTiming);

    return Scaffold(
      backgroundColor: AppColors.black5,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.brandColor,
          ),
        ),
        title: Text(
          'Takeaway Details',
          style: AppTextStyles.h3Normal(color: AppColors.black2_5),
        ),
        backgroundColor: AppColors.black5,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.model!.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200, // Adjust height as needed
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.model!.title,
              style: AppTextStyles.h3Normal(color: AppColors.black2_5),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) => const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 20,
              )),
            ),
            const SizedBox(width: 4),
            Text(
              "(3.5K)",
              style: AppTextStyles.bodySmallest(color: AppColors.black3),
            ),
            const SizedBox(height: 16),
            Text(
              widget.model!.description.isEmpty
                  ? "No description available."
                  : widget.model!.description,
              style: AppTextStyles.bodySmallNormal(color: AppColors.black2_5),
            ),
            const SizedBox(height: 16),
            Text(
              'Price: ${widget.model!.price}',
              style: AppTextStyles.bodySmallNormal(color: AppColors.black2_5),
            ),
            const SizedBox(height: 16),
            Text(
              'Date: ${widget.model!.date}',
              style: AppTextStyles.bodySmallNormal(color: AppColors.black2_5),
            ),
            const SizedBox(height: 16),
            Text(
              'Users: ${widget.model!.users}',
              style: AppTextStyles.bodySmallNormal(color: AppColors.black2_5),
            ),
            const SizedBox(height: 16),
            Text(
              'Location: ${widget.model!.location}',
              style: AppTextStyles.bodySmallNormal(color: AppColors.black2_5),
            ),
            const SizedBox(height: 16),
            Text(
              'ID: ${widget.model!.tId}',
              style: AppTextStyles.bodySmallNormal(color: AppColors.black2_5),
            ),
            const SizedBox(height: 16),
            Text(
              'Public: ${widget.model!.isPublic ? "Yes" : "No"}',
              style: AppTextStyles.bodySmallNormal(color: AppColors.black2_5),
            ),
            const SizedBox(height: 24),
            if (pickupTiming.isNotEmpty) ...[
              Text(
                'Pickup Slots',
                style: AppTextStyles.h3Normal(color: AppColors.black2_5),
              ),
              const SizedBox(height: 8),
              for (var timing in formattedTimings)
                ListTile(
                  leading: const Icon(Icons.access_time, color: AppColors.brandColor),
                  title: Text(
                    timing,
                    style: AppTextStyles.bodySmallNormal(color: AppColors.black2_5),
                  ),
                ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}

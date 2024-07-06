import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/features/homepage/presentation/widgets/Custom_drawer.dart';
import 'package:atelier_admin/features/dashboard/presentation/widgets/info_grid.dart';
import 'package:atelier_admin/features/dashboard/presentation/widgets/latest_purchases.dart';
import 'package:atelier_admin/features/dashboard/presentation/widgets/new_users.dart';
import 'package:atelier_admin/features/dashboard/presentation/widgets/upcoming_workshops.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black5,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            InfoGrid(),
            NewUsers(),
            LatestPurchases(),
            UpcomingWorkshops()
          ],
        ),
      ),
    );
  }
}

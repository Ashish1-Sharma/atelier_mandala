import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:flutter/cupertino.dart';

class NothingIsAvailable extends StatefulWidget {
  const NothingIsAvailable({super.key});

  @override
  State<NothingIsAvailable> createState() => _NothingIsAvailableState();
}

class _NothingIsAvailableState extends State<NothingIsAvailable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Nothing is Available",style: AppTextStyles.h1(color: AppColors.tertiaryColor),)
        ],
      ),
    );
  }
}

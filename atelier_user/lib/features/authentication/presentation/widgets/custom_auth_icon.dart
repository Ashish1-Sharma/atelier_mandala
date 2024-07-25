import 'package:atelier_user/constraints/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomAuthIcon extends StatefulWidget {
  final String icon;
  const CustomAuthIcon({super.key, required this.icon});

  @override
  State<CustomAuthIcon> createState() => _CustomAuthIconState();
}

class _CustomAuthIconState extends State<CustomAuthIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width*0.11,vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.black4,
          width: 1
        )
      ),
      child: SvgPicture.asset("assets/icons/${widget.icon}.svg"),
    );
  }
}

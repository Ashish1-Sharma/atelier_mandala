import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/features/store/data/store_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({super.key});

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  final List<Color> colors = [AppColors.successColor, AppColors.errorColor, AppColors.infoColor];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*0.03,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) => createCircle(colors[index],index),
      ),
    );
  }

  Widget createCircle(Color color,int index) {
    return GestureDetector(
      onTap: (){
        StoreController.is_color_selected.setAll(0, List.filled(3, false));
        StoreController.is_color_selected[index] = !StoreController.is_color_selected[index];
      },
      child: Obx(
          ()=> Container(
          margin: EdgeInsets.symmetric(horizontal: Get.height*0.015),
          width: Get.height*0.03,
          height: Get.height*0.03,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Get.height*0.03),
              boxShadow: [
                BoxShadow(
                  color: StoreController.is_color_selected[index] ? color.withOpacity(0.2) : Colors.transparent, // Adjust transparency for subtle shadow
                  spreadRadius: 10.0, // Increase spread radius for wider shadow
                  blurRadius: 2.0,  // Add blur radius for outer blur
                  blurStyle: BlurStyle.inner,
                )
              ]
          ),
        ),
      ),
    );
  }
}

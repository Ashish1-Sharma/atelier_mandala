import 'package:atelier_admin/constraints/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constraints/colors.dart';

class CustomCounter extends StatefulWidget {
  final TextEditingController controller;

  const CustomCounter({super.key, required this.controller});

  @override
  State<CustomCounter> createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> TextFormField(
        textAlign: TextAlign.center,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: Counter.value.toString(),
          hintStyle: AppTextStyles.bodySmall(color: AppColors.brandColor),
          fillColor: AppColors.black6,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black4, width: 1.5),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black4, width: 1.5),
              borderRadius: BorderRadius.circular(5)),
          prefixIcon: IconButton(
            onPressed: (){
              if(Counter.value > 1){
                Counter.value = Counter.value -1;
              }
            },
            icon: Icon(Icons.remove,color: AppColors.brandColor),
          ),
          suffixIcon: IconButton(
            onPressed: (){
              Counter.value = Counter.value +1;
            },
            icon: Icon(Icons.add,color: AppColors.brandColor,),
          ),
        ),
        readOnly: true,
      ),
    );
  }
}

class Counter extends GetxController{
  static RxInt value = 1.obs;
}

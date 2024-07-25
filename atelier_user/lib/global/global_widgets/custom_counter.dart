import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constraints/colors.dart';
import '../../constraints/fonts.dart';

class CustomCounter extends StatefulWidget {
  final TextEditingController controller;

  const CustomCounter({super.key, required this.controller});

  @override
  State<CustomCounter> createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  @override
  Widget build(BuildContext context) {
    // return Obx(
    //   ()=> TextFormField(
    //     textAlign: TextAlign.center,
    //     controller: widget.controller,
    //     decoration: InputDecoration(
    //       hintText: Counter.value.toString(),
    //       hintStyle: AppTextStyles.bodySmall(color: AppColors.brandColor),
    //       fillColor: AppColors.black6,
    //       filled: true,
    //       focusedBorder: OutlineInputBorder(
    //           borderSide: BorderSide(color: AppColors.black4, width: 1.5),
    //           borderRadius: BorderRadius.circular(5)),
    //       enabledBorder: OutlineInputBorder(
    //           borderSide: BorderSide(color: AppColors.black4, width: 1.5),
    //           borderRadius: BorderRadius.circular(5)),
    //       prefixIcon: IconButton(
    //         onPressed: (){
    //           if(Counter.value > 1){
    //             Counter.value = Counter.value -1;
    //           }
    //         },
    //         icon: Icon(Icons.remove,color: AppColors.brandColor),
    //       ),
    //       suffixIcon: IconButton(
    //         onPressed: (){
    //           Counter.value = Counter.value +1;
    //         },
    //         icon: Icon(Icons.add,color: AppColors.brandColor,),
    //       ),
    //     ),
    //     readOnly: true,
    //   ),
    // );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: (){
      if(Counter.value > 1){
                    Counter.value = Counter.value -1;
                  }

          }, icon: const Icon(Icons.remove,color: AppColors.brandColor,weight: 50,),style: ButtonStyle(
          side: WidgetStateProperty.all(const BorderSide(
            color: AppColors.black3
          )),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ))
        ),),
        Obx(
    ()=> Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(Counter.value.value.toString()),
          ),
        ),
        IconButton(onPressed: (){
          Counter.value = Counter.value +1;
        }, icon: const Icon(Icons.add,color: AppColors.brandColor,weight: 50,),style: ButtonStyle(
            side: WidgetStateProperty.all(const BorderSide(
                color: AppColors.black3
            )),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ))
        ),),
      ],
    );
  }
}

class Counter extends GetxController{
  static RxInt value = 1.obs;
}

import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    print("hello");
    return Scaffold(
      body: Center(
        child: Obx(() => Text("${ExampleController.value.value}",style: AppTextStyles.h1(color: AppColors.black1),)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(onPressed: (){
        ExampleController.value.value = ExampleController.value.value +1;
      },child: Icon(Icons.add),),
    );
  }
}

class ExampleController extends GetxController {
  static RxInt value = 0.obs;
}

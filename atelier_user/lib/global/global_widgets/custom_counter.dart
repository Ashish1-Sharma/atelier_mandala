import 'package:atelier_user/constraints/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constraints/colors.dart';

class CustomCounter extends StatefulWidget {
  final TextEditingController controller;
  final int quantity;
  const CustomCounter({super.key, required this.controller, required this.quantity});

  @override
  State<CustomCounter> createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  final Counter _counter = Counter();

  @override
  void initState() {
    super.initState();
    _counter.value.value = int.tryParse(widget.controller.text) ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.black3,
          width: 1
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              if (_counter.value.value > 1) {
                _counter.value.value = _counter.value.value - 1;
                widget.controller.text = _counter.value.value.toString();
              }
            },
            icon: const Icon(
              Icons.remove,
              color: AppColors.tertiaryColor,
              size: 16,
            ),
          ),
          Obx(
                () => Container(
                  width: 10,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(_counter.value.value.toString(),style: AppTextStyles.h2(color: AppColors.black1),),
            ),
          ),
          IconButton(
            onPressed: () {
              if (_counter.value.value < widget.quantity) {
                _counter.value.value = _counter.value.value + 1;
                widget.controller.text = _counter.value.value.toString();
              }
            },
            icon: const Icon(
              Icons.add,
              color: AppColors.tertiaryColor,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class Counter extends GetxController {
  RxInt value = 1.obs;
}

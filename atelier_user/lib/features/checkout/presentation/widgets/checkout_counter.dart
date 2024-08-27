import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../constraints/colors.dart';
import '../../../../constraints/space.dart';
import '../../../../global/global_widgets/custom_counter.dart';

class CheckoutCounter extends StatefulWidget {

  final int quantity;
  final ValueChanged<int> onValueChange;
  const CheckoutCounter({super.key,required this.quantity, required this.onValueChange});

  @override
  State<CheckoutCounter> createState() => _CheckoutCounterState();
}
class _CheckoutCounterState extends State<CheckoutCounter> {
  final Counter _counter = Counter();

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyMedium; // Use theme for text style

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        iconButton(Icons.add, () {
          if (_counter.value.value > 1) {
            _counter.value.value = _counter.value.value - 1;
            widget.onValueChange(_counter.value.value);
          }
        }, context),
        Space.width(0.01),
        Obx(() => Text(
          _counter.value.value.toString(),
          style: textStyle,
        )),
        Space.width(0.01),
        iconButton(Icons.add, () {
          if (_counter.value.value < widget.quantity) {
            _counter.value.value = _counter.value.value + 1;
            widget.onValueChange(_counter.value.value);
          }
        }, context),
      ],
    );
  }

  Widget iconButton(IconData icon, Function()? onPressed, BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return Container(
      height: Get.height * 0.03,
      width: Get.height * 0.03,
      child: IconButton(
        onPressed: onPressed,
        alignment: Alignment.center,
        padding: EdgeInsets.zero, // Remove default padding
        icon:
        Icon(icon, color: AppColors.brandColor, size: textStyle?.fontSize),
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all(
              Size(Get.height * 0.03, Get.height * 0.03)), // Set fixed size
          side: WidgetStateProperty.all(
              const BorderSide(color: AppColors.black3)),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        ),
      ),
    );
  }
}

class Counter extends GetxController {
  RxInt value = 1.obs;
}

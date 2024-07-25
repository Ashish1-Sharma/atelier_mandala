import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
// import 'package:duration_picker/duration_picker.dart';
import 'package:duration_time_picker/duration_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDurationPicker extends StatefulWidget {
  final ValueChanged<Duration> onDurationChanged;
  const CustomDurationPicker({super.key, required this.onDurationChanged});

  @override
  State<CustomDurationPicker> createState() => _CustomDurationPickerState();
}

class _CustomDurationPickerState extends State<CustomDurationPicker> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  // Duration _durationMin = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Select duration",
        fillColor: AppColors.black6,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black4, width: 1.5),
            borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.black4, width: 1.5),
            borderRadius: BorderRadius.circular(5)),
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          color: AppColors.brandColor,
        ),
      ),
      readOnly: true,
      onTap: () async {
         showGeneralDialog(context: context, pageBuilder: (context, animation, secondaryAnimation) {
           DurationController.duration.value = Duration.zero;
           return AlertDialog(
             backgroundColor: AppColors.black6,
             title: Text("Duration required to cook",style: AppTextStyles.bodyBig(color: AppColors.black1),),
             content: Obx(
                   ()=> DurationTimePicker(
                 duration: DurationController.duration.value,
                 backgroundColor: AppColors.black6,
                 baseUnit: BaseUnit.minute,
                 labelStyle: AppTextStyles.bodyBig(color: AppColors.black1),
                 circleColor: Colors.grey.withOpacity(0.5),
                 progressColor: AppColors.brandColor,
                 onChange: (val) {
                   DurationController.duration.value = val;
                 },
               ),
             ),
             actions: [
               TextButton(onPressed: (){
                 widget.onDurationChanged(DurationController.duration.value);
                 Get.back();
               }, child: Text("Ok",style: AppTextStyles.bodyMain18(color: AppColors.black1),))
             ],
           );
         },);
      },
    );
  }
}

class DurationController extends GetxController{
  static Rx duration = Duration.zero.obs;
}

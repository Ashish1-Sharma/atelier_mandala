import 'dart:io';

import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CustomUploadImage extends StatefulWidget {
  const CustomUploadImage({super.key});

  @override
  State<CustomUploadImage> createState() => _CustomUploadImageState();
}

class _CustomUploadImageState extends State<CustomUploadImage> {
  late XFile? pickedImage;
  final _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    GlobalController.path.value = '';
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        height: 400,
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: Get.height*0.06),
        decoration: BoxDecoration(
          color: AppColors.black6,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColors.black4,
            width: 1.5
          )
        ),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
            ()=> Container(
              alignment: Alignment.center,
                child: GlobalController.path.value.isEmpty ? const Icon(Icons.image) : Image.file(File(GlobalController.pickedImage!.path),width: 250,fit: BoxFit.contain,height: 200,),
              ),
            ),
            const SizedBox(height: 10,),
            Container(
              child: GlobalController.path.value.isEmpty ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: Text("Click to upload",style: AppTextStyles.bodyMini1(color: AppColors.black3))),
                  Flexible(child: Text("JPG , PNG or GIF (max, 800x400)",style: AppTextStyles.bodyMini1(color: AppColors.black3),))
                ],
              ) : const SizedBox()
            )
          ],
        )
      ),
    );
  }

  Future<void> pickImage() async {

    GlobalController.pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(GlobalController.pickedImage == null){
      return;
    }
    GlobalController.path.value = GlobalController.pickedImage!.path;
    GlobalController.image = File(GlobalController.pickedImage!.path);
    GlobalController.link.value = GlobalController.image.path.split("/").last;
    print(GlobalController.link.value);
  }

}

import 'dart:io';

import 'package:atelier_admin/constraints/colors.dart';
import 'package:atelier_admin/constraints/fonts.dart';
import 'package:atelier_admin/global_controller.dart';
import 'package:atelier_admin/global_firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CustomUploadImage extends StatefulWidget {
  const CustomUploadImage({super.key});

  @override
  State<CustomUploadImage> createState() => _CustomUploadImageState();
}

class _CustomUploadImageState extends State<CustomUploadImage> {
  late XFile? pickedImage = null;
  final _picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GlobalController.path.value = "";
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        width: double.infinity,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
            ()=> Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: AppColors.black4,
                        width: 1.5
                    )
                ),
                child: GlobalController.path.value.isEmpty ? Icon(Icons.image) : Image.file(File(GlobalController.path.value)),
              ),
            ),
            SizedBox(height: 10,),
            Text("Click to upload",style: AppTextStyles.bodySmall(color: AppColors.black3)),
            Text("JPG , PNG or GIF (max, 800x400)",style: AppTextStyles.bodySmall(color: AppColors.black3),)
          ],
        )
      ),
    );
  }

  Future<void> pickImage() async {

    GlobalController.pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(GlobalController.pickedImage == null){
      print("hello");
      return;
    }
    // print("hellas");
    print(GlobalController.pickedImage);
    GlobalController.path.value = GlobalController.pickedImage!.path;
    print(GlobalController.path.value);
    GlobalController.image = File(GlobalController.pickedImage!.path);
    GlobalController.link.value = GlobalController.image!.path.split("/").last;
    // print(GlobalController.link.value);


  }

}

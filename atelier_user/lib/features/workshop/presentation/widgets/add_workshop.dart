import 'package:atelier_user/constraints/colors.dart';
import 'package:atelier_user/constraints/fonts.dart';
import 'package:atelier_user/features/workshop/data/workshop_controller.dart';
import 'package:atelier_user/features/workshop/presentation/widgets/workshop_payment.dart';
import 'package:atelier_user/global/global_models/workshop_model.dart';
import 'package:atelier_user/global/global_widgets/custom_elevated_button.dart';
import 'package:atelier_user/global/global_widgets/custom_normal_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constraints/space.dart';

class AddWorkshop extends StatefulWidget {
  final WorkshopModel model;
  const AddWorkshop({super.key,required this.model});

  @override
  State<AddWorkshop> createState() => _AddWorkshopState();
}

class _AddWorkshopState extends State<AddWorkshop> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WorkshopController.clearAllAttendees();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black6,
      appBar: AppBar(
        backgroundColor: AppColors.black6,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black1,
            )),
        title: Text("Pickup Tickets"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomElevatedButton(
                      backColor: AppColors.errorColor,
                      txtColor: AppColors.black6,
                      txt: "Remove",
                      onPressed: () {
                       WorkshopController.removeAttendee();
                      },
                    ),
                    CustomElevatedButton(
                      backColor: AppColors.tertiaryColor,
                      txtColor: AppColors.black6,
                      txt: "Add",
                      onPressed: () {
                       WorkshopController.addAttendee();
                      },
                    ),
                  ],
                ),
                Obx(
                      () => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: WorkshopController.newMember.value,
                    itemBuilder: (context, index) {
                      final controller = WorkshopController.attendeeController[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        // Optional: Remove border or keep it depending on your design
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          // If you want to remove the border, you can comment this out
                          border: Border.all(
                            color: AppColors.black3,
                            width: 1,
                          ),
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            backgroundColor: AppColors.black5,
                            collapsedBackgroundColor: AppColors.black5,
                            title: Text("Attendee -${index + 1}",style: AppTextStyles.h3MoreNormal(color: AppColors.black1),),
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name*",style: AppTextStyles.bodyMain14_2(color: AppColors.black1),),
                                    Space.spacer(0.008),
                                    CustomNormalTextField(
                                        controller: controller[0], hint: "Full Name"),
                                    Space.spacer(0.008),
                                    Text("Email*",style: AppTextStyles.bodyMain14_2(color: AppColors.black1),),
                                    Space.spacer(0.008),
                                    CustomNormalTextField(
                                      controller: controller[1],
                                      hint: "Email",
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                    ),
                                    Space.spacer(0.008),
                                    Text("Phone*",style: AppTextStyles.bodyMain14_2(color: AppColors.black1),),
                                    Space.spacer(0.008),
                                    CustomNormalTextField(
                                        controller: controller[2], hint: "Phone"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    backColor: AppColors.tertiaryColor,
                    txtColor: AppColors.black6,
                    txt: "Confirm",
                    onPressed: (){
                      if(formKey.currentState!.validate()){

                      final map = getAttendeeData();
                      Get.to(()=>WorkshopPayment(model: widget.model,attendeeData: map,));
                      }
                    },
                  ),
                ),
                Space.spacer(0.01),
              ],
            ),
          ),
        ),
      )

    );
  }
  Map getAttendeeData(){
    Map<String, Map<String, String>> attendeeData = {};
    for(int i =0;i<WorkshopController.newMember.value;i++){
      final controller = WorkshopController.attendeeController[i];
      attendeeData[i.toString()] = {
        'Name' : controller[0].text,
        'Email' : controller[1].text,
        'Phone' : controller[2].text,
      };
    }
   return attendeeData;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WorkshopController extends GetxController{
  static RxInt newMember = 1.obs;
  static RxList<List<TextEditingController>> attendeeController = [[TextEditingController(),TextEditingController(),TextEditingController()]].obs;
  static RxInt couponAmount = 0.obs;
  static addAttendee(){
    newMember=newMember+1;
    attendeeController.add([TextEditingController(),TextEditingController(),TextEditingController()]);
  }

  static removeAttendee(){
    if(newMember>1){
    newMember=newMember-1;
    attendeeController.removeLast();
    }
  }
  static clearAllAttendees() {
    // Dispose all TextEditingController instances
    for (var controllers in attendeeController) {
      for (var controller in controllers) {
        controller.dispose();
      }
    }
    // Clear the list and reset the member count
    newMember.value = 0;
    attendeeController.clear();

    addAttendee();
  }
  }
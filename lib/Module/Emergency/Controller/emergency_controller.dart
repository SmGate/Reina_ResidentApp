import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/Emergency/model/add_emergency_model.dart';
import 'package:userapp/Module/Emergency/service/add_emergency_service.dart';
import 'package:userapp/Routes/set_routes.dart';
import 'package:userapp/utils/Constants/images_strings.dart';
import 'package:userapp/utils/styles/colors.dart';

import '../../Login/Model/User.dart';

class AddEmergencyController extends GetxController {
  var user = Get.arguments;
  late final User userdata;
  var resident;
  var isLoading = false.obs;
  RxString error = "".obs;
  var addEmergencyModel = AddEmergencyModel();

  EmergencyTypes emergencyGroup = EmergencyTypes.Fire;

  RxList<AllEmergencies> emergencies = <AllEmergencies>[
    AllEmergencies(
      title: 'Fire',
      emergencyTypes: EmergencyTypes.Fire,
      icon: AppImages.fire,
    ),
    AllEmergencies(
      title: 'Short Circuit',
      emergencyTypes: EmergencyTypes.ShortCircuit,
      icon: AppImages.shortCircuit,
    ),
    AllEmergencies(
      title: 'Medical Issue',
      emergencyTypes: EmergencyTypes.MedicalIssue,
      icon: AppImages.medicalIssue,
    ),
    AllEmergencies(
      title: 'Theft / Robbery',
      emergencyTypes: EmergencyTypes.Theft,
      icon: AppImages.robbery,
    ),
    AllEmergencies(
      title: 'Others',
      emergencyTypes: EmergencyTypes.Other,
      icon: AppImages.other,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();

    userdata = this.user[0];
    resident = this.user[1];
  }

  TextEditingController descriptionController = TextEditingController();

  Future addEmergencyApi({
    required int residentid,
    required int societyid,
    required int subadminid,
    required String problem,
    required String description,
  }) async {
    isLoading.value = true;
    error.value = "";

    var res = await AddEmergencyService.addEmergency(
        residentid: residentid,
        societyid: societyid,
        subadminid: subadminid,
        problem: problem,
        description: description);

    isLoading.value = false;

    if (res is AddEmergencyModel) {
      addEmergencyModel = res;
      Get.offAndToNamed(homescreen, arguments: userdata);
      Get.snackbar(
        "Message",
        "Emergency Problem Reported",
        icon: Icon(
          Icons.snapchat,
          color: AppColors.textBlack,
        ),
      );
    } else {
      isLoading.value = false;
      error.value = res.toString();

      Get.snackbar("Error", error.value);
    }
  }
}

enum EmergencyTypes { Fire, ShortCircuit, Theft, MedicalIssue, Other }

class AllEmergencies {
  EmergencyTypes? emergencyTypes;
  String? title;
  String? icon;

  AllEmergencies({this.title, this.emergencyTypes, this.icon});
}

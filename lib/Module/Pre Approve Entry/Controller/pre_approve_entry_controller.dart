import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/Pre%20Approve%20Entry/service/all_pre_approved_entry_service.dart';

import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';
import '../Model/all_pre_approved_entriese_model.dart';

class PreApproveEntryController extends GetxController {
  late final User userdata;
  late final Residents resident;
  var data = Get.arguments;

  ///////////////////////////
  RxString error = "".obs;
  PreapproveEntryModel allPreApprovedEntriese = PreapproveEntryModel();
  /////////////////////////////

  var snapShot;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    userdata = data[0];
    resident = data[1];
  }

  Future<PreapproveEntryModel> getAllPreApprovedEntry(
      {required int userid, required pageKey}) async {
    error.value = "";
    var res = await AllPreApprovedEntryService.allPreApprovedEntry(
        userid: userid, pageKey: pageKey);

    if (res is PreapproveEntryModel) {
      allPreApprovedEntriese = res;
      return allPreApprovedEntriese;
    } else {
      error.value = res.toString();
      Get.snackbar("Error", error.value);
    }

    return allPreApprovedEntriese;
  }
}

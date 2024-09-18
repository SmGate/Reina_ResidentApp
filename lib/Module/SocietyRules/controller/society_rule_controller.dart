import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/Module/SocietyRules/model/society_rules_model.dart';
import 'package:userapp/Module/SocietyRules/service/society_rules_service.dart';

import '../../Login/Model/User.dart';

class SocietyRuleController extends GetxController {
  var user = Get.arguments;
  late final User userdata;
  final formKey = new GlobalKey<FormState>();
  var errorGettingSocietyRules = "".obs;
  var societyRulesModel = SocietyRuleModel();

  TextEditingController ruleTitleController = TextEditingController();
  TextEditingController ruleDescriptionController = TextEditingController();

  @override
  void onInit() {
    userdata = user;
    super.onInit();
  }

  Future<SocietyRuleModel> getAllRules({
    String? societyId,
  }) async {
    errorGettingSocietyRules.value = "";
    var res = await SocietyRulesService.getSocietyRule(societyId: societyId);

    if (res is SocietyRuleModel) {
      societyRulesModel = res;
      return societyRulesModel;
    } else {
      errorGettingSocietyRules.value = res.toString();
      Get.snackbar("Error", errorGettingSocietyRules.value);
    }

    return societyRulesModel;
  }
}

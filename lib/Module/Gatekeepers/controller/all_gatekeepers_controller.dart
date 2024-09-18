import 'package:get/get.dart';

import '../../Login/Model/User.dart';
import '../model/get_all_gatekeepers_model.dart';
import '../services/get_all_gatekeepers_service.dart';

class AllGatekeeperController extends GetxController {
  var data = Get.arguments;
  late final User userdata;

  RxBool loading = false.obs;
  RxString error = "".obs;
  Uri? uri;
  var getAllGateKeepersModel = GetAllGatekeepersModel();

  @override
  void onInit() {
    this.userdata = data[0];
    super.onInit();
  }

  Future<GetAllGatekeepersModel> getGateKeepers({int? subadminId}) async {
    error.value = "";
    loading.value = true;

    var res = await GetAllGatekeepersService.getAllGatekeepers(
        subadminId: subadminId);
    loading.value = false;

    if (res is GetAllGatekeepersModel) {
      getAllGateKeepersModel = res;
      // Get.snackbar("Message", getAllGateKeepersModel.message.toString());
      return getAllGateKeepersModel;
    } else {
      loading.value = false;
      error.value = res.toString();
      Get.snackbar("Error", error.value);
    }

    return getAllGateKeepersModel;
  }
}

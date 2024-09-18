import 'package:get/get.dart';
import 'package:userapp/Module/Login/Model/User.dart';
import 'package:userapp/Module/visitor_details/model/visitor_details_model.dart';
import 'package:userapp/Module/visitor_details/service/visitor_service.dart';

class VisitorDetailsController extends GetxController {
  var visitorDetailsModel = GetAllVisitors();
  RxString error = "".obs;

  var data = Get.arguments;
  late final User user;

  onInit() {
    super.onInit();
    this.user = data;
  }

  Future<GetAllVisitors> getAllVisitors({int? subadminId}) async {
    error.value = "";
    var res =
        await VisitorDetailService.getVisitorDetails(subadminId: subadminId);

    if (res is GetAllVisitors) {
      visitorDetailsModel = res;
      return visitorDetailsModel;
    } else {
      error.value = res.toString();
    }

    return visitorDetailsModel;
  }
}

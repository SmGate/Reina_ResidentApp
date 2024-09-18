import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userapp/Module/Events/Model/society_events_model.dart';
import 'package:userapp/Module/Events/service/society_events_service.dart';
import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';

class EventScreenController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();
  var user = Get.arguments;
  late final User userdata;
  late final Residents resident;
  var societyEventsModel = SocietyEventsModel();
  var error = "";

  @override
  void onInit() {
    super.onInit();

    userdata = user[0];
    resident = user[1];
  }

  Future<SocietyEventsModel> viewEventsApi({required int userid}) async {
    error = "";
    var res = await SocietyEventservice.societyEvents(userid: userid);
    if (res is SocietyEventsModel) {
      societyEventsModel = res;
      return societyEventsModel;
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
    }

    return societyEventsModel;
  }
}

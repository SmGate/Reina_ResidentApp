import 'package:get/get.dart';
import 'package:userapp/Module/NoticeBoard/Model/notice_board_model.dart' as n;
import 'package:userapp/Module/NoticeBoard/service/notice_board_service.dart';

import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';

class NoticeBoardController extends GetxController {
  var data = Get.arguments;

  late final User userdata;
  late final Residents resident;
  var error = "";
  var noticeBoardModel = n.NoticeBoardModel();
  @override
  void onInit() {
    super.onInit();
    userdata = data[0];
    resident = data[1];
  }

  Future<n.NoticeBoardModel> viewNoticeBoardApi(int subadminid) async {
    error = "";
    var res = await NoticeBoardService.allNoticeBoard(subadminid: subadminid);
    if (res is n.NoticeBoardModel) {
      noticeBoardModel = res;
      return noticeBoardModel;
    } else {
      error = res.toString();
      Get.snackbar("Error", error);
    }

    return noticeBoardModel;
  }
}

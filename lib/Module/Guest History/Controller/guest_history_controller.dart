import 'dart:ui';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Module/Guest%20History/Model/pre_approved_history_model.dart';
import 'package:userapp/Module/Guest%20History/service/pre_approved_history_service.dart';
import '../../Login/Model/User.dart';
import '../../Pre Approve Entry/Model/PreApproveEntry.dart';

class GuestHistoryController extends GetxController {
  static const pageSize = 6;
  final PagingController pagingController = PagingController(firstPageKey: 1);
  List<PreApproveEntry> preApproveEntryLi = [];
  List<PreApproveEntry> dataList = [];

  var preApprovedHistoryModel = PreApprovedHistoryModel();
  var error = "";

  List<Color> pinkcard = [
    HexColor('#FF6188'),
    HexColor('#FFB199'),
  ];

  List<Color> bluecard = [
    HexColor('#4481EB'),
    HexColor('#04BEFE'),
  ];

  List<Color> greencard = [
    HexColor('#D6FF94'),
    HexColor('#3DC24B'),
  ];

  var user = Get.arguments;
  late final User userdata;
  var snapShot;

  @override
  void onInit() {
    super.onInit();

    userdata = user;
    print(userdata);
  }

  Future<PreApprovedHistoryModel> preApprovedHistory({int? userId}) async {
    error = "";
    var res = await PreApprovedHistoryService.getPreApprovedHistory(
        userid: userId ?? 0);

    if (res is PreApprovedHistoryModel) {
      preApprovedHistoryModel = res;
      return preApprovedHistoryModel;
    } else {
      error = res.toString();
      Get.snackbar("Message", error);
    }
    return preApprovedHistoryModel;
  }
}

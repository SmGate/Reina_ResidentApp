import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Module/Discussion%20Form/Model/all_resident_model.dart';
import 'package:userapp/Module/Discussion%20Form/Model/block_resident_model.dart';
import 'package:userapp/Module/Discussion%20Form/service/all_resident_service.dart';
import 'package:userapp/Routes/set_routes.dart';

import '../../Login/Model/User.dart';

class ViewResidentController extends GetxController {
  var user = Get.arguments;
  late final User userdata;
  RxString searchValue = "".obs;
  var pageSize = 10;
  RxString error = "".obs;
  List<Datum> residentRecordList = [];
  var allResidentModel = AllResidentModel();

  final PagingController<int, Datum> pagingController =
      PagingController(firstPageKey: 1);

  /////////  block resident
  var errorBlockingUser = "";
  var blockUserModel = BlockResidentsModel();
  @override
  void onInit() {
    super.onInit();
    print("init");
    userdata = this.user;

    pagingController.addPageRequestListener((pageKey) {
      viewResidentsApi(
          pageKey: pageKey,
          limit: pageSize,
          subAdminId: userdata.subadminid.toString());
    });
  }

  viewResidentsApi({
    String? subAdminId,
    int? pageKey,
    int? limit,
  }) async {
    print("this method call");
    error.value = "";

    var res = await AllResidentSerVice.getAllResidentList(
      subadminId: subAdminId,
      pageKey: pageKey,
      limit: limit,
    );

    if (res is AllResidentModel) {
      allResidentModel = res;
      residentRecordList = allResidentModel.data?.data ?? [];

      final isLastPage = residentRecordList.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(residentRecordList);
      } else {
        final nextPageKey = pageKey! + 1;
        pagingController.appendPage(residentRecordList, nextPageKey);
      }
    } else {
      error.value = res.toString();
      Get.snackbar("Error", error.value);
    }
  }

  blockUser({
    String? residentId,
    int index = 0,
  }) async {
    errorBlockingUser = "";

    var res = await AllResidentSerVice.blockResident(
      residentId: residentId,
    );

    if (res is BlockResidentsModel) {
      blockUserModel = res;

      Get.snackbar("Message", blockUserModel.message ?? "");
      Get.offNamed(homescreen, arguments: userdata);
    } else {
      errorBlockingUser = res.toString();
      Get.snackbar("Error", errorBlockingUser);
    }
  }
}

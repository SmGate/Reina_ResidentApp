import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:userapp/Module/ReportsHistory/model/report_history_model.dart';
import 'package:userapp/Module/ReportsHistory/service/report_history_service.dart';
import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart';

class ReportHistoryController extends GetxController {
  static const pageSize = 6;
  final PagingController pagingController = PagingController(firstPageKey: 1);
  List<Datum>? reportsLi = [];
  List<Datum>? dataList = [];
  var arguments = Get.arguments;
  late final User user;
  late final Residents resident;
  RxString error = "".obs;
  var reportHistoryMOdel = ReportHistoryModel();

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    user = arguments[0];
    resident = arguments[1];
  }

  Future<List<Datum>?> ViewAdminReportsHistoryApi(
      {required int subAdminId,
      required int userId,
      required String token,
      required int pageKey}) async {
    error.value = "";
    var res = await ReportHistoryService.reportHistory(
        userId: userId, subAdminId: subAdminId, pageKey: pageKey);

    if (res is ReportHistoryModel && res.success == true) {
      reportHistoryMOdel = res;
      reportsLi = reportHistoryMOdel.data?.data;
      return reportsLi;
    } else {
      error.value = res.toString();
      Get.snackbar("Message", error.value);
    }
    return reportsLi;
  }

  Future<void> _fetchPage(int pageKey) async {
    dataList = await ViewAdminReportsHistoryApi(
        userId: user.userId!,
        token: user.bearerToken!,
        pageKey: pageKey,
        subAdminId: resident.subadminid!);

    final isLastPage = dataList!.length < pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(dataList!);
    } else {
      final nextPageKey = pageKey + 1;
      pagingController.appendPage(dataList!, nextPageKey);
    }
  }
}

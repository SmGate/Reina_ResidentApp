import 'package:userapp/Module/ReportsHistory/model/report_history_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class ReportHistoryService {
  static Future<dynamic> reportHistory(
      {required int userId,
      required int subAdminId,
      required int pageKey}) async {
    try {
      var url = Api.historyReports +
          "/" +
          subAdminId.toString() +
          "/" +
          userId.toString() +
          "?page=" +
          pageKey.toString();

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return reportHistoryModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

import 'package:userapp/Module/Guest%20History/Model/pre_approved_history_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class PreApprovedHistoryService {
  static Future<dynamic> getPreApprovedHistory({required int userid}) async {
    try {
      var url = Api.preApproveEntryHistories + "/" + userid.toString();

      var res = await BaseClientClass.get(url, "");
      if (res is http.Response) {
        return preApprovedHistoryModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

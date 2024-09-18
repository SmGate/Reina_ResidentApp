import 'package:userapp/Module/Pre%20Approve%20Entry/Model/all_pre_approved_entriese_model.dart';
import 'package:userapp/utils/Constants/base_client.dart';

import 'package:http/http.dart' as http;

import '../../../utils/Constants/api_routes.dart';

class AllPreApprovedEntryService {
  static Future<dynamic> allPreApprovedEntry(
      {required int userid, required pageKey}) async {
    try {
      var url = Api.viewPreApproveEntryReports +
          "/" +
          userid.toString() +
          "?page=" +
          pageKey.toString();

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return preapproveEntryModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

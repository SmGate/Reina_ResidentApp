import 'package:userapp/Module/visitor_details/model/visitor_details_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class VisitorDetailService {
  static Future<dynamic> getVisitorDetails({int? subadminId}) async {
    try {
      var url = "${Api.getVisitorDetails}/$subadminId";
      var res = await BaseClientClass.get(url, "");
      if (res is http.Response) {
        return getAllVisitorsFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

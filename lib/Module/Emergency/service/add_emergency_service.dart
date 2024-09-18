import 'package:userapp/Module/Emergency/model/add_emergency_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class AddEmergencyService {
  static Future<dynamic> addEmergency({
    required int residentid,
    required int societyid,
    required int subadminid,
    required String problem,
    required String description,
  }) async {
    try {
      var url = Api.addEmergency;
      Map data = {
        "residentid": residentid.toString(),
        "societyid": societyid.toString(),
        "subadminid": subadminid.toString(),
        "problem": problem,
        "description": description,
        "status": "0",
      };

      var res = await BaseClientClass.post(url, data);
      if (res is http.Response) {
        return addEmergencyModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

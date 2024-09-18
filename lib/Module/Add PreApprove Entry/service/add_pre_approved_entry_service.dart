import 'package:userapp/Module/Add%20PreApprove%20Entry/Model/add_pre_approved_entry_model.dart';
import 'package:userapp/Module/Add%20PreApprove%20Entry/Model/search_preapproved-entry_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class AddPreApprovedEntryService {
  static Future<dynamic> addPreApprovedEntry({
    required int gatekeeperid,
    required int userid,
    required String visitortype,
    required String name,
    required String description,
    required String cnic,
    required String mobileno,
    required String vechileno,
    required String arrivaldate,
    required String arrivaltime,
    required DateTime toDate,
    String? image,
  }) async {
    try {
      Map data = {
        "gatekeeperid": gatekeeperid,
        "userid": userid,
        "visitortype": visitortype,
        "name": name,
        "description": description,
        "cnic": cnic,
        "mobileno": mobileno,
        "vechileno": vechileno,
        "arrivaldate": arrivaldate,
        "arrivaltime": arrivaltime,
        "status": 1,
        "statusdescription": "Approved",
        "to_date": toDate.toString(),
        "image": image,
      };
      var url = Api.addPreApproveEntry;

      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return addPreapproveEntryModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> searchPreApprovedEntry({required int resident}) async {
    try {
      var url = "${Api.getAllPreApprovedEntry}/$resident";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return searchPreApprovedEntryFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

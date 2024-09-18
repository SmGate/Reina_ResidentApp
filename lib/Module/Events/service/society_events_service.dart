import 'package:userapp/Module/Events/Model/society_events_model.dart';
import 'package:userapp/utils/Constants/base_client.dart';

import 'package:http/http.dart' as http;

import '../../../utils/Constants/api_routes.dart';

class SocietyEventservice {
  static Future<dynamic> societyEvents({required int userid}) async {
    try {
      var url = Api.viewEvents + "/" + userid.toString();

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return societyEventsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

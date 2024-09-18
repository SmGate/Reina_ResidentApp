import 'package:userapp/utils/Constants/base_client.dart';

import 'package:http/http.dart' as http;

import '../../../utils/Constants/api_routes.dart';
import '../model/get_all_gatekeepers_model.dart';

class GetAllGatekeepersService {
  static Future<dynamic> getAllGatekeepers({int? subadminId}) async {
    try {
      var url = "${Api.getAllGateKeeper}/${subadminId}";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return getAllGatekeepersModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

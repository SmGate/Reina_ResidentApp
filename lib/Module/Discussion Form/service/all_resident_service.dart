import 'package:http/http.dart' as http;
import 'package:userapp/Module/Discussion%20Form/Model/all_resident_model.dart';
import 'package:userapp/Module/Discussion%20Form/Model/block_resident_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';

class AllResidentSerVice {
  static Future<dynamic> getAllResidentList(
      {String? subadminId, int? pageKey, int? limit}) async {
    try {
      var url = "${Api.viewResidents}/$subadminId?&page=$pageKey&length=$limit";
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return allResidentModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> blockResident({
    String? residentId,
  }) async {
    try {
      var url = "${Api.blockResident}/$residentId";
      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return blockResidentsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

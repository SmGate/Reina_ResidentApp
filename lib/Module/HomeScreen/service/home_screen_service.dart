import 'package:http/http.dart' as http;
import 'package:userapp/Module/HomeScreen/Model/app_permissions_model.dart';
import 'package:userapp/Module/HomeScreen/Model/society_support_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';

class HomeScreenService {
  static Future<dynamic> getAllPermissions({
    String? societyId,
  }) async {
    try {
      var url = "${Api.getAllAppPermission}/$societyId";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return appPermissionsModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getSocietySupport({int? subadminId}) async {
    try {
      var url = "${Api.societySupport}/${subadminId}";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return societySupportModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

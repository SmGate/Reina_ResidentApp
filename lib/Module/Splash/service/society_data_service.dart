import 'package:userapp/Module/Splash/model/society_data_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class ServiceDataService {
  static Future<dynamic> gatSocietyDetailsForSplash({int? societyID}) async {
    try {
      var url = "${Api.getSocietyDataForSplash}/${societyID.toString()}";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return societyDataModelFromJson(res.body);
      } else {
        return res.toString();
      }
    } catch (e) {
      return e;
    }
  }
}

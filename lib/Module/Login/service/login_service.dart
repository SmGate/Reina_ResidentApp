import 'package:userapp/Module/Login/Model/fcm_refresh_model.dart';
import 'package:userapp/Module/Login/Model/user_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<dynamic> loginUser({String? mobileNo, String? password}) async {
    try {
      var url = Api.login;
      Map data = {
        'user': mobileNo,
        'password': password,
      };

      var res = await BaseClientClass.post(url, data);
      if (res is http.Response) {
        return userModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  //// fcm refresh
  static Future<dynamic> fcmRefresh(
      {int? id, String? fcmtoken, String? bearertoken}) async {
    try {
      var url = Api.fcmTokenRefresh;
      Map data = {
        'id': id,
        'fcmtoken': fcmtoken,
      };

      var res = await BaseClientClass.post(url, data);
      if (res is http.Response) {
        return fcmRefreshModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

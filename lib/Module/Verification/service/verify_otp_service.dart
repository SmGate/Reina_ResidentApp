import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

import '../model/verify_otp.dart';

class VerifyOtp {
  static Future<dynamic> verifyOtp({String? otp, int? id}) async {
    try {
      Map data = {
        "verification_code": otp,
        "id": id,
      };
      var url = Api.varifyPhone;

      var res = await BaseClientClass.post(url, data);
      if (res is http.Response) {
        return varifyOtpModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

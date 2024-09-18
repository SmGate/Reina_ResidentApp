import 'dart:convert';
import 'dart:io';

import 'package:userapp/Module/Update%20Profile/model/update_phone_model.dart';
import 'package:userapp/Module/Update%20Profile/model/update_user_profile_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:userapp/utils/Constants/base_client.dart';

class UpdateUserProfileService {
  static Future<dynamic> updateUserProfile(
      {String? fname,
      String? lastName,
      int? residentId,
      File? image,
      required String bearerToken}) async {
    try {
      var url = Uri.parse(Api.updateUser);
      Map<String, String> headers = {"Authorization": "Bearer $bearerToken"};

      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);

      // Add the image if it exists
      if (image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', image.path));
      }

      // Add other fields
      request.fields['firstname'] = fname ?? '';
      request.fields['lastname'] = lastName ?? '';
      request.fields['residentid'] = residentId?.toString() ?? '';

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return updateUserProfileModelFromJson(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> updatePhone({int? userId, String? phone}) async {
    try {
      Map data = {"mobileno": phone, "id": userId};
      var url = Api.updatephone;
      var res = await BaseClientClass.post(url, data);
      if (res is http.Response) {
        return updatePhoneModelFromJson(res.body);
      }
    } catch (e) {
      return e;
    }
  }
}

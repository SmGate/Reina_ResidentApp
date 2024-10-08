import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';

import '../../../utils/Constants/constants.dart';
import '../../Login/Model/User.dart';
import '../Model/ChatNeighbours.dart';
import '../Model/ChatRoomModel.dart';

class ChatAvailbilityController extends GetxController {
  var data = Get.arguments;
  late final User userdata;
  var resident;

  late Future<ChatRoomModel> futureChatRoomData;

  String? visibility;
  RxBool chatAvailibilityStatus = false.obs;

  @override
  void onInit() {
    super.onInit();

    userdata = data[0];
    resident = data[1];
    checkVisibility();
  }

  checkVisibility() async {
    visibility = await checkChatVisibilityApi(
        token: userdata.bearerToken!, residentId: userdata.userId);
  }

  /////   VIEW ALL COMUNITY MEMBERS
  Future<ChatNeighbours> viewChatNeighbours({
    required int subadminid,
  }) async {
    var url = Api.chatNeighbours + "/" + subadminid.toString();
    final response = await BaseClientClass.get(url, "");
    print(response.body);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ChatNeighbours.fromJson(data);
    }

    return ChatNeighbours.fromJson(data);
  }

  //////////////////////////////

  Future<ChatRoomModel> createChatRoomApi({
    required String token,
    required int userid,
    required int chatUserId,
  }) async {
    final response = await Http.post(
      Uri.parse(Api.createChatRoom),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "sender": userid,
        "receiver": chatUserId,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return ChatRoomModel.fromJson(data);
    } else {
      return ChatRoomModel.fromJson(data);
    }
  }

  Future<String?> updateChatVisibilityApi(
      {required String token, required residentId, required visibility}) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    var request =
        Http.MultipartRequest('POST', Uri.parse(Api.updateChatVisibility));
    request.headers.addAll(headers);

    request.fields['residentid'] = residentId.toString();

    request.fields['visibility'] = visibility.toString();

    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    try {
      if (response.statusCode == 200) {
        Get.back();
      } else if (response.statusCode == 403) {
        var data = jsonDecode(response.body.toString());

        myToast(msg: "Error: ${data}", isNegative: true);
      } else if (response.statusCode == 500) {
        myToast(msg: "Server Error", isNegative: true);
      } else {
        myToast(msg: "Operation Failed", isNegative: true);
      }
    } on SocketException catch (e) {
      myToast(
          msg: "Something went wrong ${e.message.toString()}",
          isNegative: true);
    } catch (e) {
      myToast(msg: "Something went wrong ${e.toString()}", isNegative: true);
    }
    return null;
  }

  Future<String?> checkChatVisibilityApi({
    required String token,
    required residentId,
  }) async {
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    var request =
        Http.MultipartRequest('POST', Uri.parse(Api.checkChatVisibility));
    request.headers.addAll(headers);

    request.fields['residentid'] = residentId.toString();

    var responsed = await request.send();
    var response = await Http.Response.fromStream(responsed);

    try {
      if (response.statusCode == 200) {
        var data = await jsonDecode(response.body);
        visibility = data["data"];

        if (visibility == 'none') {
          chatAvailibilityStatus.value = false;
        } else {
          chatAvailibilityStatus.value = true;
        }
      } else if (response.statusCode == 403) {
        var data = jsonDecode(response.body.toString());

        myToast(msg: "Error: ${data}", isNegative: true);
      } else if (response.statusCode == 500) {
        myToast(msg: "Server Error", isNegative: true);
      } else {
        myToast(msg: "Operation Failed", isNegative: true);
      }
    } on SocketException catch (e) {
      myToast(
          msg: "Something went wrong ${e.message.toString()}",
          isNegative: true);
    } catch (e) {
      myToast(msg: "Something went wrong ${e.toString()}", isNegative: true);
    }
    return null;
  }
}

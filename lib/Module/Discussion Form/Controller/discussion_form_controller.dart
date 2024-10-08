import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:intl/intl.dart';
import 'package:userapp/Module/HomeScreen/Model/DiscussionRoomModel.dart' as D;
import 'package:userapp/Module/HomeScreen/Model/DiscussionRoomModel.dart';

import '../../../utils/Constants/api_routes.dart';
import '../../HomeScreen/Model/residents.dart';
import '../../Login/Model/User.dart' as U;
import '../Model/DiscussionChatModel.dart';

class DiscussionFormController extends GetxController {
  late final U.User user;
  late final Residents resident;
  D.DiscussionRoomModel discussionRoomModel = D.DiscussionRoomModel();
  var data = Get.arguments;
  List<DiscussionChatModel> myList = [];
  final TextEditingController msg = TextEditingController();

  StreamController<List<DiscussionChatModel>> discussionChatStreamController =
      StreamController<List<DiscussionChatModel>>.broadcast();

  @override
  void onInit() async {
    super.onInit();
    ;

    user = data[0];
    resident = data[1];
    // discussionRoomModel = data[2];

    discussionRoomModel = await createChatRoomApi(
        token: user.bearerToken!, subadminid: resident.subadminid!);

    // _initiatePusherSocketForMessaging();
    // allDiscussionChatsApi(token: user!.bearerToken!,discussionroomid:discussionRoomModel?.data?.first.id );
  }

  String getFormattedDate() {
    var now = DateTime.now();
    var twelveHour = DateFormat('h:mm a');
    return twelveHour.format(now);
  }

  Future discussionchatsApi({
    required String token,
    required int residentid,
    required int? discussionroomid,
    required String message,
  }) async {
    print(residentid);

    msg.text = '';

    final response = await Http.post(
      Uri.parse(Api.discussionChats),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "discussionroomid": discussionroomid,
        "message": message,
        "residentid": residentid,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      print(response.statusCode);
    }
  }

  Future<DiscussionRoomModel> createChatRoomApi({
    required String token,
    required int subadminid,
  }) async {
    final response = await Http.post(
      Uri.parse(Api.createDiscussionRoom),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "subadminid": subadminid,
      }),
    );
    print(response.body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      return DiscussionRoomModel.fromJson(data);
    } else {
      return DiscussionRoomModel.fromJson(data);
    }
  }
}

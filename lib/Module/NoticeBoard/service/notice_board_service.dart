import 'package:userapp/Module/NoticeBoard/Model/notice_board_model.dart';
import 'package:userapp/utils/Constants/base_client.dart';

import 'package:http/http.dart' as http;

import '../../../utils/Constants/api_routes.dart';

class NoticeBoardService {
  static Future<dynamic> allNoticeBoard({int? subadminid}) async {
    try {
      var url = Api.viewAllNotices + "/" + subadminid.toString();

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return noticeBoardModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

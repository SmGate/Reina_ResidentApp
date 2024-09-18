import 'package:http/http.dart' as http;
import 'package:userapp/Module/voting/model/get_all_poll_model.dart';
import 'package:userapp/Module/voting/model/resident_voting_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';

class GeneratePollService {
  static Future<dynamic> getAllPoll({
    String? societyId,
    String? residentId,
  }) async {
    try {
      var url = "${Api.getAllPoll}/$societyId/$residentId";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return getAllPollModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> residentVoting({
    String? pollId,
    String? pollOptionId,
    String? residentId,
    String? reason,
  }) async {
    try {
      Map data = {
        "poll_id": pollId,
        "option_id": pollOptionId,
        "resident_id": residentId,
        "reason": reason,
      };
      var url = "${Api.residentVote}";

      var res = await BaseClientClass.post(url, data);

      if (res is http.Response) {
        return residentVotingModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

import 'package:http/http.dart' as http;
import 'package:userapp/Module/SocietyRules/model/society_rules_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';

class SocietyRulesService {
  static Future<dynamic> getSocietyRule({
    String? societyId,
  }) async {
    try {
      var url = "${Api.getAllSocietyRule}/$societyId";

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return societyRuleModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

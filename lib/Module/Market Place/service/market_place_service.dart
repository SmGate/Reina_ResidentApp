import 'package:userapp/Module/Market%20Place/Model/all_market_place_product_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class MarketPlaceService {
  static Future<dynamic> viewAllProducts(
      {required int societyid, required String category}) async {
    try {
      var url = Api.viewProducts + "/" + societyid.toString() + "/" + category;

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return allMarketPlaceProductModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> viewSellProductsResidnet({
    required int residentid,
  }) async {
    try {
      var url = Api.viewSellProductsResidnet + "/" + residentid.toString();

      var res = await BaseClientClass.get(url, "");

      if (res is http.Response) {
        return allMarketPlaceProductModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

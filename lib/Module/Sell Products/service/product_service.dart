import 'package:userapp/Module/Sell%20Products/models/add_product_detail_model.dart';
import 'package:userapp/utils/Constants/api_routes.dart';
import 'package:userapp/utils/Constants/base_client.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static Future<dynamic> addProductDetaild({
    required List<String> images,
    required String token,
    required int residentid,
    required int societyid,
    required int subadminid,
    required String productname,
    required String productprice,
    required String description,
    String? contact,
    String? category,
    String? condition,
  }) async {
    try {
      var url = Api.addProduct;
      Map data = {
        "productname": productname,
        "description": description,
        "productprice": productprice,
        "subadminid": subadminid,
        "societyid": societyid,
        "residentid": residentid,
        "contact": contact,
        "category": category,
        "condition": condition,
        "images": images,
      };

      var res = await BaseClientClass.post(url, data);
      if (res is http.Response) {
        return addProductDetailModelFromJson(res.body);
      } else {
        return res;
      }
    } catch (e) {
      return e;
    }
  }
}

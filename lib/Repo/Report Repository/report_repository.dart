import '../../utils/Constants/api_routes.dart';
import '../../Services/Network Services/network_services.dart';

class ReportRepository {
  final networkServices = NetworkServices();

  Future<dynamic> adminReportsApi(
      {required int userid,
      required String token,
      required int pageKey}) async {
    final response = await networkServices.getReq(
        Api.adminReports +
            "/" +
            userid.toString() +
            "?page=" +
            pageKey.toString(),
        bearerToken: token);

    return response;
  }

  Future<dynamic> ProblemSolvedButtonApi({
    required String token,
    required data,
  }) async {
    final response = networkServices.postFormReq(Api.updateReportStatus, data,
        bearerToken: token);
    print(response);

    return response;
  }
}

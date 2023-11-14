import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:get/get.dart';

String _getRequestUrl(String apiEndPoint) => Api.PUBLIC_URL + apiEndPoint;

class NetworkClient extends GetConnect {

  Future<Response> getRequest(String apiEndPoint) async {
    return await get(_getRequestUrl(apiEndPoint), headers: {
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 15));
  }

  Future<Response> postRequest(String apiEndPoint, dynamic body) async {
    Response response = await post(_getRequestUrl(apiEndPoint), body, headers: {
      "Accept": "application/json; charset=UTF-8",
      "Content-Type": "application/json",
    }).timeout(const Duration(seconds: 15));
    return response;
  }
}

import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

String _getRequestUrl(String apiEndPoint) => Api.BASE_URL + apiEndPoint;

class NetworkClient extends GetConnect {
  Future<Response> getRequest(String apiEndPoint) async {
    return await get(_getRequestUrl(apiEndPoint), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": GetStorage().read(AppString.ACCESS_TOKEN) != null
          ? "Bearer ${GetStorage().read(AppString.ACCESS_TOKEN)}"
          : ""
    }).timeout(const Duration(seconds: 15));
  }

  Future<http.Response> getReq(String apiEndPoint) async {
    return await http.get(Uri.parse(_getRequestUrl(apiEndPoint)), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": GetStorage().read(AppString.ACCESS_TOKEN) != null
          ? "Bearer ${GetStorage().read(AppString.ACCESS_TOKEN)}"
          : ""
    }).timeout(const Duration(seconds: 15));
  }

  Future<Response> postRequest(String apiEndPoint, dynamic body) async {
    Response response = await post(_getRequestUrl(apiEndPoint), body, headers: {
      "Accept": "application/json; charset=UTF-8",
      "Authorization": GetStorage().read(AppString.ACCESS_TOKEN) != null
          ? "Bearer ${GetStorage().read(AppString.ACCESS_TOKEN)}"
          : ""
    }).timeout(const Duration(seconds: 15));

    return response;
  }

  Future<Response> getQueryRequest({required String apiEndPoint, query}) async {
    return await get(_getRequestUrl(apiEndPoint), query: query, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": GetStorage().read(AppString.ACCESS_TOKEN) != null
          ? "Bearer ${GetStorage().read(AppString.ACCESS_TOKEN)}"
          : ""
    }).timeout(const Duration(seconds: 15));
  }

  Future<Response> deletedRequest(String apiEndPoint) async {
    Response response = await delete(_getRequestUrl(apiEndPoint), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json; charset=UTF-8",
      "Authorization": GetStorage().read(AppString.ACCESS_TOKEN) != null
          ? "Bearer ${GetStorage().read(AppString.ACCESS_TOKEN)}"
          : ""
    }).timeout(const Duration(seconds: 15));
    return response;
  }

  Future<Response> patchRequest(String apiEndPoint, dynamic body) async {
    Response response =
        await patch(_getRequestUrl(apiEndPoint), body, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json; charset=UTF-8",
      "Authorization": GetStorage().read(AppString.ACCESS_TOKEN) != null
          ? "Bearer ${GetStorage().read(AppString.ACCESS_TOKEN)}"
          : ""
    }).timeout(const Duration(seconds: 15));

    return response;
  }
}

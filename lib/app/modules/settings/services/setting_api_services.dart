import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import '../../../../utils/api_endpoints.dart';

class SettingApiServices {

  final ApiService _apiService;
  SettingApiServices(this._apiService);


  Future<Map<String, dynamic>?> getSettingApi() async {
    QueryResult<Object?> response = await _apiService.gqlCall(queryString: getOrgSettingQuery);
    print("getSettingApi_data_so:: $response");

    return response.data;
  }


}

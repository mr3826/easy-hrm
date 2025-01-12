import 'package:graphql/src/core/query_result.dart';
import 'package:payrun_mobile/app/global/services/api_service.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';

class DashBoardApiService {
  ApiService apiService;
  DashBoardApiService(this.apiService);

  Future<QueryResult<Object?>> getEmployeeOverView() async {
    return await apiService.query(query: getEmployeeOverviewQuery);
  }
}

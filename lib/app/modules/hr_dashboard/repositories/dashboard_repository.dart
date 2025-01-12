import 'package:graphql/src/core/query_result.dart';
import '../models/employee_overview.dart';
import '../services/dashboard_api_services.dart';



abstract class DasBoardRepository {
  Future<EmployeeOverview?> getEmployeeOverview();
}



class DashBoardImpl implements DasBoardRepository {
  DashBoardApiService dashBoardApiService;
  DashBoardImpl(this.dashBoardApiService);

  @override
  getEmployeeOverview() async {
    QueryResult<Object?> response = await dashBoardApiService.getEmployeeOverView();
    if (response.data != null) {
      return EmployeeOverview.fromJson(response.data!);
    }
    return null;
  }
}

import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/repositories/dashboard_repository.dart';
import '../../../global/services/api_service.dart';
import '../controllers/hr_deshboard_controller.dart';
import '../services/dashboard_api_services.dart';

class DashboardBindings extends Bindings{
  @override
  void dependencies() {
    ApiService apiService = Get.find<ApiService>();
    DashBoardApiService dashBoardApiService = DashBoardApiService(apiService);
    DasBoardDataSource dasBoardDataSource = DasBoardDataSourceImpl(dashBoardApiService);
    Get.put(HrDashBoardController(dasBoardDataSource));
  }
}

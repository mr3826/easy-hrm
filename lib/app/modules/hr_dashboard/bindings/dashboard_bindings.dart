import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/repositories/dashboard_repository.dart';
import '../../../global/services/api_service.dart';
import '../controllers/candidates_details_controller.dart';
import '../controllers/hr_deshboard_controller.dart';
import '../services/dashboard_api_services.dart';

class DashboardBindings extends Bindings{
  @override
  void dependencies() {


    DashBoardApiService dashBoardApiService = Get.put(DashBoardApiService(Get.find<ApiService>()));

    DashBoardDataSource dasBoardDataSource = Get.put(DasBoardDataSourceImpl(dashBoardApiService));

    Get.put(HrDashBoardController(dasBoardDataSource));

  }

}

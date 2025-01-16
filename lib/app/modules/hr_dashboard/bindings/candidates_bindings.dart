import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/repositories/dashboard_repository.dart';
import '../../../global/services/api_service.dart';
import '../controllers/candidates_details_controller.dart';
import '../controllers/hr_deshboard_controller.dart';
import '../services/dashboard_api_services.dart';

class CandidatesBindings  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>CandidateDetailsController(Get.find<DashBoardDataSource>()));
  }
}

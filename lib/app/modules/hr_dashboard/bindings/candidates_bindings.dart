import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/repositories/dashboard_repository.dart';
import '../controllers/candidates_details_controller.dart';

class CandidatesBindings  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>CandidateDetailsController(Get.find<DashBoardDataSource>()));
  }
}

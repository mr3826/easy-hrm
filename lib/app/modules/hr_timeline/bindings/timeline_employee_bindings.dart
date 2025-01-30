import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/bindings/timeline_global_bindings.dart';
import '../../../global/services/api_service.dart';
import '../controllers/employee_timeline_controller.dart';
import '../repositories/timeline_data_source.dart';
import '../services/timeline_api_service.dart';

class EmployeeTimelineBindings extends Bindings {
  @override
  void dependencies() {
    TimelineApiService timelineApiService = Get.put(TimelineApiService(Get.find<ApiService>()));
    TimelineDataSource timelineDataSource = Get.put(TimelineDataImpl(timelineApiService));
    Get.lazyPut(() => EmployeeTimelineController(timelineDataSource));
    TimelineGlobalBindings().dependencies();
  }
}

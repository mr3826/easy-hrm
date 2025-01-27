import 'package:get/get.dart';
import '../../../global/services/api_service.dart';
import '../controllers/hr_timeline_controller.dart';
import '../controllers/start_timer_controller.dart';
import '../repositories/timeline_data_source.dart';
import '../services/timeline_api_service.dart';


class TimelineBindings extends Bindings{
  @override
  void dependencies() {
    TimelineApiService timelineApiService = Get.put(TimelineApiService(Get.find<ApiService>()));
    TimelineDataSource timelineDataSource = Get.put(TimelineDataImpl(timelineApiService));
    Get.put(HrTimelineController(timelineDataSource));
    Get.put(StartTimerController());
  }
}

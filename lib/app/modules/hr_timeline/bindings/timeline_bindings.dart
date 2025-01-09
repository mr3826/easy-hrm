import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/timeline_controller.dart';

import '../../../global/services/api_service.dart';
import '../repositories/timline_repository.dart';

class TimelineBindings {
  static initTimelineBindings() {
    ApiService apiService = Get.find<ApiService>();
    TimelineApiServices timelineApiServices = TimelineApiServices(apiService);
    TimelineRepoImpl timelineRepoImpl = TimelineRepoImpl(timelineApiServices);
    Get.put(timelineRepoImpl);
    Get.put(HrTimelineController());
  }
}

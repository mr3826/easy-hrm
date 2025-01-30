import 'package:get/get.dart';
import '../controllers/timelog_summary_controller.dart';
import '../repositories/timeline_data_source.dart';

class TimeSheetBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(()=>TimelineSummaryController(Get.find<TimelineDataSource>()));
  }

}


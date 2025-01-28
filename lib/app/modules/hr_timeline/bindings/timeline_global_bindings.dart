import 'package:get/get.dart';
import '../controllers/global_timline_controller.dart';
import '../repositories/timeline_data_source.dart';

class TimelineGlobalBindings  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => TimelineGlobalController(Get.find<TimelineDataSource>()));
  }
}

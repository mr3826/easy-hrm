import 'package:get/get.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../controllers/timeline_controller.dart';


class AddNewEntryBindings  extends Bindings {
  @override
  void dependencies() {
    Get.put(DateTimeController());
    Get.put(HrTimelineController());
  }
}

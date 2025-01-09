import 'package:get/get.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../../../global/services/api_service.dart';
import '../controllers/timeline_controller.dart';
import '../repositories/timline_repository.dart';


class AddNewEntryBindings  extends Bindings {
  @override
  void dependencies() {
    Get.put(DateTimeController());
  }
}

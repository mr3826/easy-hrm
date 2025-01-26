import 'package:get/get.dart';
import '../../../../modules/profile/controller/employment_controller.dart';
import '../controllers/time_sheet_controller.dart';
import '../repositories/timeline_data_source.dart';

class TimeSheetBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(()=>TimeSheetController(Get.find<TimelineDataSource>()));
  }


}
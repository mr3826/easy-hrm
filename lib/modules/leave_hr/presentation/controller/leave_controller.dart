import 'package:get/get.dart';
import '../../../../utils/app_string.dart';

class LeaveController extends GetxController {
  RxInt tabLength = 0.obs;  // Reactive variable for tab index
  RxList<String> tabList = [AppString.textCalendar, AppString.textLeaveRecord].obs;  // Reactive list
}

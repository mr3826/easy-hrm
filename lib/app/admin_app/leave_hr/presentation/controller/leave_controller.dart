import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/app_string.dart';

class LeaveController extends GetxController {
  RxInt tabLength = 0.obs;
  RxInt listIndex=0.obs;
  RxList<String> tabList = [AppString.textCalendar, AppString.textLeaveRecord].obs;
  List dayList=["Today","Yesterday","This week","Last week","This month","Last month","Custom"];

  final searchController = TextEditingController().obs;
  final searchText = ''.obs;
  final selectedDateRange = "".obs;

  RxString currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;




}

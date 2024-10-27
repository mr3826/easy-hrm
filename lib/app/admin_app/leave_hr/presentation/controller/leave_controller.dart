import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/app_string.dart';

class LeaveController extends GetxController {
  RxInt tabLength = 0.obs;  // Reactive variable for tab index
  RxList<String> tabList = [AppString.textCalendar, AppString.textLeaveRecord].obs;  // Reactive list

  final searchController = TextEditingController().obs; // Update the controller inside the method
  final searchText = ''.obs;


  RxInt listIndex=0.obs;


  List dayList=["Today","Yesterday","This week","Last week","This month","Last month","Custom"];
 RxString currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;








}

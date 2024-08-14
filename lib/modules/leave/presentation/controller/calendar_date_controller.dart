
import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/controller/date_time_controller.dart';

class DateController extends GetxController {
  Rx<DateTime> currentDate = DateTime.now().obs;

  Rx<DateTime> toDate = DateTime.now().obs;
  Rx<DateTime> fromDate = DateTime.now().obs;
  Rx<DateTime> getCurrentDate = DateTime.now().obs;

  final DateFormat formatter = DateFormat('dd MMM yyyy');
  final DateFormat onlyDay = DateFormat('EEEE');

  void incrementMonth() {
    currentDate.value = currentDate.value.add(const Duration(days: 1));
    formattedDateTime = DateFormat("yyyy-MM-dd").format(currentDate.value);
    Get.find<DateTimeController>().requestedDate.value=formattedDateTime;
    log(formattedDateTime);
  }

  void decrementDate() {
    currentDate.value = currentDate.value.subtract(const Duration(days: 1));
    formattedDateTime = DateFormat("yyyy-MM-dd").format(currentDate.value);
    Get.find<DateTimeController>().requestedDate.value=formattedDateTime;
    log(currentDate.value.toString());
  }

  String formattedDateTime = DateFormat("yyyy-MM-dd").format(DateTime.now());

  getFormattedDate() {
    return formatter.format(DateTime.parse(formattedDateTime));
  }

  String getFormattedCurrentData() {
    return formatter.format(getCurrentDate.value);
  }

  String getOnlyDay() {
    DateTime dateTime = DateFormat("dd MMM yyyy").parse(getFormattedDate());
    return onlyDay.format(dateTime);
  }
}

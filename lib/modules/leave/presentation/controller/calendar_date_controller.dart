import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateController extends GetxController {
  Rx<DateTime> currentDate = DateTime.now().obs;
  Rx<DateTime> getCurrentDate = DateTime.now().obs;

  final DateFormat formatter = DateFormat('dd MMM yyyy');
  final DateFormat onlyDay = DateFormat('EEEE');


  void incrementMonth() {
    currentDate.value = currentDate.value.add(const Duration(days: 1));  }

  void decrementDate() {
    currentDate.value = currentDate.value.subtract(const Duration(days: 1));
  }

   getFormattedDate() {
    return formatter.format(currentDate.value);
  }
  String getFormattedCurrentData() {

    return formatter.format(getCurrentDate.value);
  }

  String getOnlyDay(){
    // Parse the input date string
    DateTime dateTime = DateFormat("dd MMM yyyy").parse(getFormattedDate());
    return onlyDay.format(dateTime);

  }

}
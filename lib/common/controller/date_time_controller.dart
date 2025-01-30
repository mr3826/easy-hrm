import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class DateTimeController extends GetxController {
  RxBool isInTimeClicked = false.obs;
  final RxInt currentIndex = 1.obs;
  String selectedInputHrs = '06';
  String selectedInputMins = '30';
  String clockHrsFormat = 'PM';
  RxString requestedDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString requestedEndDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;


  RxString timeLogDate = "".obs;

  RxString requestedInDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString requestedOutDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString pickedInTime = ''.obs;
  RxString pickedOutTime = ''.obs;
  TextEditingController editController = TextEditingController();

  RxString? leaveId = ''.obs;
  RxBool isErrorOccurred = false.obs;

  void getTime() {
    if (isInTimeClicked.isTrue) {
      //only time
      pickedInTime.value =
          "${selectedInputHrs.padLeft(2, '0')}:${selectedInputMins.padLeft(2, '0')} $clockHrsFormat";

      //total datetime
      requestedInDate.value = DateFormat("yyyy-MM-dd hh:mma")
          .parse(
              "${Get.find<DateTimeController>().requestedDate.value} ${Get.find<DateTimeController>().pickedInTime.value.replaceAll(" ", "")}$clockHrsFormat")
          .toString();
      print(requestedInDate.value);
    } else {
      //only time
      pickedOutTime.value =
          "${selectedInputHrs.padLeft(2, '0')}:${selectedInputMins.padLeft(2, '0')} $clockHrsFormat";
      //total datetime
      requestedOutDate.value = DateFormat("yyyy-MM-dd hh:mma")
          .parse(
              "${Get.find<DateTimeController>().requestedDate.value} ${Get.find<DateTimeController>().pickedOutTime.value.replaceAll(" ", "")}$clockHrsFormat")
          .toString();
      print(requestedOutDate.value);
    }

    isInTimeClicked.value = !isInTimeClicked.value;
    selectedInputHrs = '06';
    selectedInputMins = '30';
    clockHrsFormat = 'PM';
  }

  void getApplyLeaveTime() {
    if (isInTimeClicked.isTrue) {
      //only time
      pickedInTime.value =
          "${selectedInputHrs.padLeft(2, '0')}:${selectedInputMins.padLeft(2, '0')} $clockHrsFormat";

      //total datetime
      if (requestedInDate.value.length > 10) {
        requestedInDate.value = DateFormat("yyyy-MM-dd hh:mma")
            .parse(
                "${DateFormat("yyyy-MM-dd").format(DateTime.parse(Get.find<DateTimeController>().requestedInDate.value))} ${Get.find<DateTimeController>().pickedInTime.value.replaceAll(" ", "")}$clockHrsFormat")
            .toString();
      } else {
        requestedInDate.value = DateFormat("yyyy-MM-dd hh:mma")
            .parse(
                "${Get.find<DateTimeController>().requestedInDate.value} ${Get.find<DateTimeController>().pickedInTime.value.replaceAll(" ", "")}$clockHrsFormat")
            .toString();
      }
    } else {
      //only time
      pickedOutTime.value =
          "${selectedInputHrs.padLeft(2, '0')}:${selectedInputMins.padLeft(2, '0')} $clockHrsFormat";
      //total datetime
      if (requestedOutDate.value.length > 10) {
        requestedOutDate.value = DateFormat("yyyy-MM-dd hh:mma")
            .parse(
                "${DateFormat("yyyy-MM-dd").format(DateTime.parse(Get.find<DateTimeController>().requestedOutDate.value))} ${Get.find<DateTimeController>().pickedInTime.value.replaceAll(" ", "")}$clockHrsFormat")
            .toString();
      } else {
        requestedOutDate.value = DateFormat("yyyy-MM-dd hh:mma")
            .parse(
                "${Get.find<DateTimeController>().requestedOutDate.value} ${Get.find<DateTimeController>().pickedOutTime.value.replaceAll(" ", "")}$clockHrsFormat")
            .toString();
      }
    }

    isInTimeClicked.value = !isInTimeClicked.value;
    selectedInputHrs = '06';
    selectedInputMins = '30';
    clockHrsFormat = 'PM';
  }

  @override
  void dispose() {
    isInTimeClicked.value = false;
    super.dispose();
  }
}

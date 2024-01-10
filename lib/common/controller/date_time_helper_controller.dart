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
  RxString timeLogDate = "".obs;
  RxString requestedInDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString requestedOutDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString  pickedInTime = ''.obs;
  RxString pickedOutTime = ''.obs;
  TextEditingController editController = TextEditingController();

  RxString numberOfLeaves = ''.obs;
  RxString? leaveId = ''.obs;
  RxBool isNoteRequired = false.obs;
  RxBool isDocumentRequired = false.obs;
  RxBool isErrorOccurred = false.obs;



  void getTime() {
    print("gettime called");

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
    print("getApplyLeaveTime called");
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

  getUpdateLeaveTime(){
    if (isInTimeClicked.isTrue) {
      //only time
      pickedInTime.value =
      "${selectedInputHrs.padLeft(2, '0')}:${selectedInputMins.padLeft(2, '0')} $clockHrsFormat";

      //total datetime
      requestedInDate.value = DateFormat("yyyy-MM-dd hh:mma")
          .parse(
          "${Get.find<DateTimeController>().requestedInDate.value} ${Get.find<DateTimeController>().pickedInTime.value.replaceAll(" ", "")}$clockHrsFormat")
          .toString();
      print(requestedInDate.value);
    } else {
      //only time
      pickedOutTime.value =
      "${selectedInputHrs.padLeft(2, '0')}:${selectedInputMins.padLeft(2, '0')} $clockHrsFormat";
      //total datetime
      requestedOutDate.value = DateFormat("yyyy-MM-dd hh:mma")
          .parse(
          "${Get.find<DateTimeController>().requestedOutDate.value} ${Get.find<DateTimeController>().pickedOutTime.value.replaceAll(" ", "")}$clockHrsFormat")
          .toString();
      print(requestedOutDate.value);
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

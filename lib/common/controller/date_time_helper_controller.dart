import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../modules/timeline/controller/time_formate_controller.dart';

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
  RxString pickedInTime = ''.obs;
  RxString pickedOutTime = ''.obs;
  TextEditingController editController = TextEditingController();

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
    } else {
      //only time
      pickedOutTime.value =
          "${selectedInputHrs.padLeft(2, '0')}:${selectedInputMins.padLeft(2, '0')} $clockHrsFormat";
      //total datetime
      requestedOutDate.value = DateFormat("yyyy-MM-dd hh:mma") //
          .parse(
              "${Get.find<DateTimeController>().requestedDate.value} ${Get.find<DateTimeController>().pickedOutTime.value.replaceAll(" ", "")}$clockHrsFormat")
          .toString();



      //log("Time-log ==> ${ Get.find<DateTimeController>().timeLogDate.value}",error: 21);






      //
      // requestedOutDate.value = DateFormat("yyyy-MM-dd hh:mma") //
      //     .parse(
      //         "${Get.find<DateTimeController>().requestedDate.value} ${Get.find<DateTimeController>().pickedInTime.value.replaceAll(" ", "")}")
      //
      //     .toString(); requestedOutDate.value = DateFormat("yyyy-MM-dd hh:mma") //
      //
      //     .parse(
      //         "${Get.find<DateTimeController>().requestedDate.value} ${Get.find<DateTimeController>().pickedOutTime.value.replaceAll(" ", "")}")
      //     .toString();



    }



    print(requestedOutDate.toString());
    print(requestedInDate.toString());

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

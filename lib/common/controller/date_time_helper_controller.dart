import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeController extends GetxController {
  RxBool isInTimeClicked = false.obs;
  String selectedInputHrs = '06';
  String selectedInputMins = '30';
  String clockHrsFormat = '';
  RxString requestedDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString requestedInDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString requestedOutDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  RxString pickedInTime = ''.obs;
  RxString pickedOutTime = ''.obs;
  TextEditingController editController=TextEditingController();

  void getTime() {
    if (clockHrsFormat.isNotEmpty) {
      isInTimeClicked.isTrue
          ? pickedInTime.value =
              "${selectedInputHrs.padLeft(2, '0')}:${selectedInputMins.padLeft(2, '0')} $clockHrsFormat"
          : pickedOutTime.value =
              "${selectedInputHrs.padLeft(2, '0')}:${selectedInputMins.padLeft(2, '0')} $clockHrsFormat";
    }
    isInTimeClicked.value = !isInTimeClicked.value;
    selectedInputHrs = '06';
    selectedInputMins = '30';
  }

  @override
  void dispose() {
    isInTimeClicked.value = false;
    super.dispose();
  }
}

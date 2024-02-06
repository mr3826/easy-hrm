import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimePickerController extends GetxController {
  @override
  void onInit() async {
    ///for default value
    ///out time should be added first

    outDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
    outTime = DateFormat('HH:mm').format(DateTime.now()).obs;
    inDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
    inTime = DateFormat('HH:mm').format(DateTime.now()).obs;
    getOutDateTime();
    getInDateTime();
    super.onInit();
  }

  late RxString inTime;
  late RxString inDate;
  late RxString outTime;
  late RxString outDate;
  RxString inDateTime = ''.obs;
  RxString outDateTime = ''.obs;

  getInDateTime() {
    try {
      DateTime dateTime = DateTime(
        int.parse(inDate.substring(0, 4)),
        int.parse(inDate.substring(5, 7)),
        int.parse(inDate.substring(8, 10)),
        int.parse(inTime.substring(0, 2)),
        int.parse(inTime.substring(3, 5)),
      );
      inDateTime.value = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
      print("inDateTime::${inDateTime.value}");
    } catch (e) {
      inDateTime.value = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
      print("inDateTime::${inDateTime.value}");
    }
  }

  getOutDateTime() {
    try {
      DateTime dateTime = DateTime(
        int.parse(outDate.substring(0, 4)),
        int.parse(outDate.substring(5, 7)),
        int.parse(outDate.substring(8, 10)),
        int.parse(outTime.substring(0, 2)),
        int.parse(outTime.substring(3, 5)),
      );
      outDateTime.value = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    } catch (e) {
      outDateTime.value = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    }
  }
}

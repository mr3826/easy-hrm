import 'package:get/get.dart';

class EmploymentController extends GetxController {
  RxInt daysCount = 0.obs;
  RxInt applicationBalanceCount = 0.obs;
  RxInt applicationMaxDaysCount = 0.obs;

  void dayIncrement() {
    daysCount++;
  }

  void dayDecrement() {
    if (daysCount > 0) {
      daysCount--;
    }
  }

  void applicationBalanceIncrement() {
    applicationBalanceCount++;
  }

  void applicationBalanceDecrement() {
    if (applicationBalanceCount > 0) {
      applicationBalanceCount--;
    }
  }

  void applicationMaxDayIncrement() {
    applicationMaxDaysCount++;
  }

  void applicationMaxDayDecrement() {
    if (applicationMaxDaysCount > 0) {
      applicationMaxDaysCount--;
    }
  }
}

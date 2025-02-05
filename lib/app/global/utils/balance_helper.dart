import 'package:payrun_mobile/app/global/utils/time_format_helper.dart';

class BalanceCalculatorHelper {

  static calculateBalance(String balanceSecond, String pendingSecond) {
    if (balanceSecond.isEmpty || pendingSecond.isEmpty) return "";
    double totalSecond = double.parse(balanceSecond) + double.parse(pendingSecond);
   return TimeFormatHelper.formatSecondsToHoursSolid(totalSecond.toString());
  }

}



import 'package:intl/intl.dart';

String formatTime(DateTime dateTime) {
  // Format the DateTime in 24-hour format with AM/PM
  return DateFormat('hh.mm').format(dateTime);
}
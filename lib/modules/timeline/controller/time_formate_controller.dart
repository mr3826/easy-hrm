import 'package:intl/intl.dart';

String timeFormatTo24h(DateTime dateTime) {
  // Format the DateTime in 24-hour format with AM/PM
  return DateFormat('HH:mm').format(dateTime);
}

String timeFormatTo12h({required String time}) {
  // Format the DateTime in 12-hour format with AM/PM
  DateTime dateTime = DateFormat.Hm().parse(time);
  return  DateFormat.jm().format(dateTime);
}

String formatTimeAccordingToSelectedTime(inputString) {
  // Define the input format
  DateFormat inputFormat = DateFormat('y-MM-dd H:m:s.S');

  // Parse the input string
  DateTime inputDateTime = inputFormat.parse(inputString);

  // Define the desired output format
  DateFormat outputFormat = DateFormat('y-MM-dd');

  // Format the DateTime object in the desired output format
  String formattedDate = outputFormat.format(inputDateTime);
  return formattedDate;
}



import 'package:intl/intl.dart';

String formatTime(DateTime dateTime) {
  // Format the DateTime in 24-hour format with AM/PM
  return DateFormat('hh.mm').format(dateTime);
}

formatTimeAccordingToSelectedTime(inputString){
  // Define the input format
  DateFormat inputFormat = DateFormat('y-MM-dd H:m:s.S');

  // Parse the input string
  DateTime inputDateTime = inputFormat.parse(inputString);

  // Define the desired output format
  DateFormat outputFormat = DateFormat('y-MM-dd');

  // Format the DateTime object in the desired output format
  String formattedDate = outputFormat.format(inputDateTime);

  print(formattedDate);
  return formattedDate;
}
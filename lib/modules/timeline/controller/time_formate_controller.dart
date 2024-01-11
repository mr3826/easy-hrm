import 'package:intl/intl.dart';

String timeFormatTo24h(DateTime dateTime) {
  // Format the DateTime in 24-hour format with AM/PM
  return DateFormat('hh.mm').format(dateTime);
}

String timeFormatTo12h({required String time}) {
  // Format the DateTime in 12-hour format with AM/PM
  DateTime dateTime = DateFormat.Hm().parse(time);
  return  DateFormat.jm().format(dateTime);
}


String dateTimeAddedFormat({required date,required time}) {

  String combinedString = date + "" + time;

  int year = int.parse(combinedString.substring(0, 4));
  int month = int.parse(combinedString.substring(5, 7));
  int day = int.parse(combinedString.substring(8, 10));
  int hour = int.parse(combinedString.substring(10, 12));
  int minute = int.parse(combinedString.substring(12, 14));

  // Create a DateTime object
  DateTime dateTime = DateTime.utc(year, month, day, hour, minute);

  // Format the DateTime object as a string in the desired format
  return DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').format(dateTime);

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

  print(formattedDate);
  return formattedDate;
}


import 'package:intl/intl.dart';


getDateTimeFormat(dateString){
  if(dateString.isEmpty) return"";
  DateTime dateTime = DateTime.parse(dateString);
  // Format the DateTime to "dd, MMM"
  return DateFormat('dd MMM, yyyy').format(dateTime);
}




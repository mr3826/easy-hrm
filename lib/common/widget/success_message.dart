import 'package:fluttertoast/fluttertoast.dart';
import 'package:payrun_mobile/utils/app_color.dart';

void showSuccessMessage({String? message}) async =>
Fluttertoast.showToast(
msg: "$message",
toastLength: Toast.LENGTH_SHORT,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 1,
backgroundColor: AppColor.normalTextColor,
textColor: AppColor.cardColor,
fontSize: 16.0
);

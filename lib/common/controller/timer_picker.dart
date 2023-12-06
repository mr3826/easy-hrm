import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_helper_controller.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_wheel_picker_hrs.dart';
import 'package:payrun_mobile/common/widget/custom_wheel_picker_mins.dart';
import 'package:payrun_mobile/common/widget/warning_message.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import '../../modules/leave/view/widget/am_pm_button_layout.dart';
import '../../utils/app_layout.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../utils/app_style.dart';
import '../../utils/dimensions.dart';


Future timePicker(BuildContext context) {
  var date=DateTime.now();
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      insetPadding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(0, 3),
              )
            ]),
        margin: EdgeInsets.symmetric(
            horizontal: AppLayout.getWidth(Dimensions.paddingLarge)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customButtonSheetAppbar(text: AppString.text_select_starting_time.tr,subtext: "Thursday"),
            _openClock(),
            const AmPmToggleButton(),

            customSpacerHeight(height: 28),
            _saveButton(context),

            customSpacerHeight(height: 20),

          ],
        ),
      ),
    ),
  );
}

_openClock() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _hrs(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(24)),
            child: Text(
              " : ",
              style: AppStyle.large_text_black.copyWith(
                  color: AppColor.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          _mins(),
        ],
      ),
      SizedBox(height: AppLayout.getHeight(Dimensions.paddingLarge)),
    ],
  );
}

_hrs() {
  List<String> hrsList =
      List.generate(13, (element) => element < 10 ? "0$element" : "$element");
  return SizedBox(
    height: AppLayout.getHeight(200),
    width: AppLayout.getWidth(40),
    child: Center(
      child: CustomWheelPickerHrs(
          list: hrsList, controller: Get.find<DateTimeController>()),
    ),
  );
}

_mins() {
  List<String> minList =
      List.generate(60, (element) => element < 10 ? "0$element" : "$element");
  return SizedBox(
    height: AppLayout.getHeight(200),
    width: AppLayout.getWidth(40),
    child: Center(
      child: CustomWheelPickerMins(
          list: minList, controller: Get.find<DateTimeController>()),
    ),
  );
  // return Container();
}

_saveButton(BuildContext context) {
  return Padding(
    padding: marginLayout,
    child:CustomDoubleAppButton(buttonText: AppString.text_save.tr, onAction: (){
      if (Get.find<DateTimeController>().clockHrsFormat.isNotEmpty) {
        Get.find<DateTimeController>().getTime();
        Navigator.of(context).pop();
      } else {
        showWarningMessage(
            message: "Select a valid time before ");
      }

    }, cancelAction: ()=>Get.back()),


  );
}


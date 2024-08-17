import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_wheel_picker_hrs.dart';
import 'package:payrun_mobile/common/widget/custom_wheel_picker_mins.dart';
import '../../modules/leave/presentation/view/widget/am_pm_button_layout.dart';
import '../../utils/app_layout.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../utils/app_style.dart';
import '../../utils/dimensions.dart';

Future timePicker(BuildContext context, bool? isCalledFromApplyLeave) {
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
            borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customButtonSheetAppbar(
                text: AppString.text_select_starting_time.tr,
                subtext: DateFormat('EEEE, dd-MM-yyyy').format(DateTime.parse(
                    Get.find<DateTimeController>().requestedDate.value))),
            _openClock(),
            const AmPmToggleButton(),
            customSpacerHeight(height: 28),
            const Divider(
              thickness: 1,
            ),
            _buttonLayout(context: context, isCalledFromApplyLeave: isCalledFromApplyLeave),
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

_buttonLayout({context, bool? isCalledFromApplyLeave}) {
  return Row(
    children: [
      const Spacer(),
      InkWell(
          onTap: () => Get.back(),
          child: Text(
            AppString.text_cancel.tr,
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor,
                fontSize: Dimensions.fontSizeDefault + 1),
          )),
      customSpacerWidth(width: 40),
      InkWell(
          onTap: () {
           if(isCalledFromApplyLeave==true){
             Get.find<DateTimeController>().getApplyLeaveTime();
           }else{
             Get.find<DateTimeController>().getTime();
           }
            Navigator.of(context).pop();
          },
          child: SizedBox(
            width: 30,
            child: Text(
              AppString.text_ok.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.primaryColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            ),
          )),
      customSpacerWidth(width: 40),
    ],
  );
}

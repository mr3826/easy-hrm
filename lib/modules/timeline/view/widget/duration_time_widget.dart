import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../common/widget/custom_status_button.dart';
import '../../../../enum.dart';
import '../../../../utils/app_string.dart';

Widget durationTimeLayout({String? status}) {
  print("Status:: $status");
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: marginLayout.copyWith(top: 20, bottom: 20),
      child: Column(
        children: [
          Obx(() => Text(
                DateFormat('EEE, dd MMM yyyy').format(DateTime.parse(
                    Get.find<DateTimePickerController>().inDateTime.value)),
                style: AppStyle.mid_large_text.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: status != null
                        ? Colors.white
                        : AppColor.normalTextColor),
              )),
          customSpacerHeight(height: 18),
          Text(
            "Duration",
            style: AppStyle.mid_large_text.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: status != null ? Colors.white : AppColor.hintColor),
          ),
          Obx(() => Text(
                _getTimeDuration(),
                style: AppStyle.normal_text_grey.copyWith(
                    fontSize: Dimensions.fontSizeMid + 5,
                    fontWeight: FontWeight.w900,
                    color: status != null
                        ? Colors.white
                        : AppColor.normalTextColor),
              )),
          if (status != null) _statusButtonLayout(status: status),
          customSpacerHeight(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _verticalDivider(
                  height: 13,
                  bgColor: status == null
                      ? AppColor.hintColor.withOpacity(0.3)
                      : Colors.white),
              customSpacerWidth(width: 30),
              _verticalDivider(
                  height: 17,
                  bgColor: status == null
                      ? AppColor.hintColor.withOpacity(0.5)
                      : Colors.white),
              customSpacerWidth(width: 30),
              _verticalDivider(
                  height: 22,
                  bgColor: status == null
                      ? AppColor.hintColor.withOpacity(0.7)
                      : Colors.white),
              customSpacerWidth(width: 30),
              _verticalDivider(
                  height: 24,
                  bgColor: status == null
                      ? AppColor.hintColor.withOpacity(0.9)
                      : Colors.white),
              customSpacerWidth(width: 30),
              _verticalDivider(
                  height: 22,
                  bgColor: status == null
                      ? AppColor.hintColor.withOpacity(0.7)
                      : Colors.white),
              customSpacerWidth(width: 30),
              _verticalDivider(
                  height: 17,
                  bgColor: status == null
                      ? AppColor.hintColor.withOpacity(0.5)
                      : Colors.white),
              customSpacerWidth(width: 30),
              _verticalDivider(
                  height: 13,
                  bgColor: status == null
                      ? AppColor.hintColor.withOpacity(0.3)
                      : Colors.white),
            ],
          )
        ],
      ),
    ),
  );
}

_statusButtonLayout({required String status}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      customSpacerHeight(height: 16),
      SizedBox(
        width: 150,
        child: _showStatusButton(status),
      ),
    ],
  );
}

_getColor(String leaveStatus) {
  if (leaveStatus.toLowerCase() == LeaveStatus.approved.name) {
    return AppColor.primaryColor;
  } else if (leaveStatus.toLowerCase() == LeaveStatus.pending.name) {
    return AppColor.pendingColor;
  } else if (leaveStatus.toLowerCase() == "reject") {
    return AppColor.errorColor;
  } else {
    return AppColor.bgColorWithTimeline;
  }
}

_showStatusButton(String leaveStatus) {
  if (leaveStatus.toLowerCase() == LeaveStatus.approved.name) {
    return _statusBtn(
        textColor: _getColor(leaveStatus), text: AppString.text_approved.tr);
  } else if (leaveStatus.toLowerCase() == LeaveStatus.pending.name) {
    return _statusBtn(
        textColor: _getColor(leaveStatus), text: AppString.text_pending.tr);
  } else if (leaveStatus.toLowerCase() == "reject") {
    return _statusBtn(
        textColor: _getColor(leaveStatus), text: AppString.text_rejected.tr);
  } else {
    return Container();
  }
}

Widget _statusBtn({required Color textColor, required String? text}) {
  return CustomStatusButton(
    textColor: textColor,
    bgColor: AppColor.cardColor,
    text: text,
  );
}

String _getTimeDuration() {
  Duration timeDifference = DateTime.parse(
          "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().outTime.value}")
      .difference(DateTime.parse(
          "${Get.find<DateTimePickerController>().inDate.value} ${Get.find<DateTimePickerController>().inTime.value}"));

  return timeDifference.isNegative
      ? "0h 0m"
      : "${timeDifference.inHours}h ${(timeDifference.inMinutes - timeDifference.inHours * 60).abs()}m";
}

_verticalDivider({required double height, required Color bgColor}) {
  return Container(
    height: height,
    width: 1,
    color: bgColor,
  );
}

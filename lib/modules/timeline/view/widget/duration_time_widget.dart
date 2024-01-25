import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

import '../../../../common/controller/date_time_controller.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../enum.dart';
import '../../../leave/view/widget/status_btn_widget.dart';

Widget durationTimeLayout({
  String? status,
}) {
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
                    color: AppColor.normalTextColor),
              )),
          customSpacerHeight(height: 18),
          Text(
            "Duration",
            style: AppStyle.mid_large_text.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: AppColor.hintColor),
          ),
          Obx(() => Text(
                _getTimeDuration(),
                style: AppStyle.normal_text_grey.copyWith(
                    fontSize: Dimensions.fontSizeMid + 5,
                    fontWeight: FontWeight.w900,
                    color: AppColor.normalTextColor),
              )),
          if (status != null) _statusButtonLayout(status: status),
          customSpacerHeight(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _verticalDivider(
                  height: 13, bgColor: AppColor.hintColor.withOpacity(0.3)),
              customSpacerWidth(width: 30),
              _verticalDivider(
                  height: 17, bgColor: AppColor.hintColor.withOpacity(0.5)),
              customSpacerWidth(width: 30),
              _verticalDivider(
                  height: 22, bgColor: AppColor.hintColor.withOpacity(0.7)),
              customSpacerWidth(width: 30),
              _verticalDivider(
                  height: 24, bgColor: AppColor.hintColor.withOpacity(0.9)),
              customSpacerWidth(width: 30),
              _verticalDivider(
                  height: 22, bgColor: AppColor.hintColor.withOpacity(0.7)),
              customSpacerWidth(width: 30),
              _verticalDivider(
                  height: 17, bgColor: AppColor.hintColor.withOpacity(0.5)),
              customSpacerWidth(width: 30),
              _verticalDivider(
                  height: 13, bgColor: AppColor.hintColor.withOpacity(0.3)),
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

_showStatusButton(String leaveStatus) {
  if (leaveStatus.toLowerCase() == LeaveStatus.approved.name) {
    return approvedStatusBtn();
  } else if (leaveStatus.toLowerCase() == LeaveStatus.pending.name) {
    return pendingStatusBtn();
  } else {
    return Container();
  }
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

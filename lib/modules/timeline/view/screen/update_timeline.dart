import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/controller/timer_picker.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/new_entry_text_field_widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_field_widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_view_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../common/widget/custom_status_button.dart';
import '../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../leave/view/widget/custom_title_text_widget.dart';
import '../../../leave/view/widget/single_date_picker_calendar.dart';
import '../../../leave/view/widget/timmer_text_field_dob.dart';
import '../../../starting/view/splash_screen.dart';

class UpdateTimeLineLog extends StatelessWidget {
  final String? status;
  final String startDateTime;
  final String endDateTime;

  const UpdateTimeLineLog(
      {this.status,
      required this.startDateTime,
      required this.endDateTime,
      super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<DateTimePickerController>()) {
      Get.delete<DateTimePickerController>();
    }
    Get.put(DateTimePickerController());
    _updateTimelogFromApiResponse();
    return Scaffold(
      backgroundColor: _statusColor(status: status ?? ""),
      appBar: timeLogAppbar(context),
      body: SingleChildScrollView(
          child: TimeLogEntryTextField(
        isFromUpdateTimelogEntry: true,
        status: status,
      )),
    );
  }

  void _updateTimelogFromApiResponse() {
    Get.find<DateTimePickerController>().inDate.value =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(startDateTime));
    Get.find<DateTimePickerController>().inTime.value =
        DateFormat('HH:mm').format(DateTime.parse(startDateTime));

    Get.find<DateTimePickerController>().outDate.value =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(endDateTime));
    Get.find<DateTimePickerController>().outTime.value =
        DateFormat('HH:mm').format(DateTime.parse(endDateTime));

    Get.find<DateTimePickerController>().getInDateTime();
    Get.find<DateTimePickerController>().getOutDateTime();
  }

  _statusColor({required String status}) {
    switch (status) {
      case "approved":
        return AppColor.primaryColor;
      case "pending":
        return AppColor.pendingColor;
      case "reject":
        return AppColor.errorColorLight;
      default:
        return AppColor.bgColorWithTimeline;
    }
  }
}

AppBar timeLogAppbar(context) {
  return AppBar(
    elevation: 0,
    backgroundColor: AppColor.backgroundColor,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColor.hintColor,
        size: Dimensions.fontSizeMid + 4,
      ),
    ),
    centerTitle: true,
    title: Text(
      AppString.text_time_log_details.tr,
      style:
          AppStyle.normal_text_black.copyWith(fontSize: Dimensions.fontSizeMid),
    ),
  );
}

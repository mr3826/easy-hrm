import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/global_timline_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../app/modules/hr_timeline/view/widgets/time_sheet/timelog_summary_details.dart';
import '../../../../app/modules/hr_timeline/view/widgets/timeline_calender/new_entry/build_new_entry_text_field.dart';
import '../../../../common/widget/timePicker/custom_time_picker_in_time.dart';
import '../../../../common/widget/timePicker/date_time_picker_controller.dart';

class UpdateTimeLineLog extends StatelessWidget {
  final String? status;
  final String startDateTime;
  final String endDateTime;
  final Color projectOrTaskColor;
 final LogSummaryUserInfo ?logSummaryUserInfo;
  const UpdateTimeLineLog(
      {this.status,
      required this.projectOrTaskColor,
      required this.startDateTime,
        this.logSummaryUserInfo,
      required this.endDateTime,
      super.key});

  @override
  Widget build(BuildContext context) {
    _updateTimelogFromApiResponse();
    return Scaffold(
      backgroundColor: projectOrTaskColor,
      appBar: timeLogAppbar(context),
      body: SingleChildScrollView(
          child: BuildNewEntryTextField(
        isFromUpdateTimelogEntry: true,
        logSummaryUserInfo: logSummaryUserInfo,
        status: status, isEmployee: Get.find<TimelineGlobalController>().isEmployee.value,
      )),
    );
  }

  void _updateTimelogFromApiResponse() {
    Get.find<DateTimePickerController>().inDate.value =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(startDateTime));
    Get.find<DateTimePickerController>().inTime.value =
        DateFormat('HH:mm').format(DateTime.parse(startDateTime));

    Get.find<DateTimePickerController>().outDate.value = endDateTime.isEmpty
        ? DateFormat('yyyy-MM-dd').format(DateTime.now())
        : DateFormat('yyyy-MM-dd').format(DateTime.parse(endDateTime));

    Get.find<DateTimePickerController>().outTime.value = endDateTime.isEmpty
        ? DateFormat('HH:mm').format(DateTime.now())
        : DateFormat('HH:mm').format(DateTime.parse(endDateTime));

    Get.find<DateTimePickerController>().getInDateTime();
    Get.find<DateTimePickerController>().getOutDateTime();
    setIndexForPrevTdayOrTomListTimelog(DateTime.parse(startDateTime));


  }
}

AppBar timeLogAppbar(BuildContext context) {
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

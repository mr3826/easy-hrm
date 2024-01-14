import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_status_button.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../widget/logdetails_widget.dart';

class TimeLogDetails extends StatelessWidget {
  final String dtsStartTime;
  final String dtsEndTime;
  final String dtsDateStatus;
  final String dtsProjectName;
  final String startDateTime;
  final String endDateTime;
  final Color? dtsBgColor;
  final String timeLineId;
  final String dtsDrc, dtsDuration;
  final String dtsDate, dtsStatus;

  const TimeLogDetails(
      {super.key,
      required this.dtsStartTime,
      required this.dtsEndTime,
      required this.dtsDateStatus,
      required this.dtsProjectName,
      required this.dtsBgColor,
      required this.startDateTime,
      required this.endDateTime,
      required this.dtsDrc,
      required this.timeLineId,
      required this.dtsDuration,
      required this.dtsDate,
      required this.dtsStatus});

  @override
  Widget build(BuildContext context) {
    print("dtsDate;; $startDateTime");
    _updateDataFromApiResponse();
      return Scaffold(
      backgroundColor: dtsBgColor,
      appBar: timeLogAppbar(context),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: AppLayout.getHeight(195),
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              width: double.infinity,
              child: _durationTimeLayout(context),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radiusMid + 8),
                      topLeft: Radius.circular(Dimensions.radiusMid + 8))),
              child: TimeLogTextField(
                endTime: dtsEndTime,
                startTime: dtsStartTime,
                timeLineId: timeLineId,
                date: dtsDate,
                drc: dtsDrc,
                status: dtsStatus,
                projectName: dtsProjectName,
                scheduleStatus: dtsDateStatus,
                dotColor: dtsBgColor,
                endDateTime: endDateTime,
                startDateTime: startDateTime,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _durationTimeLayout(context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          shape: roundedRectangleBorder,
          child: Column(
            children: [
              Obx(() => Text(
                    DateFormat('EEEE, dd-MM-yyyy').format(DateTime.parse(
                        Get.find<DateTimeController>().requestedDate.value)),
                    style: AppStyle.mid_large_text.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: AppColor.cardColor),
                  )),
              customSpacerHeight(height: 12),
              Text(
                AppString.text_duration.tr,
                style: AppStyle.mid_large_text.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: AppColor.cardColor.withOpacity(0.9)),
              ),
              Text(
                dtsDuration,
                style: AppStyle.normal_text_grey.copyWith(
                    fontSize: Dimensions.fontSizeMid + 5,
                    fontWeight: FontWeight.w900,
                    color: AppColor.cardColor.withOpacity(0.9)),
              ),
              customSpacerHeight(height: 6),
              _statusBtn(
                status: dtsStatus,
                textColor: dtsBgColor,
              ),
              customSpacerHeight(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _verticalDivider(
                      height: 13, bgColor: AppColor.cardColor.withOpacity(0.3)),
                  customSpacerWidth(width: 30),
                  _verticalDivider(
                      height: 17, bgColor: AppColor.cardColor.withOpacity(0.5)),
                  customSpacerWidth(width: 30),
                  _verticalDivider(
                      height: 22, bgColor: AppColor.cardColor.withOpacity(0.7)),
                  customSpacerWidth(width: 30),
                  _verticalDivider(
                      height: 24, bgColor: AppColor.cardColor.withOpacity(0.9)),
                  customSpacerWidth(width: 30),
                  _verticalDivider(
                      height: 22, bgColor: AppColor.cardColor.withOpacity(0.7)),
                  customSpacerWidth(width: 30),
                  _verticalDivider(
                      height: 17, bgColor: AppColor.cardColor.withOpacity(0.5)),
                  customSpacerWidth(width: 30),
                  _verticalDivider(
                      height: 13, bgColor: AppColor.cardColor.withOpacity(0.3)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateDataFromApiResponse() {
    //sub string because of data format
    //date format "(data)"
    Get.find<DateTimeController>().requestedDate.value =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(
            startDateTime.substring(1, startDateTime.length - 1)));
    timelineLogDetailsDrcController.text =
        dtsDrc.substring(1, dtsDrc.length - 1);
    DateTime startTime =
    DateTime.parse(startDateTime.substring(1, startDateTime.length - 1));
    DateTime endTime =
    DateTime.parse(endDateTime.substring(1, endDateTime.length - 1));
    Get.find<DateTimeController>().pickedInTime.value =
    "${startTime.hour > 11 ? "${startTime.hour - 12}".padLeft(2, "0") : "${startTime.hour}".padLeft(2, "0")}:${startTime.minute.toString().padLeft(2, "0")}${startTime.hour > 11 ? "PM" : "AM"}";
    Get.find<DateTimeController>().pickedOutTime.value =
    "${endTime.hour > 11 ? "${endTime.hour - 12}".padLeft(2, "0") : "${endTime.hour}".padLeft(2, "0")}:${endTime.minute.toString().padLeft(2, "0")}${startTime.hour > 11 ? "PM" : "AM"}";

  }
}

_verticalDivider({required double height, required Color bgColor}) {
  return Container(
    height: height,
    width: 1,
    color: bgColor,
  );
}

_statusBtn({required status, required textColor}) {
  if (status == "rejected") {
    return statusBtn(text: AppString.text_rejected.tr, textColor: textColor);
  } else if (status == "pending") {
    return statusBtn(text: AppString.text_pendding.tr, textColor: textColor);
  } else if (status == "taken") {
    return Container();
  } else {
    return statusBtn(text: AppString.text_approved.tr, textColor: textColor);
  }
}

Widget statusBtn({required text, required textColor}) {
  return SizedBox(
    width: AppLayout.getWidth(106),
    height: AppLayout.getHeight(32),
    child: CustomStatusButton(
      textColor: textColor,
      bgColor: AppColor.cardColor.withOpacity(0.9),
      text: text,
    ),
  );
}

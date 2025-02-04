import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/employee_timeline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/global_timline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/hr_timeline_controller.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/widgets/time_sheet/timelog_summary_details.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/controllers/timelog_summary_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../app/global/view/widget/app_margin.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../utils/utils.dart';

class IndividualTimeLayout extends StatelessWidget {
  final bool isEmployee;
 final LogSummaryUserInfo ? logSummaryUserInfo;
  const IndividualTimeLayout({super.key, required this.isEmployee,this.logSummaryUserInfo});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      itemCount: Get.find<TimelineSummaryController>()
          .timelogDetailsByMonth
          ?.getDailyTimeEntries
          ?.data
          ?.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () async {
              /// call api according to given date
              /// change showing date by updating request date value

              DateTime requestedDate = DateTime.parse(
                  Get.find<TimelineSummaryController>()
                          .timelogDetailsByMonth
                          ?.getDailyTimeEntries
                          ?.data?[index]
                          .entryDay ??
                      DateTime.now().toString());

              if (isEmployee == true) {
                Get.find<TimelineGlobalController>().selectedTimeLineStartDate.value =
                    DateFormat('yyyy-MM-dd').format(requestedDate);

                Get.back(canPop: false);

                await Get.find<EmployeeTimelineController>().getTimelineCalenderByDate(
                    startDate:
                        "${DateTime(requestedDate.year, requestedDate.month, requestedDate.day, 0, 0, 0)}",
                    endDate:
                        "${DateTime(requestedDate.year, requestedDate.month, requestedDate.day, 23, 59, 59)}");

                await Get.find<EmployeeTimelineController>().getTimelineSummaryByDate(
                    startDate:
                        "${DateTime(requestedDate.year, requestedDate.month, requestedDate.day, 0, 0, 0)}",
                    endDate:
                        "${DateTime(requestedDate.year, requestedDate.month, requestedDate.day, 23, 59, 59)}");
              } else {

                _showLeaveRecordDetailsSheet(requestedDate);
              }
            },
            child: _infoTextLayout(index));
      },
    );
  }

  Widget _infoTextLayout(int index) {
    Color itemColor = index % 2 == 0
        ? AppColor.primaryColor.withOpacity(0.03)
        : Colors.transparent;
    return Padding(
      padding: marginLayout,
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder,
        color: itemColor,
        child: Padding(
          padding:
              marginLayout.copyWith(top: 10, bottom: 10, left: 10, right: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      DateTime.tryParse(Get.find<TimelineSummaryController>()
                                      .timelogDetailsByMonth
                                      ?.getDailyTimeEntries
                                      ?.data?[index]
                                      .entryDay ??
                                  "")
                              ?.day
                              .toString()
                              .padLeft(2) ??
                          "",
                      style: AppStyle.small_text_grey.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeMid)),
                  Text(
                    getDayName(Get.find<TimelineSummaryController>()
                            .timelogDetailsByMonth
                            ?.getDailyTimeEntries
                            ?.data?[index]
                            .entryDay ??
                        ""),
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault - 1),
                  ),
                ],
              ),
              const Spacer(),
              _divider(),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      getConvertSecondsToHours(
                          Get.find<TimelineSummaryController>()
                                  .timelogDetailsByMonth
                                  ?.getDailyTimeEntries
                                  ?.data?[index]
                                  .totalScheduledSeconds ??
                              ""),
                      style: AppStyle.small_text_grey.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeDefault)),
                  Text(
                    AppString.text_schedule.tr,
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault - 3),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              _getTimeLog(index),
                  Text(
                    AppString.text_logged.tr,
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault - 3),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      getConvertSecondsToHours(
                          Get.find<TimelineSummaryController>()
                                  .timelogDetailsByMonth
                                  ?.getDailyTimeEntries
                                  ?.data?[index]
                                  .totalLeavesSeconds ??
                              ""),
                      style: AppStyle.small_text_grey.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeDefault)),
                  Text(
                    AppString.text_paid_leave.tr,
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault - 3),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      getConvertSecondsToHours(
                          Get.find<TimelineSummaryController>()
                                  .timelogDetailsByMonth
                                  ?.getDailyTimeEntries
                                  ?.data?[index]
                                  .balance ??
                              ""),
                      style: AppStyle.small_text_grey.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeDefault)),
                  Text(
                    AppString.text_balance.tr,
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault - 3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLeaveRecordDetailsSheet(DateTime entryDate) {

    Get.find<HrTimelineController>().getTimeEntryDetails(
        startDate:
            "${DateTime(entryDate.year, entryDate.month, entryDate.day, 0, 0, 0)}",
        endDate:
            "${DateTime(entryDate.year, entryDate.month, entryDate.day, 23, 59, 59)}",
        orgUserId: Get.find<HrTimelineController>().orgUserId);

    showCustomBottomSheet(
      context: Get.context!,
      height: MediaQuery.of(Get.context!).size.height / 1.5,
      child:  TimeLogSummaryDetails(logSummaryUserInfo:logSummaryUserInfo ,),
    );
  }

  _divider() {
    return Container(
      width: 0.8,
      height: AppLayout.getHeight(30),
      color: AppColor.hintColor.withOpacity(0.6),
    );
  }

  String getWeekdayName(int? weekdayNumber) {
    switch (weekdayNumber) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  _getTimeLog(int index) {
    if( Get.find<TimelineSummaryController>()
        .timelogDetailsByMonth
        ?.getDailyTimeEntries
        ?.data?[index].isFlaggedTimelog==true){
      return  Row(
        children: [
          Text(
              getConvertSecondsToHours(
                  Get.find<TimelineSummaryController>()
                      .timelogDetailsByMonth
                      ?.getDailyTimeEntries
                      ?.data?[index]
                      .loggedTotalSeconds ??
                      ""),
              style: AppStyle.small_text_grey.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeDefault)),

          Icon(Icons.flag_outlined,color: AppColor.errorColor.withOpacity(0.7),size: 16,)
        ],
      );
    }else{
      return Text(
          getConvertSecondsToHours(
              Get.find<TimelineSummaryController>()
                  .timelogDetailsByMonth
                  ?.getDailyTimeEntries
                  ?.data?[index]
                  .loggedTotalSeconds ??
                  ""),
          style: AppStyle.small_text_grey.copyWith(
              color: AppColor.normalTextColor,
              fontSize: Dimensions.fontSizeDefault));
    }


  }
}

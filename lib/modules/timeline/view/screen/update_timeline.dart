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
import '../../../leave/view/widget/custom_title_text_widget.dart';
import '../../../leave/view/widget/single_date_picker_calendar.dart';
import '../../../leave/view/widget/timmer_text_field_dob.dart';
import '../../../starting/view/splash_screen.dart';


class UpdateTimeLineLog extends StatelessWidget {
  const UpdateTimeLineLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: timeLogAppbar(context),
      backgroundColor: Get.find<TimelineController>().timeLogColor,
      body: Padding(
        padding: marginLayout.copyWith(left: 0, right: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Padding(
                  padding: marginLayout,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customSpacerHeight(height: 24),
                      customTitleText(text: "${AppString.text_date.tr} *"),
                      customSpacerHeight(height: 8),
                      _dateLayoutField(),
                      customSpacerHeight(height: 8),
                      _dayScheduleLayout(),
                      customSpacerHeight(height: 20),
                      Obx(() => _timerLayout(context)),
                      customSpacerHeight(height: 20),
                      customTitleText(text: AppString.text_project_or_task.tr),
                      customSpacerHeight(height: 8),
                      _selectedTaskLayout(context),
                      customSpacerHeight(height: 20),
                      customTitleText(text: AppString.text_description.tr),
                      customSpacerHeight(height: 8),
                      InputNote(
                        controller: timelineLogDetailsDrcController,
                      ),
                      customSpacerHeight(height: 20),
                      _checkStatus()
                          ? Obx(() => Get.find<TimelineController>()
                                  .isUpdateTimeLogLoading
                                  .isTrue
                              ? const Center(
                                  child: CupertinoActivityIndicator(),
                                )
                              : CustomDoubleAppButton(
                                  buttonText: AppString.text_save.tr,
                                  onAction: () {
                                    Get.find<TimelineController>()
                                        .updateTimelineLogDetails(
                                      description:
                                          timelineLogDetailsDrcController.text,
                                      status: Get.find<TimelineController>()
                                          .timeLogStatus
                                          .toString(),
                                      projectId: "",
                                      startDate: Get.find<DateTimeController>()
                                                  .requestedInDate
                                                  .value
                                                  .length >
                                              10
                                          ? Get.find<DateTimeController>()
                                              .requestedInDate
                                              .value
                                          : DateFormat("yyyy-MM-dd hh:mma")
                                              .parse(
                                                  "${Get.find<DateTimeController>().requestedDate.value} ${Get.find<DateTimeController>().pickedInTime.value}")
                                              .toString(),
                                      endDate: Get.find<DateTimeController>()
                                                  .requestedOutDate
                                                  .value
                                                  .length >
                                              10
                                          ? Get.find<DateTimeController>()
                                              .requestedOutDate
                                              .value
                                          : DateFormat("yyyy-MM-dd hh:mma")
                                              .parse(
                                                  "${Get.find<DateTimeController>().requestedDate.value} ${Get.find<DateTimeController>().pickedOutTime.value}")
                                              .toString(),
                                      taskId: "",
                                      timeLineId: Get.find<TimelineController>()
                                          .timeLineID
                                          .toString(),
                                    );
                                  },
                                  cancelAction: () {
                                    Navigator.pop(context);
                                  }))
                          : Container(),
                      customSpacerHeight(height: 40)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _dateLayoutField() {
    return GestureDetector(
      onTap: () => showDialog(
        context: Get.context!,
        builder: (context) {
          return const Dialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              insetPadding: EdgeInsets.zero,
              child: SingleDatePicker(
                isCalledFormTimeLog: true,
              ));
        },
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: decorationStyle.copyWith(
                border: Border.all(width: .8, color: AppColor.hintColor),
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
            padding:
                marginLayout.copyWith(top: 14, bottom: 14, left: 14, right: 14),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      Get.find<DateTimeController>().requestedDate.value,
                      style: AppStyle.normal_text_grey,
                    ),
                  ),
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: AppColor.hintColor,
                  )
                ]),
          )
        ],
      ),
    );
  }

  _timerLayout(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customTitleText(text: AppString.text_set_start_time.tr),
        customSpacerHeight(height: 8),
        _newEntryStartTime(context: context),
        customSpacerHeight(height: 20),
        customTitleText(text: AppString.text_set_end_time.tr),
        customSpacerHeight(height: 8),
        _newEntryEndTime(context: context),
        customSpacerHeight(height: 8),
        Obx(() => _timeInvalidMessage()),
      ],
    );
  }

  _timeInvalidMessage() {
    return Get.find<TimelineController>().isTimeInvalid.isTrue
        ? Text(
            "**${AppString.inputTimeInvalidMessage}",
            style:
                AppStyle.small_text.copyWith(color: AppColor.errorColorLight),
          )
        : Container();
  }

  _dayScheduleLayout() {
    return SizedBox(
      height: AppLayout.getHeight(50),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.find<DateTimeController>().currentIndex.value = index;
              switch (index) {
                case 0:
                  Get.find<DateTimeController>().requestedDate.value =
                      DateFormat('yyyy-MM-dd').format(
                          DateTime.now().subtract(const Duration(days: 1)));
                  break;
                case 1:
                  Get.find<DateTimeController>().requestedDate.value =
                      DateFormat('yyyy-MM-dd').format(DateTime.now());
                  break;
                case 2:
                  Get.find<DateTimeController>().requestedDate.value =
                      DateFormat('yyyy-MM-dd')
                          .format(DateTime.now().add(const Duration(days: 1)));
                  break;
              }
            },
            child: Obx(() => SizedBox(
                  width: AppLayout.getWidth(127),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Card(
                      color:
                          Get.find<DateTimeController>().currentIndex.value ==
                                  index
                              ? AppColor.primaryColor.withOpacity(0.05)
                              : Colors.transparent,
                      shape: roundedRectangleBorder.copyWith(
                          side: BorderSide(
                              width: 1,
                              color: Get.find<DateTimeController>()
                                          .currentIndex
                                          .value ==
                                      index
                                  ? AppColor.primaryColor
                                  : AppColor.hintColor)),
                      elevation: 0,
                      child: Center(
                          child: Text(
                        selectedBeforeDayAndAfterDay[index],
                        style: AppStyle.mid_large_text.copyWith(
                            color: Get.find<DateTimeController>()
                                        .currentIndex
                                        .value ==
                                    index
                                ? AppColor.primaryColor
                                : AppColor.hintColor,
                            fontSize: Dimensions.fontSizeDefault),
                      )),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  _selectedTaskLayout(context) {
    return taskInputFieldLayout(
      onAction: () {
        customButtonSheet(
            context: context, height: .7, child: const TaskViewLayout());
      },
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
                Get.find<TimelineController>().timeLogDuration.toString(),
                style: AppStyle.normal_text_grey.copyWith(
                    fontSize: Dimensions.fontSizeMid + 5,
                    fontWeight: FontWeight.w900,
                    color: AppColor.cardColor.withOpacity(0.9)),
              ),
              customSpacerHeight(height: 6),
              _statusBtn(
                status: Get.find<TimelineController>().timeLogStatus,
                textColor: Get.find<TimelineController>().timeLogColor,
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

  _checkStatus() {
    return Get.find<TimelineController>().timeLogStatus != ("approved") &&
        Get.find<TimelineController>().timeLogStatus != ("reject") &&
        Get.find<TimelineController>().timeLogStatus != ("rejected") &&
        Get.find<TimelineController>().timeLogStatus != ("cancelled") &&
        Get.find<TimelineController>().timeLogStatus != ("taken");
  }
}

Widget _newEntryStartTime({required BuildContext context}) {
  return timerTextField(
    hintText: Get.find<DateTimeController>().pickedInTime.isEmpty
        ? AppString.text_select_time
        : Get.find<DateTimeController>().pickedInTime.value,
    dobIcon: Icons.access_time_outlined,
    dobIconAction: () {
      Get.find<DateTimeController>().isInTimeClicked.value = true;
      timePicker(context, false);
    },
  );
}

Widget _newEntryEndTime({required BuildContext context}) {
  return timerTextField(
    hintText: Get.find<DateTimeController>().pickedOutTime.isEmpty
        ? AppString.text_select_time
        : Get.find<DateTimeController>().pickedOutTime.value,
    dobIcon: Icons.access_time_outlined,
    dobIconAction: () {
      timePicker(context, false);
    },
  );
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
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
import '../../../../common/widget/custom_dialog.dart';
import '../../../../common/widget/timePicker/custom_time_picker_in_time.dart';
import '../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../leave/presentation/view/widget/custom_title_text_widget.dart';
import '../../../leave/presentation/view/widget/status_btn_widget.dart';
import '../../../leave/presentation/view/widget/timmer_text_field_dob.dart';
import '../../../starting/view/splash_screen.dart';
import 'duration_time_widget.dart';

class TimeLogEntryTextField extends StatelessWidget {
  final bool? isFromUpdateTimelogEntry;
  final String? status;

  const TimeLogEntryTextField({this.isFromUpdateTimelogEntry = false, this.status, super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<TimelineController>().isTimeInvalid(false);
    return Column(
      children: [
        durationTimeLayout(status: status),
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24), topRight: Radius.circular(24))),
          padding: marginLayout.copyWith(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSpacerHeight(height: 12),
              customTitleText(text: AppString.text_date.tr, isRequired: true),
              customSpacerHeight(height: 8),
              Obx(() => _dateLayoutField()),
              customSpacerHeight(height: 8),
              _dayScheduleLayout(),
              customSpacerHeight(height: 20),
              Obx(() => _timerLayout(context)),
              customSpacerHeight(height: 20),
              customTitleText(
                  text: AppString.text_project_or_task.tr, isRequired: true),
              customSpacerHeight(height: 8),
              _selectedTaskLayout(context),
              customSpacerHeight(height: 20),
              customTitleText(text: AppString.text_description.tr),
              customSpacerHeight(height: 8),
              InputNote(
                controller: descriptionController,
              ),
              customSpacerHeight(height: 20),
              status != null && status == "reject"
                  ? CustomAppButton(
                      isButtonExpanded: false,
                      buttonText: Text(AppString.text_remove.tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16)),
                      onPressed: () {
                        customDialog(
                            context: context,
                            saveBtnAction: () async {
                              Get.find<TimelineController>()
                                  .removeTimeEntry(
                                      timeLogId: Get.find<TimelineController>()
                                          .timeLineID)
                                  .then((value) {
                                if (value == true) {
                                  Navigator.pop(context);
                                }
                              });
                            },
                            icon: CupertinoIcons.delete,
                            titleText: AppString.text_remove_timelog.tr,
                            subText: AppString
                                .text_sure_you_want_to_delete_timelog.tr,
                            iconBgColor: AppColor.errorColorLight,
                            btnBgColor: AppColor.errorColorLight,
                            btnText: "",
                            drcText: "",
                            drcFontSize: Dimensions.fontSizeDefault,
                            childForSaveBtn: Obx(() => removeTextLayout()));
                      },
                      buttonColor: AppColor.errorColorLight)
                  : Get.find<TimelineController>()
                              .isManualEntryLoading
                              .isTrue ||
                          Get.find<TimelineController>()
                              .isUpdateTimeLogLoading
                              .isTrue
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : CustomDoubleAppButton(
                          buttonText: isFromUpdateTimelogEntry == true
                              ? AppString.text_save.tr
                              : AppString.text_add.tr,
                          btnColor: Get.find<TimelineController>()
                                      .isValueChangeForTimeLogUpdate
                                      .value ==
                                  true
                              ? AppColor.primaryColor
                              : AppColor.primaryColor.withOpacity(0.5),
                          onAction: Get.find<TimelineController>()
                                      .isValueChangeForTimeLogUpdate
                                      .value ==
                                  true
                              ? () {
                                  isFromUpdateTimelogEntry == true
                                      ? Get.find<TimelineController>()
                                          .updateTimelineLogDetails()
                                      : Get.find<TimelineController>()
                                          .createManualEntry();
                                }
                              : () {},
                          cancelAction: () {
                            Navigator.pop(context);
                          }),
              customSpacerHeight(height: 40)
            ],
          ),
        ),
      ],
    );
  }

  _dateLayoutField() {
    return GestureDetector(
      onTap: () => showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) => Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InDatePicker(),
              ],
            ),
          ),
        ),
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
                  Text(
                    DateFormat('yyyy-MM-dd').format(DateTime.parse(
                        Get.find<DateTimePickerController>().inDateTime.value)),
                    style: AppStyle.normal_text_grey,
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

  _timerLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customTitleText(
            text: AppString.text_set_start_time.tr, isRequired: true),
        customSpacerHeight(height: 8),
        _newEntryStartTime(context: context),
        customSpacerHeight(height: 20),
        customTitleText(text: AppString.text_set_end_time.tr, isRequired: true),
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
            "**${AppString.inputTimeInvalidMessage.tr}",
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
                  Get.find<DateTimePickerController>().inDate.value =
                      DateFormat('yyyy-MM-dd').format(
                          DateTime.now().subtract(const Duration(days: 1)));
                  Get.find<DateTimePickerController>().getInDateTime();
                  break;
                case 1:
                  Get.find<DateTimePickerController>().inDate.value =
                      DateFormat('yyyy-MM-dd').format(DateTime.now());
                  Get.find<DateTimePickerController>().getInDateTime();
                  break;
                case 2:
                  Get.find<DateTimePickerController>().inDate.value =
                      DateFormat('yyyy-MM-dd')
                          .format(DateTime.now().add(const Duration(days: 1)));
                  Get.find<DateTimePickerController>().getInDateTime();
                  break;
              }
            },
            child: Obx(() => SizedBox(
                  width: (Get.width - 40) / 3,
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
}

Widget _newEntryStartTime({required BuildContext context}) {
  return timerTextField(
    hintColor: Get.find<DateTimePickerController>().inTime.isEmpty
        ? AppColor.hintColor
        : AppColor.normalTextColor,
    hintText: Get.find<DateTimePickerController>().inTime.isEmpty
        ? AppString.text_select_time
        : Get.find<DateTimePickerController>().inTime.value,
    dobIcon: Icons.access_time_outlined,
    dobIconAction: () {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InTimePicker(),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class InTimePicker extends StatelessWidget {
  const InTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    String time = '';
    return Column(
      children: [
        CupertinoTimerPicker(
          initialTimerDuration: Duration(
              hours: int.parse(Get.find<DateTimePickerController>()
                  .inTime
                  .value
                  .substring(0, 2)),
              minutes: int.parse(Get.find<DateTimePickerController>()
                  .inTime
                  .value
                  .substring(3, 5))),
          mode: CupertinoTimerPickerMode.hm,
          backgroundColor: Colors.white,
          onTimerDurationChanged: (value) {
            time = value.toString();
          },
        ),
        const Divider(color: Colors.grey),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: SizedBox(
                width: 50,
                child: Text(AppString.text_cancel.tr),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 40),
            GestureDetector(
              child: SizedBox(width: 50, child: Text(AppString.text_ok.tr)),
              onTap: () {
                if (time.length < 15) {
                  if (Get.find<DateTimePickerController>().inTime.value !=
                      DateFormat('HH:mm').format(
                          DateTime.parse("2024-01-01 0${time.toString()}"))) {
                    Get.find<TimelineController>()
                        .isValueChangeForTimeLogUpdate(true);
                  }

                  Get.find<DateTimePickerController>().inTime.value =
                      DateFormat('HH:mm').format(
                          DateTime.parse("2024-01-01 0${time.toString()}"));
                } else {
                  if (Get.find<DateTimePickerController>().inTime.value !=
                      DateFormat('HH:mm').format(
                          DateTime.parse("2024-01-01 ${time.toString()}"))) {
                    Get.find<TimelineController>()
                        .isValueChangeForTimeLogUpdate(true);
                  }

                  Get.find<DateTimePickerController>().inTime.value =
                      DateFormat('HH:mm').format(
                          DateTime.parse("2024-01-01 ${time.toString()}"));
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class OutTimePicker extends StatelessWidget {
  const OutTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    String time = '';
    print(""""
    outTime: ${Get.find<DateTimePickerController>().outTime.value}
    hr:${int.parse(Get.find<DateTimePickerController>().outDate.value.substring(0, 2))}
        min: ${int.parse(Get.find<DateTimePickerController>().outTime.value.substring(3, 5))}
    """);
    return Column(
      children: [
        CupertinoTimerPicker(
          initialTimerDuration: Duration(
              hours: int.parse(Get.find<DateTimePickerController>()
                  .outDate
                  .value
                  .substring(0, 2)),
              minutes: int.parse(Get.find<DateTimePickerController>()
                  .outTime
                  .value
                  .substring(3, 5))),
          mode: CupertinoTimerPickerMode.hm,
          backgroundColor: Colors.white,
          onTimerDurationChanged: (value) {
            time = value.toString();
          },
        ),
        const Divider(color: Colors.grey),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: SizedBox(
                width: 50,
                child: Text(AppString.text_cancel.tr),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 40),
            GestureDetector(
              child: SizedBox(width: 50, child: Text(AppString.text_ok.tr)),
              onTap: () {
                if (time.isNotEmpty) {
                  // set time in 00:00:00 format
                  if (time.length < 15) {
                    if (Get.find<DateTimePickerController>().outTime.value !=
                        DateFormat('HH:mm').format(
                            DateTime.parse("2024-01-01 0${time.toString()}"))) {
                      Get.find<TimelineController>()
                          .isValueChangeForTimeLogUpdate(true);
                    }

                    Get.find<DateTimePickerController>().outTime.value =
                        DateFormat('HH:mm').format(
                            DateTime.parse("2024-01-01 0${time.toString()}"));
                  } else {
                    if (Get.find<DateTimePickerController>().outTime.value !=
                        DateFormat('HH:mm').format(
                            DateTime.parse("2024-01-01 ${time.toString()}"))) {
                      Get.find<TimelineController>()
                          .isValueChangeForTimeLogUpdate(true);
                    }

                    Get.find<DateTimePickerController>().outTime.value =
                        DateFormat('HH:mm').format(
                            DateTime.parse("2024-01-01 ${time.toString()}"));
                  }
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

Widget _newEntryEndTime({required BuildContext context}) {
  return timerTextField(
    hintColor: Get.find<DateTimePickerController>().outTime.isEmpty
        ? AppColor.hintColor
        : AppColor.normalTextColor,
    hintText: Get.find<DateTimePickerController>().outTime.isEmpty
        ? AppString.text_select_time
        : Get.find<DateTimePickerController>().outTime.value,
    dobIcon: Icons.access_time_outlined,
    dobIconAction: () {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutTimePicker(),
              ],
            ),
          ),
        ),
      );
    },
  );
}

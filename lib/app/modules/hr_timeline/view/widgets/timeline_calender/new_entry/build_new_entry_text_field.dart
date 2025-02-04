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
import 'package:payrun_mobile/modules/timeline/view/widget/task_field_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../../../../common/widget/custom_dialog.dart';
import '../../../../../../../common/widget/timePicker/custom_time_picker_in_time.dart';
import '../../../../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../../../global/view/custom_tabbar_with_search.dart';
import '../../../../../../global/view/widget/app_margin.dart';
import '../../../../../../global/view/widget/custom_app_title_text.dart';
import '../../../../../profile/controller/global_profile_controller.dart';
import '../../../../controllers/global_timline_controller.dart';
import '../../time_sheet/timelog_summary_details.dart';
import 'build_task_view.dart';
import 'new_entry_duration_time_with_status.dart';

class BuildNewEntryTextField extends StatelessWidget {
  final bool isEmployee;
  final bool? isFromUpdateTimelogEntry;
  final String? status;
  final LogSummaryUserInfo? logSummaryUserInfo;
  const BuildNewEntryTextField(
      {this.isFromUpdateTimelogEntry = false,
      this.status,
      required this.isEmployee,
      this.logSummaryUserInfo,
      super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<TimelineGlobalController>().isTimeInvalid(false);
    return SingleChildScrollView(
      child: Column(
        children: [
          newEntryDurationTime(status: status),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            padding: marginLayout.copyWith(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSpacerHeight(height: 12),
                IgnorePointer(
                    ignoring: isFromUpdateTimelogEntry == true ? true : false,
                    child: _buildEmployeeSearch(context)),
                customAppTitleText(
                    text: AppString.text_date.tr, isRequired: true),
                customSpacerHeight(height: 8),
                Obx(() => _dateLayoutField()),
                customSpacerHeight(height: 8),
                _dayScheduleLayout(),
                customSpacerHeight(height: 20),
                Obx(() => _timerLayout(context)),
                customSpacerHeight(height: 20),
                _buildStatus(),
                customAppTitleText(
                    text: AppString.text_project_or_task.tr, isRequired: true),
                customSpacerHeight(height: 8),
                _selectedTaskLayout(context),
                customSpacerHeight(height: 20),
                customAppTitleText(text: AppString.text_description.tr),
                customSpacerHeight(height: 8),
                InputNote(
                  controller: Get.find<TimelineGlobalController>()
                      .descriptionController,
                  onChanged: (value) {
                    if (value != null) {
                      Get.find<TimelineGlobalController>()
                          .isValueChangeForTimeLogUpdate(true);
                    }
                  },
                ),
                customSpacerHeight(height: 20),
                _buildButton(context),
                customSpacerHeight(height: 40)
              ],
            ),
          ),
        ],
      ),
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
            decoration: BoxDecoration(
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
        customAppTitleText(
            text: AppString.text_set_start_time.tr, isRequired: true),
        customSpacerHeight(height: 8),
        _newEntryStartTime(context: context),
        customSpacerHeight(height: 20),
        customAppTitleText(
            text: AppString.text_set_end_time.tr, isRequired: true),
        customSpacerHeight(height: 8),
        _newEntryEndTime(context: context),
        customSpacerHeight(height: 8),
        Obx(() => _timeInvalidMessage()),
      ],
    );
  }

  _timeInvalidMessage() {
    return Get.find<TimelineGlobalController>().isTimeInvalid.isTrue
        ? Text(
            AppString.inputTimeInvalidMessage.tr,
            style:
                AppStyle.small_text.copyWith(color: AppColor.errorColorLight),
          )
        : Container();
  }

  Widget _dayScheduleLayout() {
    final dateTimeController = Get.find<DateTimeController>();
    final dateTimePickerController = Get.find<DateTimePickerController>();
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
              dateTimeController.currentIndex.value = index;

              final currentDate = DateTime.now();
              switch (index) {
                case 0:
                  dateTimePickerController.inDate.value =
                      DateFormat('yyyy-MM-dd').format(
                          currentDate.subtract(const Duration(days: 1)));
                  break;
                case 1:
                  dateTimePickerController.inDate.value =
                      DateFormat('yyyy-MM-dd').format(currentDate);
                  break;
                case 2:
                  dateTimePickerController.inDate.value =
                      DateFormat('yyyy-MM-dd')
                          .format(currentDate.add(const Duration(days: 1)));
                  break;
              }
              dateTimePickerController.getInDateTime();
            },
            child: Obx(() {
              final isSelected = dateTimeController.currentIndex.value == index;

              return SizedBox(
                width: MediaQuery.sizeOf(context).width / 3.3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Card(
                    color: isSelected
                        ? AppColor.primaryColor.withOpacity(0.05)
                        : Colors.transparent,
                    shape: roundedRectangleBorder.copyWith(
                      side: BorderSide(
                        width: 1,
                        color: isSelected
                            ? AppColor.primaryColor
                            : AppColor.hintColor,
                      ),
                    ),
                    elevation: 0,
                    child: Center(
                      child: Text(
                        selectedBeforeDayAndAfterDay[index],
                        style: AppStyle.mid_large_text.copyWith(
                          color: isSelected
                              ? AppColor.primaryColor
                              : AppColor.hintColor,
                          fontSize: Dimensions.fontSizeDefault,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  _selectedTaskLayout(context) {
    return taskInputFieldLayout(
      onAction: () {
        customButtonSheet(
            context: context, height: .7, child: const BuildTaskView());
      },
    );
  }

  _buildButton(BuildContext context) {
    final timelineController = Get.find<TimelineGlobalController>();

    if (status == "reject") {
      return CustomAppButton(
        isButtonExpanded: false,
        buttonText: Text(
          AppString.text_remove.tr,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: () {
          _showRemoveTimeLogDialog(context, timelineController);
        },
        buttonColor: AppColor.errorColorLight,
      );
    }

    return Obx(() {
      if (timelineController.isManualEntryLoading.isTrue ||
          timelineController.isUpdateTimeLogLoading.isTrue) {
        return const Center(child: CupertinoActivityIndicator());
      }

      bool isValueChanged =
          timelineController.isValueChangeForTimeLogUpdate.value;

      return CustomDoubleAppButton(
        buttonText: isFromUpdateTimelogEntry == true
            ? AppString.text_save.tr
            : AppString.text_add.tr,
        btnColor: isValueChanged
            ? AppColor.primaryColor
            : AppColor.primaryColor.withOpacity(0.5),
        onAction: isValueChanged
            ? () {
                if (isFromUpdateTimelogEntry == true) {
                  if (isEmployee == true &&
                      status == "approved" &&
                      isFromUpdateTimelogEntry == true) {
                    timelineController.status.value = "";
                    timelineController.updateTimelineLogDetails();
                  } else {
                    timelineController.updateTimelineLogDetails();
                  }
                } else {
                  timelineController.createManualEntry();
                }
              }
            : () {},
        cancelAction: () {
          Navigator.pop(context);
        },
      );
    });
  }

  void _showRemoveTimeLogDialog(
      BuildContext context, TimelineGlobalController controller) {
    showCustomAlertDialog(
      context: context,
      onConfirm: () async {
        final result = await controller.removeTimelineEntry();
        if (result == true) {
          Navigator.pop(context);
        }
      },
      iconData: CupertinoIcons.delete,
      titleText: AppString.text_remove_timelog.tr,
      descriptionText: AppString.text_sure_you_want_to_delete_timelog.tr,
      iconBackgroundColor: AppColor.errorColorLight,
      confirmButtonColor: AppColor.errorColorLight,
      confirmButtonText: "",
      extraInfoText: "",
      descriptionFontSize: Dimensions.fontSizeDefault,
      confirmButtonChild: Obx(() => _removeTextLayout()),
    );
  }

  _employeeSearch(BuildContext context) {
    // Set selected employee info
    return CustomSearchBar(
      employeeName:
          "${Get.find<ProfileGlobalController>().employeeName.value} (You)",
      employeeImage: Get.find<ProfileGlobalController>().employeeImeKey.value,
      onValueSelected: (String orgId) async {
        Navigator.pop(context);
        Get.find<TimelineGlobalController>().orgUserId(orgId);
      },
      onClearAction: () async {
        Get.find<TimelineGlobalController>().orgUserId.value = "";
      },
    );
  }

  _employeeSearchLogSummary(BuildContext context,
      [LogSummaryUserInfo? logSummaryUserInfo]) {
    return IgnorePointer(
      ignoring: true,
      child: CustomSearchBar(
        employeeName: logSummaryUserInfo?.name ?? "",
        employeeImage: logSummaryUserInfo?.imgUrl ?? "",
        onValueSelected: (String orgId) async {
          Navigator.pop(context);
          Get.find<TimelineGlobalController>().orgUserId(orgId);
        },
        onClearAction: () async {
          Get.find<TimelineGlobalController>().orgUserId.value = "";
        },
      ),
    );
  }

  /// Builds a horizontal tab selector for leave status options.
  Widget _buildStatusTabSelector() {
    RxInt selectedStatusIndex = 0.obs;

    if (isFromUpdateTimelogEntry == true) {
      status == "pending" ? selectedStatusIndex(0) : selectedStatusIndex(1);
    }

    final List<String> statusOptions = ["Pending", "Approved"];

    return SizedBox(
      height: AppLayout.getHeight(44),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(4),
          border:
              Border.all(width: 1, color: AppColor.hintColor.withOpacity(0.5)),
        ),
        child: ListView.builder(
          itemCount: statusOptions.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Obx(() {
              // Checks if the current index is selected.
              final isSelected = index == selectedStatusIndex.value;
              return GestureDetector(
                onTap: () {
                  selectedStatusIndex.value = index;
                  Get.find<TimelineGlobalController>().status(
                      selectedStatusIndex.value == 0 ? "pending" : "approved");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? selectedStatusIndex.value == 0
                            ? AppColor.pendingColor
                            : AppColor.successColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    statusOptions[index],
                    style: AppStyle.normal_text.copyWith(
                      color:
                          isSelected ? AppColor.cardColor : AppColor.hintColor,
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  _buildStatus() {
    if (isEmployee == false) {
      return Column(
        children: [
          customAppTitleText(text: AppString.text_status.tr, isRequired: true),
          customSpacerHeight(height: 8),
          _buildStatusTabSelector(),
          customSpacerHeight(height: 20),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildEmployeeSearch(BuildContext context) {
    if (isEmployee == false) {
      return Column(
        children: [
          if (logSummaryUserInfo != null)
            _employeeSearchLogSummary(context, logSummaryUserInfo)
          else
            _employeeSearch(context),
          customSpacerHeight(height: 20),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

Widget _newEntryStartTime({required BuildContext context}) {
  return buildTimerTextField(
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
                _InTimePicker(),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _newEntryEndTime({required BuildContext context}) {
  return buildTimerTextField(
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
                _OutTimePicker(),
              ],
            ),
          ),
        ),
      );
    },
  );
}

_removeTextLayout() {
  return Get.find<TimelineGlobalController>()
          .isTimelogEntryOrRemoveLoading
          .value
      ? const CupertinoActivityIndicator(
          color: AppColor.cardColor,
        )
      : Text(
          AppString.text_remove.tr,
          style: AppStyle.normal_text_grey.copyWith(
              fontSize: Dimensions.fontSizeDefault + 1,
              color: AppColor.cardColor),
        );
}

Widget buildTimerTextField(
    {required String hintText,
    required IconData dobIcon,
    dobIconAction,
    Color? hintColor}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
    child: TextField(
      readOnly: true,
      onTap: () => dobIconAction(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: hintText,
        focusColor: AppColor.primaryColor,
        hintStyle: AppStyle.mid_large_text.copyWith(
            color: hintColor ?? AppColor.hintColor,
            fontSize: Dimensions.fontSizeDefault),
        filled: false,
        fillColor: AppColor.backgroundColor,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.solidGray),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.hintColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.0, color: AppColor.hintColor),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        suffixIcon: IconButton(
          onPressed: () => dobIconAction(),
          icon: Icon(
            dobIcon,
            size: 27,
            color: AppColor.hintColor.withOpacity(0.9),
          ),
        ),
      ),
    ),
  );
}

class _InTimePicker extends StatelessWidget {
  const _InTimePicker({super.key});

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
                    Get.find<TimelineGlobalController>()
                        .isValueChangeForTimeLogUpdate(true);
                  }

                  Get.find<DateTimePickerController>().inTime.value =
                      DateFormat('HH:mm').format(
                          DateTime.parse("2024-01-01 0${time.toString()}"));
                } else {
                  if (Get.find<DateTimePickerController>().inTime.value !=
                      DateFormat('HH:mm').format(
                          DateTime.parse("2024-01-01 ${time.toString()}"))) {
                    Get.find<TimelineGlobalController>()
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

class _OutTimePicker extends StatelessWidget {
  const _OutTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    String time = '';
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
                      Get.find<TimelineGlobalController>()
                          .isValueChangeForTimeLogUpdate(true);
                    }

                    Get.find<DateTimePickerController>().outTime.value =
                        DateFormat('HH:mm').format(
                            DateTime.parse("2024-01-01 0${time.toString()}"));
                  } else {
                    if (Get.find<DateTimePickerController>().outTime.value !=
                        DateFormat('HH:mm').format(
                            DateTime.parse("2024-01-01 ${time.toString()}"))) {
                      Get.find<TimelineGlobalController>()
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

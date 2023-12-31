import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/controller/date_time_helper_controller.dart';
import 'package:payrun_mobile/common/controller/timer_picker.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_field_widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/task_view_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../leave/view/widget/custom_title_text_widget.dart';
import '../../../leave/view/widget/single_date_picker_calendar.dart';
import '../../../leave/view/widget/timmer_text_field_dob.dart';
import '../../../starting/view/splash_screen.dart';
import 'duration_time_widget.dart';

class NewEntryTextField extends StatelessWidget {
  NewEntryTextField({super.key});
  final currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: marginLayout,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          durationTimeLayout(bgColor: AppColor.primaryColor.withOpacity(0.04)),
          customSpacerHeight(height: 12),
          Obx(() => _timerLayout(context)),
          customSpacerHeight(height: 20),
          customTitleText(text: "${AppString.text_date.tr} *"),
          customSpacerHeight(height: 8),
          Obx(() => _dateLayoutField()),
          customSpacerHeight(height: 8),
          _dayScheduleLayout(),
          customSpacerHeight(height: 20),
          customTitleText(text: AppString.text_project_or_task.tr),
          customSpacerHeight(height: 8),
          Obx(() => _selectedTaskLayout(context)),
          customSpacerHeight(height: 20),
          customTitleText(text: AppString.text_description.tr),
          customSpacerHeight(height: 8),
          InputNote(
            controller: descriptionController,
          ),
          customSpacerHeight(height: 20),
          CustomDoubleAppButton(
              buttonText: AppString.text_add.tr,
              onAction: () {},
              cancelAction: () {
                Navigator.pop(context);
              }),
          customSpacerHeight(height: 40)
        ],
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
              child: SingleDatePicker());
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
                  Text(
                    Get.find<DateTimeController>().requestedDate.value,
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
      ],
    );
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
              currentIndex.value = index;
            },
            child: Obx(() => SizedBox(
                  width: AppLayout.getWidth(127),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Card(
                      color: currentIndex.value == index
                          ? AppColor.primaryColor.withOpacity(0.05)
                          : Colors.transparent,
                      shape: roundedRectangleBorder.copyWith(
                          side: BorderSide(
                              width: 1,
                              color: currentIndex.value == index
                                  ? AppColor.primaryColor
                                  : AppColor.hintColor)),
                      elevation: 0,
                      child: Center(
                          child: Text(
                        selectedBeforeDayAndAfterDay[index],
                        style: AppStyle.mid_large_text.copyWith(
                            color: currentIndex.value == index
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
    return taskInputFieldLayout(onAction: () {
      customButtonSheet(
          context: context, height: .7, child: const TaskViewLayout());
    });
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
      timePicker(context);
    },
  );
}

Widget _newEntryEndTime({required BuildContext context}) {
  return timerTextField(
    hintText: Get.find<DateTimeController>().pickedInTime.isEmpty
        ? AppString.text_select_time
        : Get.find<DateTimeController>().pickedInTime.value,
    dobIcon: Icons.access_time_outlined,
    dobIconAction: () {
      Get.find<DateTimeController>().isInTimeClicked.value = true;
      timePicker(context);
    },
  );
}

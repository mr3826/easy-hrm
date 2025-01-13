import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/model/user_profile.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timeline_calendar.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';
import 'department_history.dart';

Widget departmentLayout(BuildContext? context) {
  return SizedBox(
    height: AppLayout.getHeight(289),
    child: Card(
      elevation: 0,
      shape: roundedRectangleBorder,
      color: AppColor.bgColorWithPrimary.withOpacity(0.3),
      child: Padding(
        padding: marginLayout.copyWith(top: 12, bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSvgImage(
                imageUrl: Images.departmentNotification,
                color: AppColor.primaryColor,
                height: 25,
                width: 25),
            customSpacerHeight(height: 12),
            _departmentHistoryInfo(context),
            customSpacerHeight(height: 12),
            _workingShiftLayout(context),
          ],
        ),
      ),
    ),
  );
}

_departmentHistoryInfo(context) {
  Department? department = Get.find<UserProfileController>()
      .userDetails
      ?.getOrganizationUserDetails
      ?.department;

  return GestureDetector(
    onTap: () {
      Get.find<UserProfileController>().getEmploymentInfo();
      customAntButtonSheet(context: context, child: const DepartmentHistory());
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          department?.name ?? "",
          style:
              AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor),
        ),
        Row(
          children: [
            _parentDepartmentInfo(parentDepartmentName: _getParentDepartmentName()),
            if (department != null)
              Expanded(
                child: Text(
                  "${AppString.text_from.tr} - ${getDateTimeFormat("")}",///todo [query]
                  style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.hintColor,
                      fontSize: Dimensions.fontSizeDefault - 1,
                      overflow: TextOverflow.ellipsis),
                ),
              )
          ],
        ),
      ],
    ),
  );
}

getDateTimeFormat(dateString) {
  if (dateString.isEmpty) return "";
  DateTime dateTime = DateTime.parse(dateString);
  // Format the DateTime to "dd, MMM"
  return DateFormat('dd MMM, yyyy').format(dateTime);
}

_parentDepartmentInfo({required String parentDepartmentName}) {
  return Row(
    children: [
      Text(
        parentDepartmentName,
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.primaryColor,
            fontSize: Dimensions.fontSizeDefault - 1),
      ),
      if (parentDepartmentName.isNotEmpty) _divider(),
    ],
  );
}

_workingShiftLayout(context) {
  return Expanded(
    child: Row(
      children: [
        _verticalDivider(),
        customSpacerWidth(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Get.find<UserProfileController>()
                  .userDetails
                  ?.getOrganizationUserDetails
                  ?.department
                  ?.workShift
                  ?.name ??
                  "",
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            ),
            _workShiftDetailsLayout(),
            customSpacerHeight(height: 8),
            Text(
              AppString.text_working_day.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: Dimensions.fontSizeDefault + 1),
            ),
            _workingDaySchedule(context)
          ],
        ),
      ],
    ),
  );
}




getDateTimeFormat(dateString){
  if(dateString.isEmpty) return"";
  DateTime dateTime = DateTime.parse(dateString);
  // Format the DateTime to "dd, MMM"
  return DateFormat('dd MMM, yyyy').format(dateTime);
}

_parentDepartmentInfo({required String parentDepartmentName}) {
  return Row(
    children: [
      Text(
        parentDepartmentName,
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.primaryColor,
            fontSize: Dimensions.fontSizeDefault - 1),
      ),
      if (parentDepartmentName.isNotEmpty) _divider(),
    ],
  );
}


_verticalDivider() {
  return Container(
    width: 1,
    height: double.infinity,
    color: AppColor.hintColor.withOpacity(0.4),
  );
}

_workShiftDetailsLayout() {
  // Check if schedule has some holiday same for each item
  List<WorkSchedules>? workSchedules = Get.find<UserProfileController>()
      .userDetails
      ?.getOrganizationUserDetails
      ?.department
      ?.workShift
      ?.workSchedules
      ?.where((element) => element.isHoliday == false)
      .map((e) => e)
      .toList();

  bool? allTimesSame = workSchedules?.every((schedule) {
    // Check if start_time and end_time are the same for each item
    return schedule.startTime == workSchedules[0].startTime &&
        schedule.endTime == workSchedules[0].endTime;
  });


  return Row(
    children: [
      Text(
        allTimesSame == true
            ? "${amPmFormatTimeFromString(workSchedules?[0].startTime ?? "")} - ${amPmFormatTimeFromString(workSchedules?[0].endTime ?? "")}"
            : AppString.text_variable_time.tr,
        style: allTimesSame == true
            ? AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor.withOpacity(0.7),
                fontSize: Dimensions.fontSizeDefault + 1)
            : AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault + 1,
                overflow: TextOverflow.ellipsis),
      ),
      _divider(),
      GestureDetector(
        onTap: () {
          //only diff time schedule, not same
          //value is false
          //same time value return true, not need to click then

          if (allTimesSame == false) {
            customAntButtonSheet(
                context: Get.context!,
                child: _generateWorkShift(workSchedules!));
          }
        },
        child: Text(
          allTimesSame == true
              ? getTimeDifference(workSchedules?[0].startTime ?? "",
                  workSchedules?[0].endTime ?? "")
              : AppString.text_see_details,
          style: allTimesSame == true
              ? AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 1)
              : AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: Dimensions.fontSizeDefault - 1,
                  overflow: TextOverflow.ellipsis),
        ),
      )
    ],
  );
}

_generateWorkShift(List<WorkSchedules> workSchedules) {
  return Column(
    children: [
      customButtonSheetAppbar(text: AppString.workShiftText.tr),
      Expanded(
          child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => customSpacerHeight(height: 10),
        itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color:
                    index.isEven ? Colors.grey.shade200 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Start: ${amPmFormatTimeFromString(workSchedules[index].startTime ?? "")}"),
                Text(
                    "End: ${amPmFormatTimeFromString(workSchedules[index].endTime ?? "")}"),
                Text(
                    "Total: ${getTimeDifference(workSchedules[index].startTime ?? "", workSchedules[index].endTime ?? "")}"),
              ],
            )),
        itemCount: workSchedules.length,
      ))
    ],
  );
}

_workingDaySchedule(context) {
  return SizedBox(
    height: AppLayout.getHeight(76),
    width: MediaQuery.of(context).size.width / 1.5,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: Get.find<UserProfileController>()
          .userDetails
          ?.getOrganizationUserDetails
          ?.department
          ?.workShift
          ?.workSchedules
          ?.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 0.0, right: 30, top: 12, bottom: 12),
          child: Column(
            children: [
              customSpacerWidth(width: 8),
              Text(
                getDayAbbreviation(Get.find<UserProfileController>()
                        .userDetails
                        ?.getOrganizationUserDetails
                        ?.department
                        ?.workShift
                        ?.workSchedules?[index]
                        .day ??
                    ""),
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeDefault,
                    overflow: TextOverflow.ellipsis),
              ),
              Get.find<UserProfileController>()
                          .userDetails
                          ?.getOrganizationUserDetails
                          ?.department
                          ?.workShift
                          ?.workSchedules?[index]
                          .isHoliday ==
                      true
                  ? const Icon(
                      Icons.close,
                      color: AppColor.errorColor,
                    )
                  : const Icon(
                      Icons.done,
                      color: AppColor.successColor,
                    ),
            ],
          ),
        );
      },
    ),
  );
}

String _getParentDepartmentName() {
  var parent = Get.find<UserProfileController>()
      .userDetails
      ?.getOrganizationUserDetails
      ?.department
      ?.parent;
  if (parent != null) {
    return "${AppString.text_child_of_deparmtnet.tr} ${parent.name ?? ""}";
  } else {
    return "";
  }
}

_divider() {
  return Padding(
    padding: marginLayout.copyWith(left: 8, right: 8),
    child: Container(width: 1, height: 12, color: AppColor.hintColor),
  );
}

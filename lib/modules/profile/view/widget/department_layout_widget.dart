import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/model/user_profile.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';

import 'department_history.dart';

Widget departmentLayout(context) {
  return SizedBox(
    height: AppLayout.getHeight(289),
    child: Card(
      elevation: 0,
      shape: roundedRectangleBorder,
      color: AppColor.primaryColor.withOpacity(0.05),
      child: Padding(
        padding: marginLayout.copyWith(top: 12, bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSvgImage(
                imageUrl: Images.department_notification,
                color: AppColor.primaryColor,
                height: 25,
                width: 25),
            customSpacerHeight(height: 12),
            Text(
              Get.find<UserProfileController>()
                      .userDetails
                      ?.getOrganizationUserDetails
                      ?.department
                      ?.name ??
                  "",
              style: AppStyle.mid_large_text
                  .copyWith(color: AppColor.normalTextColor),
            ),
            Row(
              children: [
                Text(
                  "${AppString.text_child_of_deparmtnet.tr} ${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.department?.parent?.name ?? ""}",
                  style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.secondaryColor,
                      fontSize: Dimensions.fontSizeDefault - 1),
                ),
                _divider(),
                Expanded(
                    child: Text(
                  "${AppString.text_from.tr} - ${dateMonthYearFormatFromDatetime(Get.find<UserProfileController>().employeeWorkHistory?.getOrganizationUserHistory?.employmentHistories?[0].startDate ?? "")}",
                  style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.hintColor,
                      fontSize: Dimensions.fontSizeDefault - 1,
                      overflow: TextOverflow.ellipsis),
                ))
              ],
            ),
            _workingShiftLayout(context),
          ],
        ),
      ),
    ),
  );
}

_workingShiftLayout(context) {
  return Expanded(
    child: Padding(
      padding: marginLayout.copyWith(left: 2, top: 12),
      child: Row(
        children: [
          Container(
            width: 1,
            height: double.infinity,
            color: AppColor.hintColor.withOpacity(0.4),
          ),
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
                "Working day",
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor.withOpacity(0.7),
                    fontSize: Dimensions.fontSizeDefault + 1),
              ),
              _workingDaySchedule(context)
            ],
          ),
        ],
      ),
    ),
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
    return schedule.startTime == workSchedules?[0].startTime &&
        schedule.endTime == workSchedules?[0].endTime;
  });

  return Row(
    children: [
      Text(
        allTimesSame == true
            ? "${amPmFormatTimeFromString(Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.department?.workShift?.workSchedules?[0].startTime ?? "")} - ${amPmFormatTimeFromString(Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.department?.workShift?.workSchedules?[0].endTime ?? "")}"
            : AppString.text_variable_time.tr,
        style: allTimesSame == true
            ? AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor.withOpacity(0.7),
                fontSize: Dimensions.fontSizeDefault + 1)
            : AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault + 1),
      ),
      _divider(),
      GestureDetector(
        onTap: () {
          //only diff time schedule, not same
          //value is false
          //same time value return true, not need to click then

          if (allTimesSame == false) {
            customButtonSheet(
                height: .6,
                context: Get.context!,
                child: _generateWorkShift(workSchedules!));
          }
        },
        child: Text(
          allTimesSame == true
              ? getTimeDifference(
                  Get.find<UserProfileController>()
                          .userDetails
                          ?.getOrganizationUserDetails
                          ?.department
                          ?.workShift
                          ?.workSchedules?[0]
                          .startTime ??
                      "",
                  Get.find<UserProfileController>()
                          .userDetails
                          ?.getOrganizationUserDetails
                          ?.department
                          ?.workShift
                          ?.workSchedules?[0]
                          .endTime ??
                      "")
              : AppString.text_see_details,
          style: allTimesSame == true
              ? AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 1)
              : AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: Dimensions.fontSizeDefault - 1),
        ),
      )
    ],
  );
}

_generateWorkShift(List<WorkSchedules> workSchedules) {
  return ListView.separated(
    separatorBuilder: (context, index) => customSpacerHeight(height: 10),
    itemBuilder: (context, index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: index.isEven ? Colors.grey.shade200 : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "Start: ${amPmFormatTimeFromString(workSchedules?[index].startTime ?? "")}"),
            Text(
                "End: ${amPmFormatTimeFromString(workSchedules?[index].endTime ?? "")}"),
            Text(
                "Total: ${getTimeDifference(workSchedules?[index].startTime ?? "", workSchedules?[index].endTime ?? "")}"),
          ],
        )),
    itemCount: workSchedules.length,
  );
}

_workingDaySchedule(context) {
  List<String?>? day = Get.find<UserProfileController>()
      .userDetails
      ?.getOrganizationUserDetails
      ?.department
      ?.workShift
      ?.workSchedules
      ?.where((element) => element.startTime != null)
      .map((e) => e.day?.substring(0, 3).capitalizeFirst)
      .toList();

  return SizedBox(
    height: AppLayout.getHeight(76),
    width: MediaQuery.of(context).size.width / 1.5,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: day?.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, right: 30, top: 12, bottom: 12),
              child: Column(
                children: [
                  customSpacerWidth(width: 8),
                  Text(
                    day?[index] ?? "",
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.normalTextColor,
                        fontSize: Dimensions.fontSizeDefault,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const Icon(
                    Icons.done,
                    color: AppColor.successColor,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}

_divider() {
  return Padding(
    padding: marginLayout.copyWith(left: 8, right: 8),
    child: Container(
      width: 1,
      height: 12,
      color: AppColor.hintColor,
    ),
  );
}

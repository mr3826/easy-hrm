import 'dart:developer';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/employee/presentation/controller/employment_controller.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/profile/model/user_profile.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../../common/widget/employee/custom_contact_info.dart';
import '../../../../../../../../modules/profile/view/widget/expanded_text_layout.dart';
import '../../../../../../../../modules/timeline/view/widget/timeline_calendar.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/images.dart';

import 'department/department_history.dart';
import 'department/department_layout.dart';
import 'designation/employee_designation_history.dart';
import 'designation/employee_designation_layout.dart';
import 'designation/employee_status_history.dart';

/// A widget that displays an overview of an employee's profile,
/// including descriptions, contact information, department,
/// and designation details.
class OverviewWidget extends GetView<EmploymentController> {
  const OverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDescription(),
            customSpacerHeight(height: 15),
            ..._createContactInfoWidgets(),
            customSpacerHeight(height: 15),
            _buildDepartment(context),
            customSpacerHeight(height: 4),
            _buildDesignation(context),
          ],
        ),
      ),
    );
  }

  /// Builds a description section for the employee profile.
  _buildDescription() {
    return ExpandedText(
        text: Get.find<EmploymentController>()
                .employeeProfileInfo
                ?.getOrganizationUserDetails
                ?.profile
                ?.about ??
            "");
  }

  /// Builds the department information section for the employee.
  _buildDepartment(BuildContext context) {
    return DepartmentLayout(
      departmentModel: DepartmentModel(
          departmentName: controller.employeeProfileInfo
                  ?.getOrganizationUserDetails?.department?.name ??
              "",
          parentDepartmentName: controller.employeeProfileInfo
                      ?.getOrganizationUserDetails?.department?.parent !=
                  null
              ? "${AppString.text_child_of_deparmtnet.tr} ${controller.employeeProfileInfo?.getOrganizationUserDetails?.department?.parent}"
              : null,
          workShiftStartTime: _getShiftTime("startTime") ?? "00:00:00",
          workShiftEndTime: _getShiftTime("endTime") ?? "17:00:00",
          workShiftName: controller.employeeProfileInfo
                  ?.getOrganizationUserDetails?.department?.workShift?.name ??
              "",
          startDate: controller.employeeWorkHistory?.getOrganizationUserHistory
                  ?.employmentHistories?.last.startDate ??
              "",
          workingDays: _getWorkSchedules(),
          onAction: () {
            customAntButtonSheet(
                context: context, child: const DepartmentHistoryForEmployee());
          }),
    );
  }

  /// Builds the designation information section for the employee,
  /// displaying the current job title and employment status.
  _buildDesignation(BuildContext context) {
    return Row(
      children: [
        controller.employeeWorkHistory?.getOrganizationUserHistory
                        ?.designationHistories !=
                    null &&
                controller.employeeWorkHistory!.getOrganizationUserHistory!
                    .designationHistories!.isNotEmpty
            ? Expanded(
                child: EmployeeStatusCard(
                  titleText: controller
                          .employeeWorkHistory
                          ?.getOrganizationUserHistory
                          ?.designationHistories
                          ?.first
                          .designation
                          ?.name ??
                      "",
                  date: controller
                          .employeeWorkHistory
                          ?.getOrganizationUserHistory
                          ?.designationHistories
                          ?.first
                          .startDate ??
                      "",
                  onAction: () {
                    customAntButtonSheet(
                      child: const DesignationHistoryLayout(),
                      context: context,
                    );
                  },
                ),
              )
            : const SizedBox.shrink(),
        Expanded(
          child: EmployeeStatusCard(
            titleText: _getUserEmploymentStatus(controller
                .employeeWorkHistory
                ?.getOrganizationUserHistory
                ?.employmentHistories
                ?.first
                .employmentStatus
                ?.name),
            date: controller.employeeWorkHistory?.getOrganizationUserHistory
                    ?.employmentHistories?.first.startDate ??
                "",
            sVGImg: Images.FLAG,
            onAction: () {
              customAntButtonSheet(
                child: const EmploymentHistoryLayout(),
                context: context,
              );
            },
          ),
        ),
      ],
    );
  }

  /// Creates a list of contact information widgets for the employee,
  /// including email, phone, and address.
  List<Widget> _createContactInfoWidgets() {
    GetOrganizationUserDetails? organizationUserDetails =
        Get.find<EmploymentController>()
            .employeeProfileInfo
            ?.getOrganizationUserDetails;
    final sectionTitles = [
      AppString.text_email.tr,
      AppString.text_phone.tr,
      AppString.text_address.tr,
    ];

    final dynamicTexts = [
      organizationUserDetails?.user?.email ?? "",
      organizationUserDetails?.profile?.personalNumber ?? "",
      organizationUserDetails?.profile?.address ?? "",
    ];

    return List<Widget>.generate(sectionTitles.length, (index) {
      return CustomContactInfoWidget(
        staticText: sectionTitles[index],
        dynamicText: dynamicTexts[index],
      );
    });
  }

  String? _getShiftTime(String timeType) {
    try {
      // Fetch work schedules excluding holidays
      List<WorkSchedules>? workSchedules = Get.find<EmploymentController>()
          .employeeProfileInfo
          ?.getOrganizationUserDetails
          ?.department
          ?.workShift
          ?.workSchedules
          ?.where((element) => !element.isHoliday!)
          .toList();

      // Ensure the list is not empty
      if (workSchedules == null || workSchedules.isEmpty) {
        return null;
      }

      // Dynamically get the first time based on `timeType`
      String? firstTime = timeType == "startTime"
          ? workSchedules.first.startTime
          : workSchedules.first.endTime;

      // Check if all times are the same
      bool allSame = workSchedules.every((schedule) {
        String? current =
            timeType == "startTime" ? schedule.startTime : schedule.endTime;
        return current == firstTime;
      });

      // Return the first time if all are the same
      return allSame ? firstTime : null;
    } catch (e) {
      log("_getShiftTime($timeType): $e");
    }
    return null;
  }

  List<Map<String, dynamic>> _getWorkSchedules() {
    return controller.employeeProfileInfo?.getOrganizationUserDetails
            ?.department?.workShift?.workSchedules
            ?.map((element) {
          return {
            "day": element.day ?? "",
            "holiday": element.isHoliday ?? false,
          };
        }).toList() ??
        [];
  }

  String _getUserEmploymentStatus(String? employmentStatus) {
    if (employmentStatus == null) return "";

    return employmentStatus.contains("Permanent")
        ? "Permanent Employee"
        : employmentStatus;
  }
}

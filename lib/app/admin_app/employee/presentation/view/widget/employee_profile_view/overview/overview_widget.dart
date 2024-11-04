import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
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
class OverviewWidget extends StatelessWidget {
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
    return const ExpandedText(
      text:
      "Publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface ",
    );
  }

  /// Builds the department information section for the employee.
   _buildDepartment(BuildContext context) {
    return DepartmentLayout(
      departmentModel: DepartmentModel(
          departmentName: "Laravel Department",
          parentDepartmentName:
          "${AppString.text_child_of_deparmtnet.tr} Main department",
          workShiftStartTime: "09:00:00",
          workShiftEndTime: "17:00:00",
          workShiftName: "Regular Worksheet",
          startDate: "2021-10-09 15:15:58",
          workingDays: const [
            {"day": "friday", "holiday": true},
            {"day": "saturday", "holiday": true},
            {"day": "sunday", "holiday": false},
            {"day": "monday", "holiday": false},
            {"day": "tuesday", "holiday": false},
            {"day": "wednesday", "holiday": false},
            {"day": "thursday", "holiday": false},
          ],
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
        Expanded(
          child: EmployeeStatusCard(
            titleText: 'Jr.\nDeveloper',
            date: "01 jan 2001",
            onAction: () {
              customAntButtonSheet(
                child: const DesignationHistoryLayout(),
                context: context,
              );
            },
          ),
        ),
        Expanded(
          child: EmployeeStatusCard(
            titleText: 'Permanent\nEmployee',
            date: "01 jan 2001",
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
    final sectionTitles = [
      AppString.text_email.tr,
      AppString.text_phone.tr,
      AppString.text_address.tr,
    ];

    final dynamicTexts = [
      "",
      "",
      "",
      "",
    ];

    return List<Widget>.generate(sectionTitles.length, (index) {
      return CustomContactInfoWidget(
        staticText: sectionTitles[index],
        dynamicText: dynamicTexts[index],
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../../modules/leave/presentation/view/widget/custom_title_text_widget.dart';
import '../../../../../../../utils/app_string.dart';


class AssignLeaveView extends StatelessWidget {
  const AssignLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildBottomSheetHeader(),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTitleText(AppString.textEmployees.tr),
                  const SizedBox(height: 6),

                  // _buildSearchEmployeeField(),
                  // const SizedBox(height: 18),
                  // _buildTitleText(AppString.textLeaveTimeline.tr),
                  // const SizedBox(height: 6),
                  // _buildDropdownField(
                  //   items: controller.items,
                  //   value: controller.selectAssignLeave.value,
                  //   onChanged: (value) =>
                  //   controller.selectAssignLeave.value = value ?? '',
                  // ),
                  // const SizedBox(height: 18),
                  // _buildTitleText(AppString.textLeaveType.tr),
                  // const SizedBox(height: 6),
                  // _buildLeaveTypeGrid(data),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}


/// Builds the bottom sheet header widget with a given title.
Widget _buildBottomSheetHeader() {
  return buildBottomSheetHeader(text: AppString.textAssignLeave.tr);
}

/// Builds a title text widget with the provided text.
Widget _buildTitleText(String text) {
  return customTitleText(text: text, isRequired: true);
}
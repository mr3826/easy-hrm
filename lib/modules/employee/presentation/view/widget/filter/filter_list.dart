import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/employee/presentation/view/widget/filter/section_expansion_tile.dart';
import '../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import 'check_box.dart';

class EmployeeFilterSection extends StatelessWidget {
  const EmployeeFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          ..._buildSectionList(),
        ],
      ),
    );
  }

  List<Widget> _buildSectionList() {
    final sectionTitles = [
      AppString.text_deparmtnet.tr,
      AppString.textEmployeeStatus.tr,
      AppString.textUserStatus.tr,
      AppString.textTodayAttendance.tr
    ];

    return sectionTitles.map((title) {
      return Column(
        children: [
          SectionExpansionTile(
            title: title,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _statusCheckBox(),
              ),
            ],
          ),
          _divider(),
        ],
      );
    }).toList();
  }

  Widget _buildHeader() {
    return buildBottomSheetHeader(
      customWidget: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(flex: 2),
          Center(
            child: Text(
              AppString.textFilters.tr,
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.fontSizeMid + 1,
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Spacer(),
          _buildResetButton(),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildResetButton() {
    return InkWell(
      onTap: () {
        // Implement reset functionality
      },
      child: Text(
        AppString.textReset.tr,
        style: AppStyle.normal_text_black.copyWith(
          color: AppColor.secondaryColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeDefault - 1,
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 0.5,
      width: double.infinity,
      color: AppColor.hintColor.withOpacity(0.3),
    );
  }

  Widget _statusCheckBox() {
    return GSMultiCheckbox(
      textStyle: AppStyle.normal_text_black.copyWith(
        fontSize: Dimensions.fontSizeDefault + 1,
        color: AppColor.normalTextColor.withOpacity(0.9),
      ),
      itemsList: statusItems,
      onSelectionChanged: (List<CheckBoxModel> list) {

      },
    );
  }
}

final List<CheckBoxModel> statusItems = [
  CheckBoxModel(
    checkBoxName: "Laravel department",
    checkBoxNameValue: "Laravel department1",
    value: false,
  ),
  CheckBoxModel(
    checkBoxName: "UL Department",
    checkBoxNameValue: "Laravel department1",
    value: false,
  ),
  CheckBoxModel(
    checkBoxName: "QA & Support",
    checkBoxNameValue: "Laravel department1",
    value: false,
  ),
  CheckBoxModel(
    checkBoxName: "Main Department",
    checkBoxNameValue: "Laravel department1",
    value: false,
  ),
];

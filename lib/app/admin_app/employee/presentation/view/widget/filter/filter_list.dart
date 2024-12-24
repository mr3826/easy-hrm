import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/employee/presentation/view/widget/filter/section_expansion_tile.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import '../../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../controller/employment_controller.dart';
import 'check_box.dart';

class EmployeeFilterSection extends StatefulWidget {
  const EmployeeFilterSection({super.key});

  @override
  State<EmployeeFilterSection> createState() => _EmployeeFilterSectionState();
}

class _EmployeeFilterSectionState extends State<EmployeeFilterSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        GetBuilder<EmploymentController>(
          builder: (EmploymentController controller) =>
              controller.isFilterInfoLoading.isTrue
                  ? const LoadingIndicator()
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [..._buildSectionList()],
                        ),
                      ),
                    ),
        ),
      ],
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
                child: _statusCheckBox(title),
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
        var controller = Get.find<EmploymentController>();
        controller.resetCheckBoxList(controller.departmentList);
        controller.resetCheckBoxList(controller.employmentStatusList);
        controller.resetCheckBoxList(controller.userStatusList);
        controller.resetCheckBoxList(controller.attendanceList);
        setState(() {});
        controller.getEmployees();
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

  Widget _statusCheckBox(String title) {
    List<CheckBoxModel> list = [];

    if (title == AppString.text_deparmtnet.tr) {
      list = Get.find<EmploymentController>().departmentList;
    } else if (title == AppString.textEmployeeStatus.tr) {
      list = Get.find<EmploymentController>().employmentStatusList;
    } else if (title == AppString.textUserStatus.tr) {
      list = Get.find<EmploymentController>().userStatusList;
    } else {
      list = Get.find<EmploymentController>().attendanceList;
    }

    return GSMultiCheckbox(
      textStyle: AppStyle.normal_text_black.copyWith(
        fontSize: Dimensions.fontSizeDefault + 1,
        color: AppColor.normalTextColor.withOpacity(0.9),
      ),
      itemsList: list,
      onSelectionChanged: (List<CheckBoxModel> list) async {
        Get.find<EmploymentController>().getEmployees();
        print("$list");
      },
    );
  }
}

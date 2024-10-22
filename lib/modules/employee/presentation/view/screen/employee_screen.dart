import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/employee/domain/employee_info.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../common/widget/custom_appbar.dart';
import '../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';
import '../../controller/employment_controller.dart';
import '../widget/employee_list/employee_list.dart';
import '../widget/employee_list/search_with_filter.dart';
import '../widget/filter/filter_list.dart';
import '../widget/serach_employee_list/search_employee_list.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildEmployeeAppBar(),
      body: Column(
        children: [
          customSpacerHeight(height: 14),
          _buildSearchWithFilters(),
          customSpacerHeight(height: 4),
          _buildEmployeeList(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildEmployeeAppBar() {
    return customAppbar(
      leadingIcon: Text(
        AppString.textEmployees.tr,
        style: AppStyle.normal_text_black.copyWith(
          fontSize: Dimensions.fontSizeMid,
        ),
      ),
      leadingWidth: MediaQuery.of(Get.context!).size.width / 3,
      centerTitle: false,
      actions: [
        customSvgImage(
          imageUrl: Images.notificationIconNavOutLine,
          height: 26,
          width: 26,
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildSearchWithFilters() {
    return Row(
      children: [
        customSpacerWidth(width: 20),
        CustomButtonWithIconAndLabel(
          icon: CupertinoIcons.search,
          labelText: AppString.textSearch.tr,
          onTap: () {
            showEmployeeSelectionSheet();
          },
        ),
        customSpacerWidth(width: 8),
        CustomButtonWithIconAndLabel(
          customIconWidget: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Image.asset(Images.filterIcon),
          ),
          labelText: AppString.textFilters.tr,
          onTap: () {
            showFilterSelectionSheet();
          },
        ),
        customSpacerWidth(width: 20),
      ],
    );
  }

  Widget _buildEmployeeList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 8, right: 8),
        itemCount: Get.find<EmploymentController>()
            .employeeInfo
            ?.getOrganizationUsers
            ?.data?.length,
        itemBuilder: (context, index) {
          Data? employee = Get.find<EmploymentController>()
              .employeeInfo
              ?.getOrganizationUsers
              ?.data?[index];
          return EmployeeListInfo(
            name:
                "${employee?.profile?.firstName ?? "Unknown"} ${employee?.profile?.lastName ?? ""}",
            departmentName: employee?.designation?.name ?? "Unknown department",
            imgUrlKey: employee?.profile?.image ?? "",
            statusText: employee?.employmentStatus?.name ?? "Unknown status",
            statusColor: Color(int.parse(
                "0xFF${employee?.employmentStatus?.color?.replaceAll("#", "")}")),
          );
        },
      ),
    );
  }
}

void showEmployeeSelectionSheet() {
  customButtonSheet(
    context: Get.context!,
    child: const SearchEmployeeList(),
    height: 0.8,
  );
}

void showFilterSelectionSheet() {
  customButtonSheet(
    context: Get.context!,
    child: const EmployeeFilterSection(),
    height: 0.8,
  );
}

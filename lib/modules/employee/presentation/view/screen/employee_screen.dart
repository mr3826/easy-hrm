import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../common/widget/custom_appbar.dart';
import '../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';
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
          _buildContactList(),


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

  Widget _buildContactList() {
    List<Map<String, String>> data = [
      {
        "name": "Jonas Kahnwald",
        "departmentName": "Laravel department",
        "imgUrlKey": "",
        "statusText": "Permanent",
        "color": "0xFF0CAA1B",
      },
      {
        "name": "Martha Nielsen",
        "departmentName": "Flutter department",
        "imgUrlKey": "",
        "statusText": "Probation",
        "color": "0xFFFFA500",
      },
      {
        "name": "Facility Nielsen",
        "departmentName": "QA department",
        "imgUrlKey": "",
        "statusText": "Ad-hoc",
        "color": "0xFFFF6347",
      },
      {
        "name": "Facility Nielsen",
        "departmentName": "QA department",
        "imgUrlKey": "",
        "statusText": "Ad-hoc",
        "color": "0xFFFF6347",
      },
      {
        "name": "Facility Nielsen",
        "departmentName": "QA department",
        "imgUrlKey": "",
        "statusText": "Ad-hoc",
        "color": "0xFFFF6347",
      },
      {
        "name": "Facility Nielsen",
        "departmentName": "QA department",
        "imgUrlKey": "",
        "statusText": "Ad-hoc",
        "color": "0xFFFF6347",
      },
      {
        "name": "Facility Nielsen",
        "departmentName": "QA department",
        "imgUrlKey": "",
        "statusText": "Ad-hoc",
        "color": "0xFFFF6347",
      },
      {
        "name": "Facility Nielsen",
        "departmentName": "QA department",
        "imgUrlKey": "",
        "statusText": "Ad-hoc",
        "color": "0xFFFF6347",
      },
      {
        "name": "Facility Nielsen",
        "departmentName": "QA department",
        "imgUrlKey": "",
        "statusText": "Ad-hoc",
        "color": "0xFFFF6347",
      },
      {
        "name": "Facility Nielsen",
        "departmentName": "QA department",
        "imgUrlKey": "",
        "statusText": "Ad-hoc",
        "color": "0xFFFF6347",
      },
      {
        "name": "Facility Nielsen",
        "departmentName": "QA department",
        "imgUrlKey": "",
        "statusText": "Ad-hoc",
        "color": "0xFFFF6347",
      },
    ];

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 8, right: 8),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ContactListInfo(
            name: data[index]["name"] ?? "Unknown",
            departmentName:
                data[index]["departmentName"] ?? "Unknown department",
            imgUrlKey: data[index]["imgUrlKey"] ?? "",
            statusText: data[index]["statusText"] ?? "Unknown status",
            statusColor: Color(int.parse(data[index]["color"].toString())),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../common/widget/custom_search_field.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../common/widget/custom_text_field.dart';
import '../../controller/leave_controller.dart';

class SearchEmployeeList extends StatelessWidget {
  final Function(String)? onValueSelected;

  SearchEmployeeList({Key? key, this.onValueSelected}) : super(key: key);

  final LeaveController _leaveController = Get.put(LeaveController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBottomSheetHeader(text: AppString.textEmployees.tr),
        customSpacerHeight(height: 20),
        _createSearchField(), // Keep the search field outside of the scroll view

        Expanded(
          // Use Expanded to fill available space
          child: SingleChildScrollView(
            child: Column(
              children: [
                customSpacerHeight(height: 12),
                _buildEmployeeInfo(
                    name: "John Doe", role: "Laravel department", imgUrl: ""),
                _buildRecentSearchSection(),
                customSpacerHeight(height: 8),
                _showEmployeeSection(),
                customSpacerHeight(height: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _generateEmployeeList() {
    List<Map<String, String>> users = [
      {
        "id": "1",
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      },
      {
        "id": "1",
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      },
      {
        "id": "1",
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      },
      {
        "id": "1",
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      },
      {
        "id": "1",
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      },
      {
        "id": "1",
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      },
      {
        "id": "1",
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      },
      {
        "id": "1",
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      },
      {
        "id": "1",
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      },
      {
        "id": "1",
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      },
      {
        "id": "1",
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      },
      {
        "id": "1",
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
      },

      // Add more users as needed...
    ];

    return ListView.builder(
      itemCount: users.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            onValueSelected?.call(users[index]["id"]!);
          },
          child: _buildEmployeeListItem(
              "${users[index]["name"]!} $index", users[index]["role"]!),
        );
      },
    );
  }

  Widget _buildEmployeeListItem(String name, String role) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 20, top: 14, bottom: 8),
      child: Row(
        children: [
          const CustomNetworkImage(
            imgUrlKey: "", // Replace with actual image URL key
            errorText: 'ER',
            height: 22,
          ),
          customSpacerWidth(width: 14),
          Expanded(child: _employeeDetails(name, role)),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.close,
              color: AppColor.hintColor,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeInfo(
      {required String name, required String role, required String imgUrl}) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20, top: 14, bottom: 16),
      child: Row(
        children: [
          CustomNetworkImage(
            imgUrlKey: "", // Replace with actual image URL key
            profileImageKey: imgUrl,
            errorText: 'ER',
            height: 22,
          ),
          customSpacerWidth(width: 14),
          Expanded(child: _employeeDetails(name, role)),
        ],
      ),
    );
  }

  Widget _showEmployeeSection() {
    return Obx(
      () => _leaveController.searchText.value.isEmpty
          ? _generateEmployeeList()
          : Container(),
    );
  }

  Widget _createSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomSearchField(
        onSearchChanged: (value) {
          _leaveController.searchText.value =
              value; // Update the reactive variable
        },
        searchHintText: AppString.textSearchAndSelect.tr,
        searchController: _leaveController.searchController.value,
      ),
    );
  }

  Widget _buildRecentSearchSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppString.textRecentSearch.tr,
            style: AppStyle.normal_text_black.copyWith(
              color: AppColor.normalTextColor,
              fontSize: Dimensions.fontSizeMid - 1,
              fontWeight: FontWeight.w600,
            ),
          ),
          InkWell(
            onTap: () {
              _leaveController.searchController.value.clear();
              _leaveController.searchText.value =
                  ''; // Clear search text as well
            },
            child: Text(
              AppString.textClearAll.tr,
              style: AppStyle.normal_text_black.copyWith(
                color: AppColor.secondaryColor,
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _employeeDetails(String name, String role) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.secondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.fontSizeDefault + 2,
          ),
        ),
        Text(
          role,
          style: subTextFieldTitleStyle.copyWith(
            color: AppColor.hintColor,
          ),
        ),
      ],
    );
  }
}

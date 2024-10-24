import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/admin_app/modules/employee/domain/employee_info.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import '../../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../common/widget/custom_search_field.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/custom_text_field.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../controller/employment_controller.dart';

class SearchEmployeeList extends StatelessWidget {
  const SearchEmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBottomSheetHeader(text: AppString.textEmployees.tr),
        customSpacerHeight(height: 20),

        /// Search employee input field
        _buildSearchField(),

        customSpacerHeight(height: 8),

        Obx(() {
          return Get.find<EmploymentController>().searchQuery.isEmpty
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        customSpacerHeight(height: 12),

                        /// Current user section (You)
                        _buildEmploymeeInfo(
                            name: "John Doe",
                            role: "Laravel department",
                            imgUrl: ""),

                        /// Recent search employee text section
                        _buildRecentSearchSection(),

                        /// Employee list section
                        _buildEmployeeSection(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 2),
                      ],
                    ),
                  ),
                )
              : Get.find<EmploymentController>().isSearchInfoLoading.isTrue
                  ? const CupertinoActivityIndicator(
                      color: AppColor.primaryColor,
                      radius: 14,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: Get.find<EmploymentController>()
                              .employeeList
                              ?.length ??
                          0,
                      itemBuilder: (context, index) {
                        Data? employee = Get.find<EmploymentController>()
                            .employeeList?[index];
                        return _buildEmploymeeInfo(
                            name:
                                "${employee?.profile?.firstName ?? ""} ${employee?.profile?.lastName ?? ""}",
                            role: employee?.designation?.name ?? "",
                            imgUrl: employee?.profile?.image ?? "");
                      },
                    );
        }),
      ],
    );
  }

  void _onSearchValueChanged(String value) {
    _clearSearchField();
    final controller = Get.find<EmploymentController>();
    controller.searchQuery.value = value;
    controller.searchController.text = value;
  }

  Widget _buildEmployeeSection() => _buildEmployeeList();

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomSearchField(
        onSearchChanged: (value) async {
          _onSearchValueChanged(value);
          await Get.find<EmploymentController>()
              .getEmployeesBySearch(searchQuery: value);
        },
        searchController: Get.find<EmploymentController>().searchController,
        searchHintText: AppString.textSearchAndSelect.tr,
      ),
    );
  }

  Widget _buildEmploymeeInfo({
    required String name,
    required String role,
    required String imgUrl,
  }) {
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
          Expanded(child: _buildEmployeeDetails(name, role)),
        ],
      ),
    );
  }

  Widget _buildEmployeeDetails(String name, String role) {
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

  Widget _buildEmployeeList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      // Adjust based on your data
      itemBuilder: (context, index) {
        return _buildEmployeeListItem(index);
      },
    );
  }

  Widget _buildEmployeeListItem(int index) {
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
          Expanded(
            child: _buildEmployeeDetails("Jonas Kahnwald", "Product Designer"),
          ),
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

  Widget _buildRecentSearchSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
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
            onTap: () => _clearSearchField(),
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

  void _clearSearchField() {
    final controller = Get.find<EmploymentController>();
    controller.searchController.clear();
    controller.searchQuery.value = "";
  }
}

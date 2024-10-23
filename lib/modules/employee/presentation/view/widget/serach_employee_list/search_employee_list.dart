import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/employee/presentation/controller/employment_controller.dart';
import '../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../common/widget/custom_search_field.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../common/widget/custom_text_field.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../utils/utils.dart';

class SearchEmployeeList extends StatelessWidget {
  const SearchEmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBottomSheetHeader(text: AppString.textEmployees.tr),
        customSpacerHeight(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomSearchField(
            onSearchChanged: (value) async{
              _valueChange(value);
            },
            searchController:
                Get.find<EmploymentController>().searchController,
            searchHintText: AppString.textSearchAndSelect.tr,
          ),
        ),
        customSpacerHeight(height: 8),
        buildRecentSearchSection(),
        Obx(() => Get.find<EmploymentController>().searchQuery.isEmpty
            ? Expanded(child: _buildEmployeeList())
            : Container()),
      ],
    );
  }

  void _valueChange(String value) {
    _clearTextField();
    Get.find<EmploymentController>().searchQuery.value = value;
    Get.find<EmploymentController>().searchController.text = value;
  }
}

Widget _buildEmployeeList() {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: 3, // Adjust based on your data
    itemBuilder: (context, index) {
      return _buildEmployeeListItem(index);
    },
  );
}

Widget _buildEmployeeListItem(int index) {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Row(
      children: [
        const CustomNetworkImage(
          imgUrlKey: "", // Replace with actual image URL key
          errorText: 'ER',
          height: 22,
        ),
        customSpacerWidth(width: 14),
        Expanded(
          child: buildEmployeeDetails("Jonus Kahnwald", "Product Designer"),
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

Widget buildRecentSearchSection() {
  return Obx(() => Get.find<EmploymentController>().searchQuery.isEmpty
      ? Padding(
          padding:
              const EdgeInsets.only(left: 24.0, top: 20, bottom: 20, right: 24),
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
                  _clearTextField();
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
        )
      : Container());
}

void _clearTextField() {
  Get.find<EmploymentController>().searchController.clear();
  Get.find<EmploymentController>().searchQuery.value = "";
}

Widget buildEmployeeDetails(name, department) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$name",
        style: AppStyle.mid_large_text.copyWith(
          color: AppColor.secondaryColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeDefault + 2,
        ),
      ),
      Text(
        "$department",
        style: subTextFieldTitleStyle.copyWith(
          color: AppColor.hintColor,
        ),
      ),
    ],
  );
}

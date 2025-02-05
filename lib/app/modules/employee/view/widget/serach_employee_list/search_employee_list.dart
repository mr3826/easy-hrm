import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as gs;
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:payrun_mobile/app/modules/employee/bindings/employee_bindings.dart';
import 'package:payrun_mobile/app/modules/employee/model/employee_info.dart';
import '../../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../../common/widget/custom_search_field.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/custom_text_field.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../common/widget/hr_timeline/custom_network_image.dart';
import '../../../../../../utils/utils.dart';
import '../../../../profile/controller/global_profile_controller.dart';
import '../../../controller/employment_controller.dart';

class SearchEmployeeList extends StatelessWidget {
  final Function(String)? onValueSelected;
  final Function(UserInfo)? userInfo;

  const SearchEmployeeList(
      {Key? key,
      this.onValueSelected,
      this.userInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    EmployeeBindings().dependencies();

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

                        GestureDetector(
                          onTap: (){
                            onValueSelected!(gs.GetStorage().read(AppString.ORGANIZATION_USER_ID));
                            userInfo?.call(UserInfo("${Get.find<ProfileGlobalController>().employeeName.value} (You)", Get.find<ProfileGlobalController>().employeeImeKey.value));

                          },
                          child: _buildOwnInfo(
                              name:Get.find<ProfileGlobalController>()
                                  .employeeName.value,
                              role:"Static value",
                              imgUrl: Get.find<ProfileGlobalController>()
                                  .employeeImeKey.value ??
                                  ""),
                        ),

                        /// Recent search employee text section
                        _buildRecentSearchTitleSection(),

                        /// Employee list section
                        _buildRecentlySearchedEmployeeSection(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 2),
                      ],
                    ),
                  ),
                )
              : Get.find<EmploymentController>().isSearchInfoLoading.isTrue
                  ? const Center(
                      child: CupertinoActivityIndicator(
                        color: AppColor.primaryColor,
                        radius: 14,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: Get.find<EmploymentController>()
                              .searchedEmployeeList
                              ?.length ??
                          0,
                      itemBuilder: (context, index) {final employee = Get.find<EmploymentController>()
                            .searchedEmployeeList?[index];
                        return GestureDetector(
                          onTap: () {
                            Get.find<EmploymentController>()
                                .addRecentSearchData(employee !);
                            userInfo?.call(UserInfo("${employee.profile?.firstName ?? ""} ${employee.profile?.lastName ?? ""}", employee.profile?.image ?? ""));
                        onValueSelected?.call(employee.id ?? "");
                          },
                          child: _buildEmploymeeInfo(
                              name:
                                  "${employee?.profile?.firstName ?? ""} ${employee?.profile?.lastName ?? ""}",
                              role: employee?.department?.name ?? "",
                              imgUrl: employee?.profile?.image ?? ""),
                        );
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

  Widget _buildRecentlySearchedEmployeeSection() => _buildEmployeeList();

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomSearchField(
        onSearchChanged: (value) async {
          _onSearchValueChanged(value);
          if (value.isNotEmpty) {
            await Get.find<EmploymentController>()
                .getEmployeesBySearch(searchQuery: value);
          }
        },
        searchController: Get.find<EmploymentController>().searchController,
        searchHintText: AppString.textSearchAndSelect.tr,
      ),
    );
  }

  Widget _buildOwnInfo({
    required String name,
    required String role,
    required String imgUrl,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20, top: 14, bottom: 16),
      child: Row(
        children: [
          CircularNetworkImage(
            imageUrl: buildImgIxUrl(imagePath: imgUrl,isPublic: true),
            errorText: getInitials(name),
            radius: 22,
          ),
          customSpacerWidth(width: 14),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildEmployeeDetails(name, role),
                const Text("(${AppString.textYou})")
              ],
            ),
          ),
        ],
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
          CircularNetworkImage(
            imageUrl: buildImgIxUrl(isPublic: true,imagePath: imgUrl), // Replace with actual image URL key
            errorText: getInitials(name),
            radius: 22,
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
    return ValueListenableBuilder(
      valueListenable: Hive.box<Data>('dataBox').listenable(),
      builder: (BuildContext context, Box value, Widget? child) {
        final dataList = value.values.toList();
        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dataList.length,
          // Adjust based on your data
          itemBuilder: (context, index) {
            return _buildEmployeeListItem(dataList[index]);
          },
        );
      },
    );
  }

  Widget _buildEmployeeListItem(employeeData) {
    return GestureDetector(
      onTap: () {
        onValueSelected?.call(employeeData.id ?? "");
        userInfo?.call(UserInfo("${employeeData.profile?.firstName ?? ""} ${employeeData.profile?.lastName ?? ""}", employeeData.profile?.image ?? ""));
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 20, top: 14, bottom: 8),
        child: Row(
          children: [
             CircularNetworkImage(
              imageUrl: buildImgIxUrl(isPublic: true,imagePath:  employeeData.profile?.image ?? ""), // Replace with actual image URL key
              errorText: getInitials("${employeeData.profile?.firstName ?? ""} ${employeeData.profile?.lastName ?? ""}"),
              radius: 22,
            ),
            customSpacerWidth(width: 14),
            Expanded(
              child: _buildEmployeeDetails(
                  "${employeeData.profile?.firstName ?? ""} ${employeeData.profile?.lastName ?? ""}",
                  employeeData.department?.name ?? ""),
            ),
            IconButton(
              onPressed: () {
                Get.find<EmploymentController>()
                    .removeRecentSearchData(employeeData.id ?? "");
              },
              icon: const Icon(
                Icons.close,
                color: AppColor.hintColor,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearchTitleSection() {
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
          ValueListenableBuilder(
            valueListenable: Hive.box<Data>('dataBox').listenable(),
            builder: (BuildContext context, Box value, child) {
              final dataList = value.values.toList();

              return dataList.isNotEmpty
                  ? InkWell(
                      onTap: () {
                        Get.find<EmploymentController>()
                            .clearAllRecentSearchData();
                      },
                      child: Text(
                        AppString.textClearAll.tr,
                        style: AppStyle.normal_text_black.copyWith(
                          color: AppColor.secondaryColor,
                          fontSize: Dimensions.fontSizeDefault,
                        ),
                      ),
                    )
                  : Container();
            },
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

class UserInfo {
  String? name;
  String? imgUrl;
  UserInfo(this.name, this.imgUrl);
}

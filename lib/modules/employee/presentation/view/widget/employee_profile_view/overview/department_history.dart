import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/view/widget/dotted_style_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../../../../common/widget/custom_network_image.dart';

/// Displays the department history for an employee.
class DepartmentHistoryForEmployee extends StatelessWidget {
  const DepartmentHistoryForEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for department history
    List<Map<String, String>> data = [
      {"name": "Facility Nielsen","startDate":"2014-10-07 15:15:58","endDate":""},
      {"name": "Facility Nielsen","startDate":"2021-10-07 15:15:58","endDate":"2024-10-07 15:15:58"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customButtonSheetAppbar(
          text: AppString.text_deparmtnet.tr,
          subtext: AppString.text_history.tr,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {

              print("statr::: ${data[index]["startDate"]}");
              // Determine if the current item is the last in the list
              bool isLastItem = index == data.length - 1;
              return _buildDepartmentHistoryItem(
                isLastIndex: isLastItem,
                imageUrl: "",
                startDate: _formatDate("${data[index]["startDate"]}"),
                endDate: _formatDate("${data[index]["endDate"]}"),
                departmentName: "Main department",
                parentDepartment: _formatParentDepartment("Manager"),
                managerName: _getManagerName(index),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds the layout for each department history item.
  Widget _buildDepartmentHistoryItem({
    required String departmentName,
    required String parentDepartment,
    String? startDate,
    String? endDate,
    required bool isLastIndex,
    required String managerName,
    required String imageUrl,
  }) {
    return Padding(
      padding: marginLayout.copyWith(bottom: 14, top: 16),
      child: Stack(
        children: [
          Padding(
            padding: marginLayout,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSvgImage(
                  imageUrl: Images.departmentNotification,
                  color: AppColor.normalTextColor,
                  height: 18,
                  width: 18,
                ),
                customSpacerWidth(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      departmentName,
                      style: AppStyle.normal_text_grey.copyWith(
                        color: AppColor.normalTextColor,
                        fontSize: Dimensions.fontSizeMid - 3,
                      ),
                    ),
                    _buildEmploymentDates(
                      startDate: startDate,
                      endDate: endDate,
                      parentDepartment: parentDepartment,
                    ),
                    customSpacerHeight(height: 14),
                    SizedBox(
                      child: Stack(
                        children: [
                          _buildDividers(),
                          Stack(
                            children: [
                              _buildManagerInfo(
                                imageUrl: imageUrl,
                                managerName: managerName,
                              ),
                              _buildDepartmentCircle(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          isLastIndex
              ? const SizedBox()
              : Positioned(
            top: 26,
            left: 1,
            bottom: 0,
            child: dottedStyleLayout(height: 99),
          ),
        ],
      ),
    );
  }

  /// Creates a circular avatar for the department layout.
  Widget _buildDepartmentCircle() {
    return Positioned(
      left: 40,
      bottom: 0,
      child: CircleAvatar(
        radius: 8,
        backgroundColor: AppColor.pureOrange,
        child: customSvgImage(
          imageUrl: Images.departmentNotification,
          color: AppColor.cardColor,
          height: 10,
        ),
      ),
    );
  }

  /// Formats and returns the employment date as a string.
  String? _formatDate(String? date) {
    if (date != null && date.isNotEmpty) {
      return DateFormat('dd MMM, yyyy').format(DateTime.parse(date));
    }
    return null;
  }

  /// Displays the employment dates and parent department information.
  Widget _buildEmploymentDates({
    String? startDate,
    String? endDate,
    required String parentDepartment,
  }) {
    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width / 1.5,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: parentDepartment,
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.secondaryColor,
                fontSize: Dimensions.fontSizeDefault - 3,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (parentDepartment.isNotEmpty)
              const TextSpan(
                text: '  | ',
                style: TextStyle(color: AppColor.hintColor, fontSize: 10),
              ),
            TextSpan(
              text: "${AppString.text_from.tr} $startDate",
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault - 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const TextSpan(
              text: '  -  ',
              style: TextStyle(color: AppColor.hintColor, fontSize: 10),
            ),
            TextSpan(
              text: endDate ?? AppString.textPresent.tr,
              style: endDate == null
                  ? AppStyle.mid_large_text.copyWith(
                color: AppColor.primaryColor,
                fontSize: Dimensions.fontSizeDefault - 3,
              )
                  : AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault - 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the formatted parent department name.
  String _formatParentDepartment(String departmentName) {
    return "${AppString.text_child_of_deparmtnet.tr} $departmentName";
  }

  /// Returns a placeholder manager name.
  String _getManagerName(int index) {
    return "Manager name";
  }

  /// Creates the manager's image layout with a circular avatar.
  Widget _buildManagerImage(String imageUrl) {
    return CircleAvatar(
      backgroundColor: AppColor.pendingColor,
      radius: 20,
      child: CircleAvatar(
        backgroundColor: AppColor.cardColor,
        radius: 19.4,
        child: CustomNetworkImage(
          errorText: "ER",
          height: 18,
          imgUrlKey: imageUrl,
          borderColor: Colors.transparent,
        ),
      ),
    );
  }

  /// Displays manager information including the name and title.
  Widget _buildManagerInfo({required String imageUrl, required String managerName}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: [
          _buildManagerImage(imageUrl),
          customSpacerWidth(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                managerName,
                style: AppStyle.normal_text_grey.copyWith(
                  color: AppColor.secondaryColor,
                  fontSize: Dimensions.fontSizeDefault - 1,
                ),
              ),
              Text(
                AppString.textManager.tr,
                style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeDefault - 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Creates vertical and horizontal dividers for the layout.
  Positioned _buildDividers() {
    return Positioned(
      child: Container(
        height: AppLayout.getHeight(20),
        width: AppLayout.getWidth(18),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: .9,
              color: AppColor.hintColor.withOpacity(0.6),
            ),
            bottom: BorderSide(
              width: .9,
              color: AppColor.hintColor.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/controller/leave_controller.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/widget/custom_title_text_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/images.dart';

class AssignLeave extends StatelessWidget {
  AssignLeave({super.key});

  // Instance of the LeaveController
  final LeaveController controller = Get.put(LeaveController());

  @override
  Widget build(BuildContext context) {
    // Sample data for leave types
    List<Map<String, String>> data = _getLeaveData();

    return Column(
      children: [
        // Bottom sheet header
        _buildBottomSheetHeader(AppString.textAssignLeave.tr),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTitleText(AppString.textEmployees.tr),
                  const SizedBox(height: 6),
                  _buildSearchEmployeeField(),
                  const SizedBox(height: 18),
                  _buildTitleText(AppString.textLeaveTimeline.tr),
                  const SizedBox(height: 6),
                  _buildDropdownField(
                    items: controller.items,
                    value: controller.selectAssignLeave.value,
                    onChanged: (value) =>
                        controller.selectAssignLeave.value = value ?? '',
                  ),
                  const SizedBox(height: 18),
                  _buildTitleText(AppString.textLeaveType.tr),
                  const SizedBox(height: 6),
                  _buildLeaveTypeGrid(data),
                ],
              ),
            ),
          ),
        ),
        // Action buttons
        Padding(
          padding: const EdgeInsets.only(left: 18, bottom: 18, right: 18),
          child: CustomDoubleAppButton(
              onAction: () {},
              cancelAction: () {
                Get.back(canPop: false);
                controller.leaveTypeSelectedIndex.value = (-1); //clear selection index.
              }),
        ),
      ],
    );
  }

  // Sample data for leave types
  List<Map<String, String>> _getLeaveData() {
    return [
      {
        "type": "Sick Leave",
        "status": "approved",
        "leaveName": "Self declaration",
        "leaveCount": "01"
      },
      {
        "type": "Vacationing",
        "status": "pending",
        "leaveName": "Employee declaration",
        "leaveCount": "05"
      },
      {
        "type": "Paternity Leave",
        "status": "approved",
        "leaveName": "Paternity",
        "leaveCount": "10"
      },
      {
        "type": "Maternity Leave",
        "status": "approved",
        "leaveName": "Doctor declaration",
        "leaveCount": "15"
      },
      {
        "type": "Sick Leave",
        "status": "approved",
        "leaveName": "Self declaration",
        "leaveCount": "01"
      },
      {
        "type": "Vacationing",
        "status": "pending",
        "leaveName": "Employee declaration",
        "leaveCount": "05"
      },
      {
        "type": "Paternity Leave",
        "status": "approved",
        "leaveName": "Paternity",
        "leaveCount": "10"
      },
      {
        "type": "Maternity Leave",
        "status": "approved",
        "leaveName": "Doctor declaration",
        "leaveCount": "15"
      },
      // Add more entries as needed
    ];
  }

  /// Builds the bottom sheet header widget with a given title.
  Widget _buildBottomSheetHeader(String title) {
    return buildBottomSheetHeader(text: title);
  }

  /// Builds a title text widget with the provided text.
  Widget _buildTitleText(String text) {
    return customTitleText(text: text, isRequired: true);
  }

  /// Builds a search field for selecting an employee.
  Widget _buildSearchEmployeeField() {
    return SizedBox(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColor.hintColor.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(CupertinoIcons.search,
                  color: AppColor.hintColor, size: 30),
              const SizedBox(width: 8),
              Text(
                AppString.textSearchAndSelectEmployee.tr,
                style: AppStyle.normal_text_black.copyWith(
                    fontSize: Dimensions.fontSizeDefault + 1,
                    color: AppColor.normalTextColor.withOpacity(0.6)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a dropdown field for selecting options (Leave Type, Timeline, etc.).
  Widget _buildDropdownField({
    required List<String> items,
    String? value,
    ValueChanged<String?>? onChanged,
  }) {
    return DropdownButtonFormField2(
      value: value?.isNotEmpty == true ? value : null,
      decoration: _buildDropdownDecoration(),
      isExpanded: true,
      hint: Text("Select an option",
          style:
              AppStyle.normal_text_grey.copyWith(fontWeight: FontWeight.w500)),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item,
                    style: AppStyle.normal_text_black
                        .copyWith(fontSize: Dimensions.fontSizeDefault + 2)),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  /// Provides the decoration for the dropdown field.
  InputDecoration _buildDropdownDecoration() {
    return InputDecoration(
      isDense: true,
      disabledBorder: _outlineInputBorder,
      enabledBorder: _outlineInputBorder,
      focusedBorder: _outlineInputBorder,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    );
  }

  /// Common outline decoration for dropdown fields.
  OutlineInputBorder get _outlineInputBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide:
          BorderSide(color: AppColor.hintColor.withOpacity(0.4), width: 1),
    );
  }

  /// Builds a grid displaying different leave types.
  Widget _buildLeaveTypeGrid(List<Map<String, String>> data) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 1.09,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.find<LeaveController>().leaveTypeSelectedIndex.value = index;
          },
          child: Obx(() {
            return Card(
              elevation: 0,
              color: AppColor.leaveRecordCardColor.withOpacity(0.9),
              shape: roundedRectangleBorder.copyWith(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Get.find<LeaveController>()
                              .leaveTypeSelectedIndex
                              .value ==
                          index
                      ? Colors.black
                      : AppColor.leaveRecordCardColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                        elevation: 0,
                        color: AppColor.primaryColor.withOpacity(0.08),
                        shape: roundedRectangleBorder.copyWith(
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildLeaveTypeIcon(data[index]["leaveName"]),
                        )),
                    const SizedBox(height: 2),
                    Text(data[index]["type"]!,
                        style: AppStyle.normal_text_black
                            .copyWith(color: AppColor.hintColor)),
                    const SizedBox(height: 6),
                    Text(data[index]["leaveName"]!,
                        style: AppStyle.normal_text_black.copyWith(
                            fontSize: Dimensions.fontSizeDefault + 1)),
                    Text("(${data[index]["leaveCount"]!})",
                        style: AppStyle.normal_text_black.copyWith(
                            fontSize: Dimensions.fontSizeDefault + 1)),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  /// Returns an icon widget according to the leave type.
  Widget _buildLeaveTypeIcon(String? leaveName) {
    // Define a map of leave types to corresponding image URLs
    final leaveImages = {
      "Vacationing": Images.leaveImage7,
      "Paternity": Images.leaveImage6,
      "Maternity": Images.leaveImage5,
      "School closed": Images.leaveImage4,
      "Children-minder illness": Images.leaveImage3,
      "Children illness": Images.leaveImage2,
      "Doctor declaration": Images.leaveImage1,
      "Self declaration": Images.leaveImage,
    };

    // Retrieve the image URL from the map or fallback to a default
    final imageUrl = leaveImages[leaveName] ?? Images.leaveImage8;

    return customSvgImage(
        imageUrl: imageUrl, height: 27, color: AppColor.secondaryColor);
  }
}

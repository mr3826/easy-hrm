import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_title_text_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../../common/widget/hr_timeline/custom_network_image.dart';
import '../../../../../../../modules/leave/presentation/controller/file_upload_controller.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/images.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../employee/view/widget/serach_employee_list/search_employee_list.dart';
import '../../../controller/hr_leave_controller.dart';
import '../../../controller/leave_controller.dart';
import '../../../controller/picked_file_from_stroage.dart';
import 'assign_leave_selected_view.dart';

class AssignLeave extends GetView<HrLeaveController> {
  const AssignLeave({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaveController leaveController = Get.put(LeaveController());
    return Column(
      children: [
        // Bottom sheet header
        _buildBottomSheetHeader(),
        Expanded(
            child: Obx(
                  () => controller.isAvailableLeaveType.isTrue
                  ? const Center(
                  child: CupertinoActivityIndicator(
                    radius: 15,
                    color: AppColor.primaryColor,
                  ))
                  : Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTitleText(AppString.textEmployees.tr),
                      const SizedBox(height: 6),
                      Obx(() => _buildSearchBar(context)),
                      const SizedBox(height: 18),
                      _buildTitleText(AppString.textLeaveYear.tr),
                      const SizedBox(height: 6),
                      _buildDropdownField(
                        items: leaveController.items,
                        value: leaveController.selectAssignLeave.value,
                        onChanged: (value) {
                          leaveController.selectAssignLeave.value =
                              value ?? '';
                          String year = value == "This year"
                              ? "${DateTime.now().year}"
                              : "${DateTime.now().year + 1}";
                          controller.getAvailableLeaveType(year: year);
                        },
                      ),
                      const SizedBox(height: 18),
                      _buildTitleText(AppString.textLeaveType.tr),
                      const SizedBox(height: 6),
                      _buildLeaveTypeGrid(controller),
                    ],
                  ),
                ),
              ),
            )),
        // Action buttons
        _buildButtonLayout(context),
      ],
    );
  }

  /// Builds the bottom sheet header widget with a given title.
  Widget _buildBottomSheetHeader() {
    return buildBottomSheetHeader(text: AppString.textAssignLeave.tr);
  }

  /// Builds a title text widget with the provided text.
  Widget _buildTitleText(String text) {
    return customTitleText(text: text, isRequired: true);
  }

  /// Builds a search field for selecting an employee.

  Widget _buildSearchBar(BuildContext context) {
    HrLeaveController controller = Get.put(HrLeaveController());
    return GestureDetector(
      onTap: () {
        _showEmployeeSelectionSheet();
      },
      child: SizedBox(
        height: 52,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 0,
          color: AppColor.cardColor,
          shape: roundedRectangleBorder.copyWith(
            side: BorderSide(
              color: AppColor.hintColor.withOpacity(0.3),
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(Dimensions.fontSizeMid + 2),
          ),
          child: Row(
            children: [
              customSpacerWidth(width: 12),
              const Icon(CupertinoIcons.search,
                  color: AppColor.hintColor, size: 25),
              customSpacerWidth(width: 8),
              if (controller.selectedEmployeeImgKey.isNotEmpty) ...[
                CircularNetworkImage(
                  imageUrl: buildImgIxUrl(imagePath: controller.selectedEmployeeImgKey.value,isPublic: true),
                  errorText:getInitials(controller.selectedEmployeeInfo.value.replaceAll("(You)", "")) ,
                  radius: 12,
                  borderColor: Colors.transparent,
                ),
                customSpacerWidth(width: 6),
              ],
              Expanded(
                child: Text(
                  controller.selectedEmployeeInfo.value,
                  maxLines: 1,
                  style: AppStyle.normal_text_black.copyWith(
                      fontSize: Dimensions.fontSizeMid - 3,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              if (controller.selectedEmployeeInfo.value !=
                  AppString.textSearchEmployee)
                InkWell(
                  onTap: () {
                    controller.selectedEmployeeInfo.value =
                        AppString.textSearchEmployee.tr;
                    controller.selectedEmployeeImgKey.value = "";
                    controller.getLeaveRecord();
                  },
                  child: const Icon(CupertinoIcons.clear,
                      color: AppColor.hintColor, size: 23),
                ),
              customSpacerWidth(width: 12),
            ],
          ),
        ),
      ),
    );
  }

  _buildButtonLayout(BuildContext context) {
    LeaveFileUploadController controller = Get.put(LeaveFileUploadController());

    return Padding(
        padding: const EdgeInsets.only(left: 18, bottom: 18, right: 18),
        child: Obx(() => CustomDoubleAppButton(
            onAction:
            Get.find<LeaveController>().leaveTypeSelectedIndex.value >= 0
                ? () {
              showCustomBottomSheet(
                  context: Get.context!,
                  height: MediaQuery.of(Get.context!).size.height / 1.2,
                  child: const AssignLeaveSelectedValue());
              controller.path.value = "";
            }
                : () {},
            buttonText: AppString.text_continue.tr,
            btnColor:
            Get.find<LeaveController>().leaveTypeSelectedIndex.value >= 0
                ? AppColor.primaryColor
                : AppColor.primaryColor.withOpacity(0.5),
            cancelAction: () {
              _clear();
            })));
  }

  void _clear() {
    Get.back(canPop: false);
    Get.find<LeaveController>().leaveTypeSelectedIndex.value =
    (-1); //clear selection index.
    Get.find<HrLeaveController>().selectedEmployeeInfo.value =
        AppString.textSearchEmployee.tr;
    Get.find<FileUploadController>().storageForUpload.filePath.value = "";

    Get.find<HrLeaveController>().isFileUploadedSuccessfully(false);
  }
}

/// Builds a dropdown field for selecting options (Leave Type, Timeline, etc.).
Widget _buildDropdownField({
  required List<String> items,
  String? value,
  ValueChanged<String?>? onChanged,
}) {
  return DropdownButtonFormField2(
    value: value?.isNotEmpty == true ? value : null,
    decoration: buildDropdownDecoration(),
    isExpanded: true,
    hint: Text("Select an option",
        style: AppStyle.normal_text_grey.copyWith(fontWeight: FontWeight.w500)),
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
InputDecoration buildDropdownDecoration() {
  return InputDecoration(
    isDense: true,
    disabledBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
  );
}

/// Common outline decoration for dropdown fields.
OutlineInputBorder get outlineInputBorder {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide:
    BorderSide(color: AppColor.hintColor.withOpacity(0.4), width: 1),
  );
}

/// Builds a grid displaying different leave types.
Widget _buildLeaveTypeGrid(HrLeaveController controller) {
  // Handle null list of available leave types
  final leaveTypes =
      controller.availableLeaveType?.getAvailableLeaveTypes ?? [];

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
    itemCount: leaveTypes.length,
    itemBuilder: (context, index) {
      final data = leaveTypes[index];
      final availableLeave = data.availableLeave ?? "0";
      final leaveTypeSelectedIndex =
          Get.find<LeaveController>().leaveTypeSelectedIndex;

      return GestureDetector(
        onTap: () {
          if (availableLeave != "0") {
            leaveTypeSelectedIndex.value = index;
            controller.leaveTypeId = data.leaveTypeId;

            Get.find<HrLeaveController>().calculateAllowanceOfLeave.value =
                data.calculateAllowanceBy ?? "";
          }
        },
        child: Obx(() {
          return Card(
            elevation: 0,
            color: AppColor.leaveRecordCardColor.withOpacity(0.9),
            shape: roundedRectangleBorder.copyWith(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: leaveTypeSelectedIndex.value == index
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
                    color: availableLeave != "0"
                        ? AppColor.primaryColor.withOpacity(0.08)
                        : AppColor.disableColor.withOpacity(0.4),
                    shape: roundedRectangleBorder.copyWith(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildLeaveTypeIcon(
                        data.name ?? "Unknown",
                        availableLeave,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.type ?? "N/A",
                    style: AppStyle.normal_text_black.copyWith(
                      color: AppColor.hintColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.name ?? "Unknown",
                    style: AppStyle.normal_text_black.copyWith(
                      fontSize: Dimensions.fontSizeDefault + 1,
                      color: availableLeave != "0"
                          ? AppColor.normalTextColor
                          : AppColor.hintColor,
                    ),
                  ),
                  Text(
                    "($availableLeave)",
                    style: AppStyle.normal_text_black.copyWith(
                      fontSize: Dimensions.fontSizeDefault + 1,
                      color: availableLeave != "0"
                          ? AppColor.normalTextColor
                          : AppColor.hintColor,
                    ),
                  ),
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
Widget _buildLeaveTypeIcon(String? leaveName, String? availableLeave) {
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
    imageUrl: imageUrl,
    height: 24,
    color: availableLeave != "0" ? AppColor.secondaryColor : AppColor.hintColor,
  );
}

void _showEmployeeSelectionSheet() {
  HrLeaveController controller = Get.put(HrLeaveController());
  LeaveController leaveController = Get.put(LeaveController());
  customButtonSheet(
    context: Get.context!,
    child: SearchEmployeeList(
      onValueSelected: (value) {
        leaveController.tabLength.value = 1;
        controller.getAvailableLeaveType(
          orgUserId: value,
        );
        Get.back(canPop: false);
        controller.selectedEmployeeId = value;
      },
      userInfo: (name) {
        controller.selectedEmployeeInfo.value = name.name ?? "";
        controller.selectedEmployeeImgKey.value = name.imgUrl ?? "";
      },
    ),
    height: 0.8,
  );
}
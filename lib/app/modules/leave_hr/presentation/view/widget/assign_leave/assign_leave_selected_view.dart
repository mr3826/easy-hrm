import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../../../common/widget/custom_double_app_button.dart';
import '../../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../../common/widget/input_note.dart';
import '../../../../../../../../../common/widget/timePicker/custom_time_picker_in_time.dart';
import '../../../../../../../../../common/widget/timePicker/custom_time_picker_out_time.dart';
import '../../../../../../../../../utils/app_color.dart';
import '../../../../../../../../../utils/app_style.dart';
import '../../../../../../../../../utils/dimensions.dart';
import '../../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../../../../common/widget/warning_message.dart';
import '../../../../../../../modules/leave/presentation/controller/leave_screen_controller.dart';
import '../../../../../../../modules/leave/presentation/view/widget/custom_title_text_widget.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../../modules/auth/view/screens/otp_screen.dart';
import '../../../../../employee/view/widget/serach_employee_list/search_employee_list.dart';
import '../../../controller/hr_leave_controller.dart';
import '../../../controller/leave_controller.dart';
import 'add_attachment_file.dart';
import 'assign_leave.dart';
import 'leave_type.dart';

/// A widgets that displays and edits leave record details.
class AssignLeaveSelectedValue extends StatelessWidget {
  const AssignLeaveSelectedValue({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Builds the header with a static date and day.
        Obx(() => _buildHeader()),

        /// Builds the list of text fields for various leave record details.
        Obx(() => _buildListOfTextField(context))
      ],
    );
  }

  /// Builds a scrollable list of form fields for editing leave record details.
  Widget _buildListOfTextField(BuildContext context) {
    final LeaveController controller = Get.put(LeaveController());

    // Show loader if leave types are being fetched
    if (Get.find<HrLeaveController>().isAvailableLeaveType.isTrue) {
      return const Padding(
        padding: EdgeInsets.only(top: 28.0),
        child: Center(
            child: CupertinoActivityIndicator(
          color: AppColor.primaryColor,
          radius: 15,
        )),
      );
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText(AppString.text_employee_type
              ),
              customSpacerHeight(height: 18),

              /// Displays the title and a required leave type dropdown.
              _buildTitleText(
                  text: AppString.textEmployees.tr, isRequired: true),
              customSpacerHeight(height: 8),

              Obx(
                () => _buildSearchBar(context, onSearch: () {
                  _showEmployeeSelectionSheet();
                }),
              ),
              const SizedBox(height: 18),

              _buildTitleText(
                  text: AppString.textLeaveYear.tr, isRequired: true),
              const SizedBox(height: 6),
              _buildDropdownField(
                  items: controller.items,
                  value: controller.selectAssignLeave.value,
                  onChanged: (value) {
                    controller.selectAssignLeave.value = value ?? '';
                    String year = value == "This year"
                        ? "${DateTime.now().year}"
                        : "${DateTime.now().year + 1}";
                    Get.find<HrLeaveController>()
                        .getAvailableLeaveType(year: year);
                  }),
              const SizedBox(height: 18),

              _buildTitleText(
                  text: AppString.textLeaveType.tr, isRequired: true),
              customSpacerHeight(height: 8),
              const LeaveTypeDropDown(),

              customSpacerHeight(height: 18),

              _leaveCountStyleLayout(),

              /// Displays the title and a status selection tab.
              _buildTitleText(text: AppString.text_status.tr),
              customSpacerHeight(height: 8),
              _buildStatusTabSelector(),
              customSpacerHeight(height: 18),

              _buildText("Application details"),

              customSpacerHeight(height: 18),

              Get.find<LeaveScreenController>().startTime != null
                  ? CustomTimePickerInTime(
                      inTime:
                          "2024-01-01 ${Get.find<LeaveScreenController>().startTime}",
                    )
                  : const CustomTimePickerInTime(),

              customSpacerHeight(height: 20),
              customTitleText(text: AppString.text_to.tr, isRequired: true),
              customSpacerHeight(height: 8),
              Get.find<LeaveScreenController>().endTime != null
                  ? CustomTimePickerOutTime(
                      outTime:
                          "2024-01-01 ${Get.find<LeaveScreenController>().endTime}",
                    )
                  : const CustomTimePickerOutTime(),

              customSpacerHeight(height: 12),
              customSpacerHeight(height: 18),

              /// Displays the title and a note input field.
              _buildTitleText(text: AppString.text_note.tr),
              customSpacerHeight(height: 8),
              _buildNote(),
              customSpacerHeight(height: 18),

              /// Displays the title and an attachment input.
              _buildTitleText(text: AppString.text_document.tr),
              customSpacerHeight(height: 8),
               const AttachmentFile(
                isAssignLeave: true,
              ),
              customSpacerHeight(height: 30),

              /// Displays the action buttons.
              Obx(
                () => _buildButton(),
              ),
              customSpacerHeight(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  _leaveCountStyleLayout() {
    return Obx(() =>
        Get.find<HrLeaveController>().calculateAllowanceOfLeave.value.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 0,
                  shape: roundedRectangleBorder,
                  color: AppColor.primaryColor.withOpacity(0.05),
                  child: Padding(
                    padding: marginLayout.copyWith(
                        top: 8, bottom: 8, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatToTwoDecimalPlaces(Get.find<HrLeaveController>()
                              .calculateAllowanceOfLeave
                              .value),
                          style: AppStyle.mid_large_text
                              .copyWith(color: AppColor.normalTextColor),
                        ),
                        Text(
                          _getCalculateLeave(),
                          style: AppStyle.mid_large_text.copyWith(
                              color: AppColor.hintColor,
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container());
  }

  String _getCalculateLeave() {
    final calculateAllowanceOfLeave =
        Get.find<HrLeaveController>().calculateAllowanceOfLeave.value;
    switch (calculateAllowanceOfLeave) {
      case "no_of_application":
        return "Balance (No.of application)";
      case "undefined":
        return "Balance (Undefined)";
      default:
        return "Balance (No.of days)";
    }
  }

  /// Builds a horizontal tab selector for leave status options.
  Widget _buildStatusTabSelector() {
    final leaveController = Get.find<LeaveController>();
    return SizedBox(
      height: AppLayout.getHeight(44),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.circular(4),
          border:
              Border.all(width: 1, color: AppColor.hintColor.withOpacity(0.5)),
        ),
        child: ListView.builder(
          itemCount: leaveController.statusOptions.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Obx(() {
              // Checks if the current index is selected.
              final isSelected = index == leaveController.selectedStatusIndex.value;
              return GestureDetector(
                onTap: () => leaveController.selectedStatusIndex.value = index,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    color:
                        isSelected ? AppColor.pendingColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    leaveController.statusOptions[index],
                    style: AppStyle.normal_text.copyWith(
                      color:
                          isSelected ? AppColor.cardColor : AppColor.hintColor,
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  /// Builds the note input field.
  Widget _buildNote() {
    return InputNote(
      controller: leaveNoteController,
      hintText: AppString.text_add_note.tr,
      borderColor: AppColor.hintColor.withOpacity(0.5),
    );
  }

  _buildText(String text) {
    return Text(
      text,
      style: AppStyle.normal_text_black.copyWith(
          color: AppColor.normalTextColor.withOpacity(0.8),
          fontSize: 13,
          letterSpacing: 4),
    );
  }

  _buildButton() {
    if (Get.find<HrLeaveController>().isAssignLeaveLoaderLoading.isTrue) {
      return const Center(
          child: CupertinoActivityIndicator(
        color: AppColor.primaryColor,
        radius: 15,
      ));
    }

    return CustomDoubleAppButton(
        btnColor: AppColor.primaryColor,
        onAction: () {
          if (!DateTime.parse(Get.find<DateTimePickerController>().outDateTime.value).difference(DateTime.parse(Get.find<DateTimePickerController>().inDateTime.value)).isNegative) {

            if (Get.find<HrLeaveController>()
                    .calculateAllowanceOfLeave
                    .value
                    .isNotEmpty &&
                Get.find<HrLeaveController>().calculateAllowanceOfLeave.value !=
                    "0") {

              Get.find<HrLeaveController>().applyLeave(
                  status: Get.find<LeaveController>().selectedStatusIndex.value == 0
                          ? "pending"
                          : "approved");
            } else {
              showWarningMessage(message: AppString.text_no_available_leave.tr);
            }

          } else {
            showWarningMessage(
                message: AppString.dateDifferenceIssueMessage.tr);
          }
        },
        cancelAction: () {
          Get.back(canPop: false);
        });
  }
}

Widget _buildTitleText({required String text, bool isRequired = false}) {
  return Row(
    children: [
      Text(
        text,
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.fontSizeDefault + 2),
      ),
      customSpacerWidth(width: 4),
      if (isRequired)
        Text(
          "*",
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.errorColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.fontSizeDefault + 1),
        ),
    ],
  );
}

Widget _buildHeader() {
  final screenHeight = MediaQuery.of(Get.context!).size.height;

  return Container(
    height: screenHeight / 9,
    width: double.infinity,
    decoration: const BoxDecoration(
      color: AppColor.bgColorWithTimeline,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Container(height: 4, width: 120, color: AppColor.backgroundColor),
        ),
        customSpacerHeight(height: 12),
        Text(
          DateTime.parse(Get.find<DateTimePickerController>().inDate.value)
                      .day ==
                  DateTime.parse(
                          Get.find<DateTimePickerController>().outDate.value)
                      .day
              ? DateFormat('d MMMM').format(DateTime.parse(
                  Get.find<DateTimePickerController>().inDate.value))
              : "${DateFormat('d MMMM').format(DateTime.parse(Get.find<DateTimePickerController>().inDate.value))}- ${DateFormat('d MMMM').format(DateTime.parse(Get.find<DateTimePickerController>().outDate.value))}",
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.secondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.fontSizeDefault + 2,
          ),
        ),
        Text(
          DateTime.parse(Get.find<DateTimePickerController>().inDate.value)
                      .day ==
                  DateTime.parse(
                          Get.find<DateTimePickerController>().outDate.value)
                      .day
              ? DateFormat('EEEE').format(DateTime.parse(
                  Get.find<DateTimePickerController>().inDate.value))
              : "${DateFormat('EEEE').format(DateTime.parse(Get.find<DateTimePickerController>().inDate.value))} - ${DateFormat('EEEE').format(DateTime.parse(Get.find<DateTimePickerController>().outDate.value))}",
          style: AppStyle.small_text_black.copyWith(
            color: AppColor.hintColor,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

// Search bar method renamed and optimized
Widget _buildSearchBar(BuildContext context, {required Function onSearch}) {
  HrLeaveController controller = Get.put(HrLeaveController());

  return GestureDetector(
    onTap: () => onSearch(),
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
              CustomNetworkImage(
                imgUrlKey: controller.selectedEmployeeImgKey.value,
                errorText: "Er",
                height: 12,
                borderColor: Colors.transparent,
                errorTextStyle: AppStyle.normal_text_black
                    .copyWith(fontSize: 14, color: AppColor.secondaryColor),
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
        print("value ::: $value");
        controller.selectedEmployeeId = value;
      },
      userInfo: (name) {
        controller.selectedEmployeeInfo.value = name.name ?? "";
        controller.selectedEmployeeImgKey.value = name.imgUrl ?? "";
      },
      onClickRouteAction: () {},
    ),
    height: 0.8,
  );
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../model/leave_details_by_id.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../../../../common/widget/custom_double_app_button.dart';
import '../../../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../../common/widget/input_note.dart';
import '../../../../../../../../../common/widget/timePicker/custom_time_picker_in_time.dart';
import '../../../../../../../../../common/widget/timePicker/custom_time_picker_out_time.dart';
import '../../../../../../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../../../../../../common/widget/warning_message.dart';
import '../../../../../../../../../common/widget/custom_title_text_widget.dart';
import '../../../../../../../../../utils/app_color.dart';
import '../../../../../../../../../utils/app_style.dart';
import '../../../../../../../../../utils/dimensions.dart';
import '../../../../../../../../../utils/utils.dart';
import '../../../../../../../../global/view/widget/app_margin.dart';
import '../../../../../controller/hr_leave_controller.dart';
import '../../../../../controller/hr_update_leave_controller.dart';
import '../../../../../controller/leave_controller.dart';
import '../../../../../controller/picked_file_from_stroage.dart';
import '../../../assign_leave/add_attachment_file.dart';
import '../../../assign_leave/assign_leave.dart';
import '../../../assign_leave/leave_type.dart';

/// A widget that displays and edits leave record details.
class EditLeaveRecordDetails extends GetView<HrLeaveController> {
  final bool isEmployee;
  final GetLeaveDetailsById? getLeaveDetailsById;
  const EditLeaveRecordDetails(
      {super.key, this.getLeaveDetailsById, required this.isEmployee});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered()) {
      Get.delete<HrUpdateLeaveController>();
      Get.delete<LeaveFileUploadController>();
    }
    Get.put(HrUpdateLeaveController());
    Get.put(LeaveFileUploadController());

    return Column(
      children: [
        /// Builds the header with a static date and day.
        Obx(() => _buildHeader()),

        /// Builds the list of text fields for various leave record details.
        Obx(() => _buildListOfTextField(context)),
      ],
    );
  }

  /// Builds a scrollable list of form fields for editing leave record details.
  Widget _buildListOfTextField(BuildContext context) {
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
              if (isEmployee == false) ...[
                _buildText("Employee & type"),
                _spacer(18),

                /// Displays the title and a required leave type dropdown.
                _buildTitleText(
                    text: AppString.textEmployees.tr, isRequired: true),
                _spacer(8),
                _buildSearchBar(context),
              ],

              _spacer(18),
              _buildTitleText(
                  text: AppString.textLeaveYear.tr, isRequired: true),

              _spacer(8),

              _buildLeaveYear(),

              ///Timeline [This year,Next year]

              _spacer(18),
              _buildTitleText(
                  text: AppString.textLeaveType.tr, isRequired: true),
              _spacer(8),
              const LeaveTypeDropDown(),
              _spacer(18),
              _leaveCountStyleLayout(),

              if (isEmployee == false) ...[
                /// Displays the title and a status selection tab.
                _buildTitleText(text: AppString.text_status.tr),
                _spacer(8),

                _buildStatusTabSelector(),

                _spacer(18),
              ],

              _buildText("Application details"),

              _spacer(18),

              _buildTitleText(text: AppString.text_from.tr, isRequired: true),
              _spacer(8),

              _buildFromDateWithTime(),

              _spacer(20),
              customTitleText(text: AppString.text_to.tr, isRequired: true),
              _spacer(8),

              _buildToDateWithTime(),

              _spacer(18),

              /// Displays the title and a note input field.
              _buildTitleText(text: AppString.text_note.tr),
              _spacer(18),

              _buildNote(),

              _spacer(18),

              /// Displays the title and an attachment input.
              _buildTitleText(text: AppString.text_document.tr),

              _spacer(8),

              AttachmentFile(
                getLeaveDetailsById: getLeaveDetailsById,
              ),
              _spacer(18),

              /// Displays the action buttons.

              Obx(
                () => Get.find<HrUpdateLeaveController>()
                        .isUpdateLeaveLoading
                        .isTrue
                    ? const Center(
                        child: CupertinoActivityIndicator(
                            color: AppColor.primaryColor, radius: 15),
                      )
                    : CustomDoubleAppButton(
                        btnColor: Get.find<HrLeaveController>()
                                .isUpdateLeaveChangeValue
                                .isTrue
                            ? AppColor.primaryColor
                            : AppColor.primaryColor.withOpacity(0.5),
                        onAction: () {
                          if (Get.find<HrLeaveController>()
                              .isUpdateLeaveChangeValue
                              .isTrue) {
                            if (Get.find<HrLeaveController>()
                                    .calculateAllowanceOfLeave
                                    .value
                                    .isNotEmpty &&
                                Get.find<HrLeaveController>()
                                        .calculateAllowanceOfLeave
                                        .value !=
                                    "0") {
                              _updateLeaveMethod();
                            } else {
                              showWarningMessage(
                                  message:
                                      AppString.text_no_available_leave.tr);
                            }
                          }
                        },
                        cancelAction: () {
                          /// Clears the file upload path and navigates back.
                          Get.find<LeaveFileUploadController>().path.value = "";
                          Get.back(canPop: false);
                        }),
              ),

              _spacer(100),
            ],
          ),
        ),
      ),
    );
  }

  void _updateLeaveMethod() {
    if (!DateTime.parse(Get.find<DateTimePickerController>().outDateTime.value)
        .difference(DateTime.parse(
            Get.find<DateTimePickerController>().inDateTime.value))
        .isNegative) {
      Get.find<HrUpdateLeaveController>().updateAssignLeave(
        leaveId: controller.leaveId.toString(),
        status:  Get.find<LeaveController>().selectedStatusIndex.value==0?"pending":"approved",
        leaveTypeId: controller.leaveTypeId,
        startDate: Get.find<DateTimePickerController>().inDateTime.value,
        endDate: Get.find<DateTimePickerController>().outDateTime.value,
        size: controller.fileSize.toString(),
        name: controller.fileName.toString(),
        key: controller.fileKey.toString(),
        id: controller.fileId.toString(),
      );
    } else {
      showWarningMessage(message: AppString.dateDifferenceIssueMessage.tr);
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
                onTap: (){
                  leaveController.selectedStatusIndex(index);
                  if (leaveController.selectedStatusIndex.value == 1) {
                    Get.find<HrLeaveController>().isUpdateLeaveChangeValue(true);
                  }
                },

                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? leaveController.selectedStatusIndex.value == 0
                            ? AppColor.pendingColor
                            : AppColor.successColor
                        : Colors.transparent,
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
      onChanged: (value) {
        if (value != null) {
          Get.find<HrLeaveController>().isUpdateLeaveChangeValue(true);
        }
      },
    );
  }

  _spacer(double i) {
    return customSpacerHeight(height: i);
  }

  _buildLeaveYear() {
    final LeaveController controller = Get.put(LeaveController());
    return _buildDropdownField(
        items: controller.items,
        value: controller.selectAssignLeave.value,
        onChanged: (value) {
          controller.selectAssignLeave.value = value ?? '';
          String year = value == "This year"
              ? "${DateTime.now().year}"
              : "${DateTime.now().year + 1}";
          Get.find<HrLeaveController>().getAvailableLeaveType(year: year);
          Get.find<HrLeaveController>().isUpdateLeaveChangeValue(true);
        });
  }
}

Widget _buildFromDateWithTime() {
  return const CustomTimePickerInTime();
}

Widget _buildToDateWithTime() {
  return const CustomTimePickerOutTime();
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
Widget _buildSearchBar(BuildContext context) {
  HrLeaveController controller = Get.put(HrLeaveController());

  return SizedBox(
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
          customSpacerWidth(width: 12),
        ],
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

_buildText(String text) {
  return Text(
    text,
    style: AppStyle.normal_text_black.copyWith(
        color: AppColor.normalTextColor.withOpacity(0.8),
        fontSize: 13,
        letterSpacing: 4),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/timePicker/custom_time_picker_in_time.dart';
import 'package:payrun_mobile/common/widget/timePicker/custom_time_picker_out_time.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/common/widget/warning_message.dart';
import 'package:payrun_mobile/modules/leave/controller/update_leave_controller.dart';
import 'package:payrun_mobile/modules/leave/model/leave_records.dart';
import '../../../../common/controller/date_time_controller.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/view/widget/add_attachemnt_file_widget.dart';
import 'package:payrun_mobile/modules/leave/view/widget/custom_title_text_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../controller/apply_leave_controller.dart';
import '../../controller/file_upload_controller.dart';
import '../../model/leave_type.dart';
import '../widget/apply_leave_dropdown.dart';

class UpdateLeave extends StatelessWidget {
  final GetLeaveRecords? leaveRecords;

  const UpdateLeave({super.key, this.leaveRecords});

  @override
  Widget build(BuildContext context) {
    _updateDateFromResponse();
    return Column(
      children: [
        Obx(
          () => customButtonSheetAppbar(
            text: DateTime.parse(
                            Get.find<DateTimePickerController>().inDate.value)
                        .day ==
                    DateTime.parse(
                            Get.find<DateTimePickerController>().outDate.value)
                        .day
                ? DateFormat('d MMMM').format(DateTime.parse(
                    Get.find<DateTimePickerController>().inDate.value))
                : "${DateFormat('d MMMM').format(DateTime.parse(Get.find<DateTimePickerController>().inDate.value))}- ${DateFormat('d MMMM').format(DateTime.parse(Get.find<DateTimePickerController>().outDate.value))}",
            subtext: DateTime.parse(
                            Get.find<DateTimePickerController>().inDate.value)
                        .day ==
                    DateTime.parse(
                            Get.find<DateTimePickerController>().outDate.value)
                        .day
                ? DateFormat('EEEE').format(DateTime.parse(
                    Get.find<DateTimePickerController>().inDate.value))
                : "${DateFormat('EEEE').format(DateTime.parse(Get.find<DateTimePickerController>().inDate.value))} - ${DateFormat('EEEE').format(DateTime.parse(Get.find<DateTimePickerController>().outDate.value))}",
          ),
        ),
        Expanded(child: UpdateLeaveButtonLayout(leaveRecords: leaveRecords))
      ],
    );
  }

  void _updateDateFromResponse() {
    Get.find<UpDateLeaveController>().leaveId = leaveRecords?.id ?? '';
    Get.find<UpDateLeaveController>().leaveTypeId =
        leaveRecords?.leaveType?.leaveId ?? "";
    Get.find<DateTimePickerController>().inTime.value = DateFormat('HH:mm')
        .format(DateTime.parse(
            leaveRecords?.startDate ?? DateTime.now().toString()));
    Get.find<DateTimePickerController>().inDate.value = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(
            leaveRecords?.startDate ?? DateTime.now().toString()));
    Get.find<DateTimePickerController>().outTime.value = DateFormat('HH:mm')
        .format(
            DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()));
    Get.find<DateTimePickerController>().outDate.value =
        DateFormat('yyyy-MM-dd').format(
            DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()));

    Get.find<DateTimePickerController>().getInDateTime();
    Get.find<DateTimePickerController>().getOutDateTime();
    leaveNoteController.text = leaveRecords?.description ?? "";
    Get.find<UpDateLeaveController>().isNoteRequired.value =
        leaveRecords?.leaveType?.isAddNoteRequired ?? false;
    Get.find<UpDateLeaveController>().isDocumentRequired.value =
        leaveRecords?.leaveType?.isAttachDocumentRequired ?? false;
  }
}

class UpdateLeaveButtonLayout extends GetView<UpDateLeaveController> {
  final GetLeaveRecords? leaveRecords;

  UpdateLeaveButtonLayout({super.key, this.leaveRecords});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Padding(
              padding: marginLayout.copyWith(top: Dimensions.fontSizeMid),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customTitleText(
                          text: AppString.text_leave_name.tr, isRequired: true),
                      customSpacerHeight(height: 8),
                      UpdateLeaveDropdown(
                          dropdownValue:
                              leaveRecords?.leaveType?.leaveId ?? ""),
                      customSpacerHeight(height: 8),
                      _leaveCountStyleLayout(),
                      customSpacerHeight(height: 20),
                      customTitleText(
                          text: AppString.text_from.tr, isRequired: true),
                      customSpacerHeight(height: 8),
                      const CustomTimePickerInTime(),
                      customSpacerHeight(height: 20),
                      customTitleText(
                          text: AppString.text_to.tr, isRequired: true),
                      customSpacerHeight(height: 8),
                      const CustomTimePickerOutTime(),
                      customSpacerHeight(height: 12),
                      customSpacerHeight(height: 18),
                      Obx(() => Row(
                            children: [
                              customTitleText(text: AppString.text_note.tr),
                              customSpacerWidth(width: 6),
                              Get.find<UpDateLeaveController>()
                                      .isNoteRequired
                                      .isTrue
                                  ? customTitleTextRedText(text: "*")
                                  : Container(),
                            ],
                          )),
                      customSpacerHeight(height: 8),
                      _noteTextField(),
                      Obx(() => Row(
                            children: [
                              customTitleText(text: AppString.text_document.tr),
                              customSpacerWidth(width: 6),
                              Get.find<UpDateLeaveController>()
                                      .isDocumentRequired
                                      .isTrue
                                  ? customTitleTextRedText(text: "*")
                                  : Container(),
                            ],
                          )),
                      customSpacerHeight(height: 6),
                      _pathFormatText(),
                      customSpacerHeight(height: 8),
                      AddAttachmentFile(
                        leaveRecords: leaveRecords,
                      ),
                      customSpacerHeight(height: 20),
                      Obx(() => Get.find<UpDateLeaveController>()
                              .isUpdateLeaveLoading
                              .isTrue
                          ? const Center(
                              child: CupertinoActivityIndicator(
                                color: Colors.blueAccent,
                                radius: 18,
                              ),
                            )
                          : CustomDoubleAppButton(
                              onAction: () {
                                if (_formKey.currentState!.validate() &&
                                    Get.find<UpDateLeaveController>()
                                        .leaveId
                                        .isNotEmpty) {
                                  if (Get.find<UpDateLeaveController>()
                                      .isDocumentRequired
                                      .isTrue) {
                                    if (Get.find<FileUploadController>()
                                        .storageForUpload
                                        .filePath
                                        .value
                                        .isNotEmpty) {
                                      _updateLeaveMethod();
                                    } else {
                                      Get.find<DateTimeController>()
                                          .isErrorOccurred(true);
                                    }
                                  } else {
                                    _updateLeaveMethod();
                                  }
                                } else {
                                  print("Method should not called");
                                }
                              },
                              buttonText: AppString.text_apply.tr,
                              cancelAction: () {
                                Navigator.pop(context);
                                Get.find<FileUploadController>()
                                    .storageForUpload
                                    .filePath
                                    .value = "";
                                Get.find<ApplyLeaveController>()
                                    .isUploadPolicyLoading
                                    .value = false;
                                Get.find<ApplyLeaveController>()
                                    .isFileUploadedSuccessfully
                                    .value = false;
                              },
                            )),
                      customSpacerHeight(height: 100),
                    ],
                  ),
                ),
              ),
            ),
        onLoading: const Center(
          child: CupertinoActivityIndicator(
            radius: 18,
            color: Colors.blueAccent,
          ),
        ));
  }

  _noteTextField() {
    return InputNote(
      validator: (value) {
        if (Get.find<UpDateLeaveController>().isNoteRequired.isTrue) {
          if (value!.isEmpty) {
            return "";
          } else {
            return null;
          }
        }
      },
      controller: leaveNoteController,
      hintText: AppString.text_add_note.tr,
    );
  }

  _pathFormatText() {
    return Text(
      AppString.text_jpeg_jpg_png_etc.tr,
      style: AppStyle.normal_text_black
          .copyWith(color: AppColor.hintColor.withOpacity(0.7)),
    );
  }

  _leaveCountStyleLayout() {
    return Obx(
        () => Get.find<UpDateLeaveController>().numberOfLeaves.value.isNotEmpty
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
                          Get.find<UpDateLeaveController>()
                              .numberOfLeaves
                              .value,
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
        Get.find<UpDateLeaveController>().calculateAllowanceOfLeave.value;
    switch (calculateAllowanceOfLeave) {
      case "no_of_application":
        return "Balance (No.of application)";
      case "undefined":
        return "Balance (Undefined)";
      default:
        return "Balance (No.of days)";
    }
  }

  void _updateLeaveMethod() {
    if (!DateTime.parse(Get.find<DateTimePickerController>().outDateTime.value)
        .difference(DateTime.parse(
            Get.find<DateTimePickerController>().inDateTime.value))
        .isNegative) {
      Get.find<UpDateLeaveController>().updateLeave(
        leaveId: leaveRecords?.id ?? "",
        leaveTypeId: Get.find<UpDateLeaveController>().leaveTypeId,
        startDate: Get.find<DateTimePickerController>().inDateTime.value,
        endDate: Get.find<DateTimePickerController>().outDateTime.value,

        ///dev
        size: leaveRecords?.files != null && leaveRecords!.files!.isNotEmpty
            ? leaveRecords!.files![0].size.toString()
            : "",
        name: leaveRecords?.files != null && leaveRecords!.files!.isNotEmpty
            ? leaveRecords!.files![0].name.toString()
            : "",
        key: leaveRecords?.files != null && leaveRecords!.files!.isNotEmpty
            ? leaveRecords!.files![0].key.toString()
            : "",
        id: leaveRecords?.files != null && leaveRecords!.files!.isNotEmpty
            ? leaveRecords!.files![0].id.toString()
            : "",
      );
    } else {
      showWarningMessage(message: AppString.dateDifferenceIssueMessage.tr);
    }
  }
}

class UpdateLeaveDropdown extends StatefulWidget {
  final String dropdownValue;

  const UpdateLeaveDropdown({required this.dropdownValue, super.key});

  @override
  State<UpdateLeaveDropdown> createState() => _UpdateLeaveDropdownState();
}

class _UpdateLeaveDropdownState extends State<UpdateLeaveDropdown> {
  String? dropDownValue;

  @override
  void initState() {
    dropDownValue = widget.dropdownValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(10)),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      child: DropdownButton(
          value: dropDownValue,
          dropdownColor: AppColor.cardColor,
          underline: const SizedBox.shrink(),
          isExpanded: true,
          items: Get.find<UpDateLeaveController>()
              .leaveTypeDropdownModel
              ?.getAvailableLeaveTypes!
              .map((e) {
            return DropdownMenuItem(
              value: e.leaveTypeId,
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getIconAccordingToLeaveType(e.type),
                    customSpacerWidth(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.name.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            e.type.toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColor.hintColor,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              dropDownValue = value as String;
            });
            GetAvailableLeaveTypes? getLeaveTypesDropdown =
                Get.find<UpDateLeaveController>()
                    .leaveTypeDropdownModel
                    ?.getAvailableLeaveTypes
                    ?.firstWhere((element) => element.leaveTypeId == value);

            Get.find<UpDateLeaveController>().numberOfLeaves.value =
                getLeaveTypesDropdown?.availableLeave ?? "0";
            Get.find<UpDateLeaveController>().calculateAllowanceOfLeave.value =
                getLeaveTypesDropdown?.calculateAllowanceBy ?? "";

            Get.find<UpDateLeaveController>().leaveTypeId = value ?? "";
            Get.find<UpDateLeaveController>().isDocumentRequired.value =
                getLeaveTypesDropdown?.attachDocumentRequired ?? false;
            Get.find<UpDateLeaveController>().isNoteRequired.value =
                getLeaveTypesDropdown?.addNoteRequired ?? false;
          }),
    );
  }
}

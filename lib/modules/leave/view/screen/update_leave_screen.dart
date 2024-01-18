import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/common/widget/timePicker/custom_time_picker_in_time.dart';
import 'package:payrun_mobile/common/widget/timePicker/custom_time_picker_out_time.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
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
import '../../controller/file_upload_controller.dart';
import '../../model/leave_type.dart';

class UpdateLeave extends GetView<UpDateLeaveController> {
  GetLeaveRecords? leaveRecords;

  UpdateLeave({super.key, this.leaveRecords});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Column(
              children: [
                customButtonSheetAppbar(
                    text: DateTime.parse(leaveRecords!.startDate!).day ==
                            DateTime.parse(leaveRecords!.endDate!).day
                        ? DateFormat('d MMMM').format(DateTime.parse(
                            leaveRecords?.startDate ??
                                DateTime.now().toString()))
                        : "${DateFormat('d MMMM').format(DateTime.parse(leaveRecords?.startDate ?? DateTime.now().toString()))}- ${DateFormat('d MMMM').format(DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()))}",
                    subtext: DateTime.parse(leaveRecords!.startDate!).day ==
                            DateTime.parse(leaveRecords!.endDate!).day
                        ? DateFormat('EEEE').format(DateTime.parse(
                            leaveRecords?.startDate ??
                                DateTime.now().toString()))
                        : "${DateFormat('EEEE').format(DateTime.parse(leaveRecords?.startDate ?? DateTime.now().toString()))} - ${DateFormat('EEEE').format(DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()))}"),
                Expanded(
                    child: UpdateLeaveButtonLayout(leaveRecords: leaveRecords))
              ],
            ),
        onLoading: const LoadingIndicator());
  }
}

class UpdateLeaveButtonLayout extends StatelessWidget {
  final GetLeaveRecords? leaveRecords;

  UpdateLeaveButtonLayout({super.key, this.leaveRecords});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _updateDateFromResponse();
    return Padding(
      padding: marginLayout.copyWith(top: Dimensions.fontSizeMid),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTitleText(
                  text: AppString.text_leave_type.tr, isRequired: true),
              customSpacerHeight(height: 8),

              UpdateLeaveDropdown(
                  dropdownValue: leaveRecords?.leaveType?.leaveId ?? ""),

              customSpacerHeight(height: 8),
              _leaveCountStyleLayout(),
              customSpacerHeight(height: 20),
              customTitleText(text: AppString.text_from.tr, isRequired: true),
              customSpacerHeight(height: 8),
              const CustomTimePickerInTime(),
              customSpacerHeight(height: 20),
              customTitleText(text: AppString.text_to.tr, isRequired: true),
              customSpacerHeight(height: 8),
              const CustomTimePickerOutTime(),
              customSpacerHeight(height: 12),
              // _errorAlertLayout(),
              customSpacerHeight(height: 18),
              Obx(() => Row(
                    children: [
                      customTitleText(text: AppString.text_note.tr),
                      customSpacerWidth(width: 6),
                      Get.find<UpDateLeaveController>().isNoteRequired.isTrue
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
               AddAttachmentFile(),
              customSpacerHeight(height: 20),
              Obx(() =>
                  Get.find<UpDateLeaveController>().isUpdateLeaveLoading.isTrue
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
                          },
                        )),
              customSpacerHeight(height: 100),
            ],
          ),
        ),
      ),
    );
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
      AppString.text_jpeg_jpg_png_etc,
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
                          "Balance (No.of days)",
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

  void _updateLeaveMethod() {
    Get.find<UpDateLeaveController>().updateLeave(
        leaveId: leaveRecords?.id ?? "",
        leaveTypeId: Get.find<UpDateLeaveController>().leaveTypeId,
        startDate: Get.find<DateTimePickerController>().inDateTime.value,
        endDate: Get.find<DateTimePickerController>().outDateTime.value);
  }

  void _updateDateFromResponse() {
    Get.find<UpDateLeaveController>().leaveId = leaveRecords?.id ?? '';
    Get.find<UpDateLeaveController>().leaveTypeId =
        leaveRecords?.leaveType?.leaveId ?? "";
    Get.find<DateTimePickerController>().inTime.value = DateFormat('HH:mm:ss')
        .format(DateTime.parse(
            leaveRecords?.startDate ?? DateTime.now().toString()));
    Get.find<DateTimePickerController>().inDate.value = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(
            leaveRecords?.startDate ?? DateTime.now().toString()));
    Get.find<DateTimePickerController>().outTime.value = DateFormat('HH:mm:ss')
        .format(
            DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()));
    Get.find<DateTimePickerController>().outDate.value =
        DateFormat('yyyy-MM-dd').format(
            DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()));

    Get.find<DateTimePickerController>().getInDateTime();
    Get.find<DateTimePickerController>().getOutDateTime();

    leaveNoteController.text = leaveRecords?.description ?? "";
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
              .leaveTypeDropdown!
              .getLeaveTypesDropdown!
              .map((e) {
            return DropdownMenuItem(
              value: e.id,
              child: Text(e.name.toString()),
            );
          }).toList(),
          onChanged: (value) {
            print("value::: $value");
            setState(() {
              dropDownValue = value as String;
            });
            GetLeaveTypesDropdown? getLeaveTypesDropdown =
                Get.find<UpDateLeaveController>()
                    .leaveTypeDropdown
                    ?.getLeaveTypesDropdown
                    ?.firstWhere((element) => element.id == value);

            //set data according to leave type
            Get.find<UpDateLeaveController>().numberOfLeaves.value =
                getLeaveTypesDropdown?.leaveStatuses?[0].availableNumberOfDays
                        .toString() ??
                    "";
            Get.find<UpDateLeaveController>().leaveTypeId = value ?? "";
            Get.find<UpDateLeaveController>().isDocumentRequired.value =
                getLeaveTypesDropdown?.attachDocumentRequired ?? false;
            Get.find<UpDateLeaveController>().isNoteRequired.value =
                getLeaveTypesDropdown?.addNoteRequired ?? false;
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/modules/leave/model/leave_records.dart';

import '../../../../common/controller/date_time_helper_controller.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/controller/apply_leave_controller.dart';
import 'package:payrun_mobile/modules/leave/view/widget/add_attachemnt_file_widget.dart';
import 'package:payrun_mobile/modules/leave/view/widget/custom_title_text_widget.dart';
import 'package:payrun_mobile/modules/leave/view/widget/single_date_picker_calendar.dart';
import 'package:payrun_mobile/modules/leave/view/widget/srart_time_field_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../controller/file_upload_controller.dart';
import '../../model/leave_type.dart';
import 'date_pickar_field_widget.dart';

class UpdateLeave extends StatelessWidget {
  GetLeaveRecords? leaveRecords;

  UpdateLeave({super.key, this.leaveRecords});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<DateTimeController>()) {
      Get.delete<DateTimeController>();
    }
    Get.put(DateTimeController());
    return Column(
      children: [
        customButtonSheetAppbar(
            text: AppString.updateLeaveTest.tr,
            subtext: DateTime.parse(leaveRecords!.startDate!).day ==
                    DateTime.parse(leaveRecords!.endDate!).day
                ? dateMonthYearFormatFromDatetime(leaveRecords!.startDate!)
                : "${dateMonthYearFormatFromDatetime(leaveRecords!.startDate!)} - ${dateMonthYearFormatFromDatetime(leaveRecords!.endDate!)}"),
        Expanded(child: UpdateLeaveButtonLayout(leaveRecords: leaveRecords))
      ],
    );
  }
}

class UpdateLeaveButtonLayout extends StatelessWidget {
  final GetLeaveRecords? leaveRecords;

  UpdateLeaveButtonLayout({super.key, this.leaveRecords});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.find<DateTimeController>().leaveId?.value == leaveRecords?.id;
    Get.find<DateTimeController>().requestedInDate.value =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(
            leaveRecords?.startDate ?? DateTime.now().toString()));
    Get.find<DateTimeController>().requestedOutDate.value =
        DateFormat('yyyy-MM-dd').format(
            DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString()));
    leaveNoteController.text = leaveRecords?.description ?? "";

    DateTime startTime =
        DateTime.parse(leaveRecords?.startDate ?? DateTime.now().toString());
    DateTime endTime =
        DateTime.parse(leaveRecords?.endDate ?? DateTime.now().toString());

    Get.find<DateTimeController>().pickedInTime.value =
        "${startTime.hour}:${startTime.minute} ${startTime.hour > 11 ? "PM" : "AM"}";
    Get.find<DateTimeController>().pickedOutTime.value =
        "${endTime.hour}:${endTime.minute} ${startTime.hour > 11 ? "PM" : "AM"}";

    return Obx(() => Get.find<ApplyLeaveController>().isLoading.isFalse
        ? Padding(
            padding: marginLayout.copyWith(top: Dimensions.fontSizeMid),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customTitleText(text: AppString.text_leave_type.tr),
                    customSpacerHeight(height: 8),
                    UpdateLeaveDropdown(
                        dropdownValue: leaveRecords?.leaveType?.leaveId ?? ""),
                    customSpacerHeight(height: 8),
                    _leaveCountStyleLayout(),
                    customSpacerHeight(height: 20),
                    customTitleText(text: "${AppString.text_from.tr} *"),
                    customSpacerHeight(height: 8),
                    Obx(
                      () => _fromDateTimeLayout(),
                    ),
                    customSpacerHeight(height: 20),
                    customTitleText(text: "${AppString.text_to.tr} *"),
                    customSpacerHeight(height: 8),
                    Obx(
                      () => _toDateTimeLayout(),
                    ),
                    customSpacerHeight(height: 12),
                    // _errorAlertLayout(),
                    customSpacerHeight(height: 18),
                    Obx(() => Row(
                          children: [
                            customTitleText(text: AppString.text_note.tr),
                            customSpacerWidth(width: 6),
                            Get.find<DateTimeController>().isNoteRequired.isTrue
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
                            Get.find<DateTimeController>()
                                    .isDocumentRequired
                                    .isTrue
                                ? customTitleTextRedText(text: "*")
                                : Container(),
                          ],
                        )),
                    customSpacerHeight(height: 6),
                    _pathFormatText(),
                    customSpacerHeight(height: 8),
                    const AddAttachmentFile(),
                    customSpacerHeight(height: 20),
                    Obx(() => Get.find<ApplyLeaveController>()
                            .isAssignLeaveLoaderLoading
                            .isTrue
                        ? const Center(
                            child: CupertinoActivityIndicator(
                              color: Colors.blueAccent,
                              radius: 18,
                            ),
                          )
                        : CustomDoubleAppButton(
                            onAction: () {
                              if (_formKey.currentState!.validate()) {
                                if (Get.find<DateTimeController>()
                                    .isDocumentRequired
                                    .isTrue) {
                                  if (Get.find<FileUploadController>()
                                      .storageForUpload
                                      .filePath
                                      .value
                                      .isNotEmpty) {
                                    Get.find<ApplyLeaveController>()
                                        .applyLeave();
                                  } else {
                                    Get.find<DateTimeController>()
                                        .isErrorOccurred(true);
                                  }
                                } else {
                                  Get.find<ApplyLeaveController>().applyLeave();
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
          )
        : const Center(
            child: CupertinoActivityIndicator(
                color: Colors.blueAccent, radius: 18),
          ));
  }

  _noteTextField() {
    return InputNote(
      validator: (value) {
        if (Get.find<DateTimeController>().isNoteRequired.isTrue) {
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

  _fromDateTimeLayout() {
    return Row(
      children: [
        Expanded(
            child: dateLayoutField(
                date: Get.find<DateTimeController>().requestedInDate.toString(),
                onAction: () {
                  showDialog(
                    context: Get.context!,
                    builder: (context) {
                      return const Dialog(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          insetPadding: EdgeInsets.zero,
                          child: FromDatePicker());
                    },
                  );
                })),
        customSpacerWidth(width: 14),
        Expanded(
            child: startTimeFieldLayout(context: Get.context!)),
      ],
    );
  }

  _toDateTimeLayout() {
    return Row(
      children: [
        Expanded(
            child: dateLayoutField(
                date:
                    Get.find<DateTimeController>().requestedOutDate.toString(),
                onAction: () {
                  showDialog(
                    context: Get.context!,
                    builder: (context) {
                      return const Dialog(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          insetPadding: EdgeInsets.zero,
                          child: ToDatePiker());
                    },
                  );
                })),
        customSpacerWidth(width: 14),
        Expanded(
            child: outTimeFieldLayout(context: Get.context!)),
      ],
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
        () => Get.find<DateTimeController>().numberOfLeaves.value.isNotEmpty
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
                          Get.find<DateTimeController>().numberOfLeaves.value,
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

  _errorAlertLayout() {
    return SizedBox(
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder,
        color: AppColor.errorColorLight.withOpacity(0.08),
        child: Column(
          children: [
            Row(
              children: [
                customSpacerWidth(width: 12),
                const Icon(
                  Icons.error_outline,
                  color: AppColor.errorColorLight,
                  size: 18,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        marginLayout.copyWith(bottom: 12, top: 12, left: 12),
                    child: Text(
                      "Out of balance.The selected leave duration is out of the facility.Tou may have some Taken,approved or pending leave that affect your new request.",
                      style: AppStyle.mid_large_text.copyWith(
                          color: AppColor.errorColorLight,
                          fontSize: Dimensions.fontSizeDefault - 2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
          items: Get.find<ApplyLeaveController>()
              .leaveTypeDropdown!
              .getLeaveTypesDropdown!
              .map((e) {
            return DropdownMenuItem(
              value: e.id,
              child: Text(e.name.toString().toUpperCase()),
            );
          }).toList(),
          onChanged: (value) {
            print("value::: $value");
            setState(() {
              dropDownValue = value as String;
            });
            GetLeaveTypesDropdown? getLeaveTypesDropdown =
                Get.find<ApplyLeaveController>()
                    .leaveTypeDropdown
                    ?.getLeaveTypesDropdown
                    ?.firstWhere((element) => element.id == value);

            //set data according to leave type
            Get.find<DateTimeController>().numberOfLeaves.value =
                getLeaveTypesDropdown?.leaveStatuses?[0].availableNumberOfDays
                        .toString() ??
                    "";
            Get.find<DateTimeController>().leaveId?.value == value;
            Get.find<DateTimeController>().isDocumentRequired.value =
                getLeaveTypesDropdown?.attachDocumentRequired ?? false;
            Get.find<DateTimeController>().isNoteRequired.value =
                getLeaveTypesDropdown?.addNoteRequired ?? false;
          }),
    );
  }
}

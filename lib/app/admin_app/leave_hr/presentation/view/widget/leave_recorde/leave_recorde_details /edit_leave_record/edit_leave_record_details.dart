import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/view/widget/leave_recorde/leave_recorde_details%20/edit_leave_record/attachment.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../../../common/widget/custom_double_app_button.dart';
import '../../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../../common/widget/input_note.dart';
import '../../../../../../../../../common/widget/timePicker/custom_time_picker_in_time.dart';
import '../../../../../../../../../common/widget/timePicker/custom_time_picker_out_time.dart';
import '../../../../../../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../../../../../../utils/app_color.dart';
import '../../../../../../../../../utils/app_style.dart';
import '../../../../../../../../../utils/dimensions.dart';
import '../../../../../../../employee/presentation/view/widget/employee_profile_view/leave_summary/leave_allowance/selecte_leave_type.dart';
import '../../../../../controller/leave_controller.dart';
import '../../../../../controller/picked_file_from_stroage.dart';
import '../leave_record_details.dart';

/// A widget that displays and edits leave record details.
class EditLeaveRecordDetails extends StatelessWidget {
  /// The leave record details model containing information about a specific leave.
  final LeaveRecordDetailsModel leaveRecordDetailsModel;

  /// Constructor for the [EditLeaveRecordDetails] widget.
  const EditLeaveRecordDetails(
      {super.key, required this.leaveRecordDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Builds the header with a static date and day.
        _buildHeader(date: "26 March", day: "Thursday"),
        /// Builds the list of text fields for various leave record details.
        _buildListOfTextField(context),
      ],
    );
  }

  /// Builds a scrollable list of form fields for editing leave record details.
  Widget _buildListOfTextField(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Displays the title and a required leave type dropdown.
              _buildTitleText(text: AppString.text_leave_name.tr, isRequired: true),
              customSpacerHeight(height: 8),
             // const SelectedLeaveType(),
              customSpacerHeight(height: 20),

              /// Displays the title and a date picker for the "From" date.
              _buildTitleText(text: AppString.text_from.tr, isRequired: true),
              customSpacerHeight(height: 8),
              _buildFromDateWithTime(context),
              customSpacerHeight(height: 20),

              /// Displays the title and a date picker for the "To" date.
              _buildTitleText(text: AppString.text_to.tr, isRequired: true),
              customSpacerHeight(height: 8),
              _buildToDateWithTime(context),
              customSpacerHeight(height: 20),

              /// Displays the title and a status selection tab.
              _buildTitleText(text: AppString.text_status.tr),
              customSpacerHeight(height: 8),
              _buildStatusTabSelector(),
              customSpacerHeight(height: 20),

              /// Displays the title and a note input field.
              _buildTitleText(text: AppString.text_note.tr),
              customSpacerHeight(height: 8),
              _buildNote(),
              customSpacerHeight(height: 20),

              /// Displays the title and an attachment input.
              _buildTitleText(text: AppString.text_document.tr),
              const AddAttachmentFile(),
              customSpacerHeight(height: 20),

              /// Displays the action buttons.
              CustomDoubleAppButton(
                  onAction: () {},
                  cancelAction: () {
                    /// Clears the file upload path and navigates back.
                    Get.find<LeaveFileUploadController>().path.value = "";
                    Get.back(canPop: false);
                  }),
              customSpacerHeight(height: 100),
            ],
          ),
        ),
      ),
    );
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
          border: Border.all(
              width: 1, color: AppColor.hintColor.withOpacity(0.5)),
        ),
        child: ListView.builder(
          itemCount: leaveController.statusOptions.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Obx(() {
              // Checks if the current index is selected.
              final isSelected =
                  index == leaveController.selectedStatusIndex.value;
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
      controller: TextEditingController(),
      hintText: AppString.text_add_note.tr,
      borderColor: AppColor.hintColor.withOpacity(0.5),
      onChanged: (value) {},
    );
  }
}


Widget _buildFromDateWithTime(BuildContext context) {
  return Row(
    children: [
      Expanded(
          child: GestureDetector(
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InDatePicker(),
                  ],
                ),
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: AppColor.hintColor.withOpacity(0.5), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(
                    DateFormat('yyyy-MM-dd').format(DateTime.parse(
                        Get.find<DateTimePickerController>().inDateTime.value)),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  )),
              const Icon(
                CupertinoIcons.calendar,
                color: Colors.grey,
                size: 28,
              ),
            ],
          ),
        ),
      )),
      customSpacerWidth(width: 12),
      _fromTimePicker(context)
    ],
  );
}

Widget _buildToDateWithTime(BuildContext context) {
  return SizedBox(
    child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        OutDatePicker(),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: AppColor.hintColor.withOpacity(0.5), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    final dateTime =
                        Get.find<DateTimePickerController>().outDateTime.value;
                    final parsedDate =
                        DateTime.tryParse(dateTime) ?? DateTime.now();
                    final formattedDate =
                        DateFormat('yyyy-MM-dd').format(parsedDate);
                    return Text(formattedDate,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16));
                  }),
                  const Icon(Icons.calendar_today_outlined,
                      color: Colors.grey, size: 24),
                ],
              ),
            ),
          ),
        ),
        customSpacerWidth(width: 12),
        _toTimePicker(context)
      ],
    ),
  );
}

_fromTimePicker(BuildContext context) {
  return Expanded(
    child: Obx(() {
      final inDateTime = Get.find<DateTimePickerController>().inDateTime.value;
      final inDate = Get.find<DateTimePickerController>().inDate.value;
      final outDate = Get.find<DateTimePickerController>().outDate.value;

      return GestureDetector(
        onTap: () {
          if (inDate == outDate) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => Dialog(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InTimePicker(),
                    ],
                  ),
                ),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: AppColor.hintColor.withOpacity(0.5), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat('HH:mm').format(DateTime.parse(inDateTime)),
                style: TextStyle(
                    color: inDate == outDate ? Colors.black : Colors.grey,
                    fontSize: 16),
              ),
              const Icon(
                CupertinoIcons.clock,
                color: Colors.grey,
                size: 25,
              ),
            ],
          ),
        ),
      );
    }),
  );
}

_toTimePicker(BuildContext context) {
  return Expanded(child: Obx(() {
    final outDataTime = Get.find<DateTimePickerController>().outDateTime.value;
    final inDate = Get.find<DateTimePickerController>().inDate.value;
    final outDate = Get.find<DateTimePickerController>().outDate.value;
    return GestureDetector(
      onTap: () {
        if (inDate == outDate) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutTimePicker(),
                  ],
                ),
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border:
              Border.all(color: AppColor.hintColor.withOpacity(0.5), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat('HH:mm').format(DateTime.parse(outDataTime)),
              style: TextStyle(
                  color: inDate == outDate ? Colors.black : Colors.grey,
                  fontSize: 16),
            ),
            const Icon(
              CupertinoIcons.clock,
              color: Colors.grey,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }));
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

Widget _buildHeader({String? date, String? day}) {
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
          date ?? "",
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.secondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.fontSizeDefault + 2,
          ),
        ),
        Text(
          day ?? "",
          style: AppStyle.small_text_black.copyWith(
            color: AppColor.hintColor,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

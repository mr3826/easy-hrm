import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../../common/widget/timePicker/custom_time_picker_in_time.dart';
import '../../../../../../../../../common/widget/timePicker/custom_time_picker_out_time.dart';
import '../../../../../../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../../../../../../utils/app_color.dart';
import '../../../../../../../../../utils/app_style.dart';
import '../../../../../../../../../utils/dimensions.dart';
import '../../../../../../../employee/presentation/view/widget/employee_profile_view/leave_summary/leave_allowance/selecte_leave_type.dart';
import '../leave_record_details.dart';

class EditLeaveRecordDetails extends StatelessWidget {
  final LeaveRecordDetailsModel leaveRecordDetailsModel;

  const EditLeaveRecordDetails(
      {super.key, required this.leaveRecordDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(date: "26 March", day: "Thursday"),
        _buildListOfTextField(context),
      ],
    );
  }

  _buildListOfTextField(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText(text: AppString.text_leave_name.tr, isRequired: true),
          customSpacerHeight(height: 8),
          const SelectedLeaveType(),
          customSpacerHeight(height: 20),
          _buildTitleText(text: AppString.text_from.tr, isRequired: true),
          customSpacerHeight(height: 8),
          _buildFromDateWithTime(context) ,
          customSpacerHeight(height: 20),

          _buildTitleText(text: AppString.text_to.tr, isRequired: true),

          customSpacerHeight(height: 8),
          _buildToDateWithTime(context)
        ],
      ),
    );
  }
}

Widget _buildFromDateWithTime(BuildContext context) {
  return SizedBox(
   // height: AppLayout.getHeight(52),
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
        _fromTimePicker(context)
      ],
    ),
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
      final inDateTime =
          Get.find<DateTimePickerController>().inDateTime.value;
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 8),
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
  return Expanded(
    child: Obx(() {
      final inDateTime =
          Get.find<DateTimePickerController>().inDateTime.value;
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 8),
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

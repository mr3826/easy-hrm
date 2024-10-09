import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../common/widget/employee/custom_contact_info.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../../profile/view/widget/expanded_text_layout.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../../../timeline/view/widget/timeline_calendar.dart';
import 'department_history.dart';
import 'department_layout.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ExpandedText(
              text:
                  "Publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface n publishing ana typeface ",
            ),
            customSpacerHeight(height: 15),
            CustomContactInfoWidget(
              staticText: AppString.text_email.tr,
              dynamicText: "",
            ),
            customSpacerHeight(height: 15),
            CustomContactInfoWidget(
              staticText: AppString.text_phone.tr,
              dynamicText: "",
            ),
            customSpacerHeight(height: 15),
            CustomContactInfoWidget(
              staticText: AppString.text_address.tr,
              dynamicText: "",
            ),
            customSpacerHeight(height: 15),

            DepartmentLayout(

              departmentModel: DepartmentModel(
                departmentName: "Laravel Department",
                parentDepartmentName:
                    "${AppString.text_child_of_deparmtnet.tr} Main department",
                workShiftStartTime: "09:00:00",
                workShiftEndTime: "17:00:00",
                workShiftName: "Regular Worksheet",
                startDate: "2021-10-09 15:15:58",
                workingDays: const [
                  {"day": "friday", "holiday": true},
                  {"day": "saturday", "holiday": true},
                  {"day": "sunday", "holiday": false},
                  {"day": "monday", "holiday": false},
                  {"day": "tuesday", "holiday": false},
                  {"day": "wednesday", "holiday": false},
                  {"day": "thursday", "holiday": false},
                ],

                onAction: (){customAntButtonSheet(context: context, child: const DepartmentHistoryForEmployee());}
              ),



            )
          ],
        ),
      ),
    );
  }
}

Widget departmentLayout(BuildContext? context) {
  return SizedBox(
    height: AppLayout.getHeight(289),
    child: Card(
      elevation: 0,
      shape: roundedRectangleBorder,
      color: AppColor.bgColorWithPrimary.withOpacity(0.3),
      child: Padding(
        padding: marginLayout.copyWith(top: 12, bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSvgImage(
                imageUrl: Images.departmentNotification,
                color: AppColor.primaryColor,
                height: 25,
                width: 25),
            customSpacerHeight(height: 12),
            _departmentHistoryInfo(context),
            customSpacerHeight(height: 12),
            _workingShiftLayout(context),
          ],
        ),
      ),
    ),
  );
}

_departmentHistoryInfo(context) {
  return GestureDetector(
    onTap: () {
      //  customAntButtonSheet(context: context, child: const DepartmentHistory());
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Laravel Department",
          style:
              AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _parentDepartmentInfo(
                parentDepartmentName:
                    "${AppString.text_child_of_deparmtnet.tr} Main department"),
            Expanded(
              child: Text(
                "${AppString.text_from.tr} - ${getDateTimeFormat("2021-10-09 15:15:58")}",
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    fontSize: Dimensions.fontSizeDefault - 2,
                    overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ],
    ),
  );
}

_workingShiftLayout(context) {
  return Expanded(
    child: Row(
      children: [
        _verticalDivider(),
        customSpacerWidth(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Regular Worksheet",
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            ),
            _workShiftDetailsLayout(),
            customSpacerHeight(height: 8),
            Text(
              AppString.text_working_day.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: Dimensions.fontSizeDefault + 1),
            ),
            _workingDaySchedule(context)
          ],
        ),
      ],
    ),
  );
}

getDateTimeFormat(dateString) {
  if (dateString.isEmpty) return "";
  DateTime dateTime = DateTime.parse(dateString);
  // Format the DateTime to "dd, MMM"
  return DateFormat('dd MMM, yyyy').format(dateTime);
}

_parentDepartmentInfo({required String parentDepartmentName}) {
  return Row(
    children: [
      Text(
        parentDepartmentName,
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.secondaryColor,
            fontSize: Dimensions.fontSizeDefault - 1),
      ),
      if (parentDepartmentName.isNotEmpty) _divider(),
    ],
  );
}

_verticalDivider() {
  return Container(
    width: 1,
    height: double.infinity,
    color: AppColor.hintColor.withOpacity(0.4),
  );
}

_workShiftDetailsLayout() {
  return Row(
    children: [
      Text(
        "${amPmFormatTimeFromString('09:00:00')} - ${amPmFormatTimeFromString("17:00:00")}",
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeDefault + 1,
            overflow: TextOverflow.ellipsis),
      ),
      _divider(),
      GestureDetector(
        onTap: () {},
        child: Text(
          getTimeDifference("09:00:00", "17:00:00"),
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor.withOpacity(0.7),
              fontSize: Dimensions.fontSizeDefault - 1,
              overflow: TextOverflow.ellipsis),
        ),
      )
    ],
  );
}

_workingDaySchedule(context) {
  List<Map<String, dynamic>> days = [
    {
      "day": "friday",
      "holiday": true,
    },
    {
      "day": "saturday",
      "holiday": true,
    },
    {
      "day": "sunday",
      "holiday": false,
    },
    {
      "day": "monday",
      "holiday": false,
    },
    {
      "day": "tuesday",
      "holiday": false,
    },
    {
      "day": "wednesday",
      "holiday": false,
    },
    {
      "day": "thursday",
      "holiday": false,
    },
  ];
  return SizedBox(
    height: AppLayout.getHeight(76),
    width: MediaQuery.of(context).size.width / 1.5,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: days.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 0.0, right: 30, top: 12, bottom: 12),
          child: Column(
            children: [
              customSpacerWidth(width: 8),
              Text(
                getDayAbbreviation(days[index]["day"]),
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeDefault,
                    overflow: TextOverflow.ellipsis),
              ),
              days[index]["holiday"] == true
                  ? const Icon(
                      Icons.close,
                      color: AppColor.errorColor,
                    )
                  : const Icon(
                      Icons.done,
                      color: AppColor.successColor,
                    ),
            ],
          ),
        );
      },
    ),
  );
}

_divider() {
  return Padding(
    padding: marginLayout.copyWith(left: 8, right: 8),
    child: Container(width: 1, height: 12, color: AppColor.hintColor),
  );
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../../../../../common/controller/convart_color_code_controller.dart';
import '../../../../../../../../common/widget/employee/department_info_widget.dart';
import '../../../../../../../../common/widget/employee/dottend_style_layout.dart';
import '../../../../../../../../utils/utils.dart';
import '../../../../../../../auth/presentation/view/otp_screen.dart';

/// [EmploymentHistoryLayout] displays the employment status history of an employee.
class EmploymentHistoryLayout extends StatelessWidget {
  const EmploymentHistoryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for department history
    final List<Map<String, String>> employmentHistoryData = [
      {
        "status": "Permanent",
        "startDate": "2014-10-07 15:15:58",
        "endDate": "",
        "color": "0CAA1B"
      },
      {
        "status": "Probation",
        "startDate": "2014-10-07 15:15:58",
        "endDate": "2024-10-07 15:15:58",
        "color": "FFA500"
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom App Bar for Employment History
        customButtonSheetAppbar(
            text: AppString.text_employment.tr,
            subtext: AppString.text_history.tr),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: employmentHistoryData.length,
            itemBuilder: (context, index) {
              final item = employmentHistoryData[index];
              final isLastItem = index == employmentHistoryData.length - 1;

              return _statusInfo(
                isLastItem: isLastItem,
                status: item["status"] ?? '',
                startDate: getDateTimeFormat(item["startDate"] ?? ""),
                duration: _getDuration(item),
                endDate: _getEndDate(item),
                statusColor: HexColor(item["color"] ?? "#8F99AD"),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getDuration(Map<String, String> item) {
    final endDate = item["endDate"];
    return "${endDate == null || endDate.isEmpty ? AppString.text_form_last.tr : ""} ${workingTimeSinceFormString(
      item["startDate"] ?? "",
      endDate ?? "",
    )}";
  }

  String _getEndDate(Map<String, String> item) {
    final endDate = item["endDate"];
    return (endDate == null || endDate.isEmpty)
        ? AppString.textPresent.tr
        : dateMonthYearFormatFromDatetime(endDate);
  }
}

Widget _statusInfo({
  required String status,
  required String startDate,
  required String duration,
  required Color statusColor,
  required bool isLastItem,
  required String endDate,
}) {
  final textStyle = AppStyle.mid_large_text.copyWith(
    fontSize: Dimensions.fontSizeDefault - 2,
    overflow: TextOverflow.ellipsis,
  );

  return Stack(
    children: [
      Padding(
        padding: marginLayout.copyWith(top: 26, bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _flagIcon(),
            customSpacerWidth(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statusNameWithColor(status, statusColor),
                  customSpacerHeight(height: 4),
                  Wrap(
                    children: [
                      Text(
                        "$startDate - ", // Start date text
                        style: textStyle.copyWith(color: AppColor.hintColor),
                      ),
                      Text(
                        endDate, // End date text or "Present"
                        style: textStyle.copyWith(color: AppColor.primaryColor),
                      ),
                      _divider(), // Divider between dates and duration
                      Text(
                        duration, // Displays the duration of employment
                        style: textStyle.copyWith(color: AppColor.hintColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Dotted line for separating items if it's not the last item.
      if (!isLastItem)
        const Positioned(
          top: 55,
          left: 1,
          bottom: 0,
          child: DottedStyleLayout(height: 46,isVertical: true,),
        ),
    ],
  );
}

Widget _statusNameWithColor(String status, Color statusColor) {
  return Row(
    children: [
      Text(
        status, // Displays the employment status
        style: AppStyle.normal_text_grey.copyWith(
          color: AppColor.normalTextColor,
          fontSize: Dimensions.fontSizeMid - 2,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      customSpacerWidth(width: 8),
      Icon(
        Icons.circle, // Indicator for status color
        color: statusColor,
        size: 12,
      ),
    ],
  );
}

Widget _flagIcon() {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0),
    child: customSvgImage(
      imageUrl: Images.FLAG, // Icon representing the employment status
      color: AppColor.normalTextColor,
      height: 18,
      width: 18,
    ),
  );
}

Widget _divider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.0),
    child: Container(
      width: 1, // Width of the divider
      color: AppColor.hintColor, // Color of the divider
      height: 16, // Height of the divider
    ),
  );
}

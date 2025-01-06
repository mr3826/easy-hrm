import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/employee/presentation/controller/employment_controller.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/profile/model/employee_work_history.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../../../../../../common/controller/convart_color_code_controller.dart';
import '../../../../../../../../../common/widget/employee/department_info_widget.dart';
import '../../../../../../../../../common/widget/employee/dottend_style_layout.dart';
import '../../../../../../../../../modules/auth/presentation/view/otp_screen.dart';
import '../../../../../../../../../utils/utils.dart';

/// [EmploymentHistoryLayout] displays the employment status history of an employee.
class EmploymentHistoryLayout extends GetView<EmploymentController> {
  const EmploymentHistoryLayout({super.key});

  @override
  Widget build(BuildContext context) {
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
            itemCount: controller.employeeWorkHistory
                    ?.getOrganizationUserHistory?.employmentHistories?.length ??
                0,
            itemBuilder: (context, index) {
              List<EmploymentHistories>? employmentHistories = controller
                  .employeeWorkHistory
                  ?.getOrganizationUserHistory
                  ?.employmentHistories;
              bool isLastItem = true;
              if (employmentHistories != null &&
                  employmentHistories.isNotEmpty) {
                isLastItem = index == employmentHistories.length - 1;
              }

              final item = employmentHistories?[index];

              return _statusInfo(
                isLastItem: isLastItem,
                status: item?.employmentStatus?.name ?? '',
                startDate: getDateTimeFormat(item?.startDate ?? ""),
                duration: _buildDurationText(
                    startDate: item?.startDate ?? '',
                    endDate: item?.endDate ?? ''),
                endDate: _getEndDate(item?.endDate ?? ''),
                statusColor:
                    HexColor(item?.employmentStatus?.color ?? "#8F99AD"),
              );
            },
          ),
        ),
      ],
    );
  }


  /// Builds the duration text by calculating the time between start and end dates.
  /// If endDate is empty or null, it assumes the present time.
  String _buildDurationText({required String startDate, String? endDate}) {
    if (startDate.isEmpty) return '';
    return (endDate == null || endDate.isEmpty)
        ? "${AppString.text_form_last.tr} ${workingTimeSinceFormString(startDate, null)}"
        : workingTimeSinceFormString(startDate, endDate);
  }

  String _getEndDate(String endDate) {
    if (endDate.isEmpty) return AppString.textPresent.tr;
    return (endDate.isEmpty)
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
          left: 28,
          bottom: 0,
          child: CustomDottedStyle(
            height: 46,
            isVertical: true,
          ),
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

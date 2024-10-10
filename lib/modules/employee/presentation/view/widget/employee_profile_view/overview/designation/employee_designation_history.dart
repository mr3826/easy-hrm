import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/profile/view/widget/dotted_style_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';

import '../../../../../../../auth/presentation/view/otp_screen.dart';

class DesignationHistoryLayout extends StatelessWidget {
  const DesignationHistoryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for department history
    final List<Map<String, String>> designationHistory = [
      {
        "designation": "Senior Developer",
        "startDate": "2014-10-07 15:15:58",
        "endDate": ""
      },
      {
        "designation": "Jr. Developer",
        "startDate": "2021-10-07 15:15:58",
        "endDate": "2024-10-07 15:15:58"
      },
      {
        "designation": "QA Developer",
        "startDate": "2021-10-07 15:15:58",
        "endDate": "2024-10-07 15:15:58"
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom app bar for designation history
        customButtonSheetAppbar(
          text: AppString.text_designation.tr,
          subtext: AppString.text_history.tr,
        ),
        // Display designation history using ListView.builder
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: designationHistory.length,
            itemBuilder: (context, index) {
              final isLastItem = index == designationHistory.length - 1;
              final historyItem = designationHistory[index];
              final designation = historyItem["designation"] ?? "";
              final startDate = historyItem["startDate"]!;
              final endDate = historyItem["endDate"] ?? "";
              final formattedStartDate = _formatDate(startDate);
              final durationText = _buildDurationText(startDate, endDate);
              final currentStatus = _getCurrentStatus(endDate);
              final currentStatusColor = _getCurrentStatusColor(endDate);

              return Stack(
                children: [
                  Padding(
                    padding: marginLayout.copyWith(top: 26, bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SVG Image for employee status icon
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: customSvgImage(
                            imageUrl: Images.EMPLOYEE_STATUS,
                            color: AppColor.normalTextColor,
                            height: 18,
                            width: 18,
                          ),
                        ),
                        customSpacerWidth(width: 12),
                        // Designation and dates display
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                designation,
                                style: AppStyle.normal_text_grey.copyWith(
                                  color: AppColor.normalTextColor,
                                  fontSize: Dimensions.fontSizeMid - 2,
                                ),
                              ),
                              customSpacerHeight(height: 4),
                              Wrap(
                                children: [
                                  Text(
                                    "$formattedStartDate - ",
                                    style: _baseTextStyle.copyWith(
                                      color: AppColor.hintColor,
                                    ),
                                  ),
                                  Text(
                                    currentStatus,
                                    style: _baseTextStyle.copyWith(
                                      color: currentStatusColor,
                                    ),
                                  ),
                                  _divider(),
                                  Text(
                                    durationText,
                                    style: _baseTextStyle.copyWith(
                                      color: AppColor.hintColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Dotted separator for items except the last one
                  if (!isLastItem) _dottedSeparator(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  /// Builds a divider widget used between date ranges and duration.
  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        width: 1,
        color: AppColor.hintColor,
        height: 16,
      ),
    );
  }

  /// Dotted separator between history items.
  Widget _dottedSeparator() {
    return Positioned(
      top: 55,
      left: 1,
      bottom: 0,
      child: dottedStyleLayout(height: 46),
    );
  }

  /// Formats the given date string to 'dd MMM, yyyy'.
  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "";
    final dateTime = DateTime.parse(dateString);
    return DateFormat('dd MMM, yyyy').format(dateTime);
  }

  /// Gets the current status based on the provided end date.
  /// If no end date is provided, it returns "Present".
  String _getCurrentStatus(String? endDate) {
    return (endDate == null || endDate.isEmpty)
        ? AppString.textPresent.tr
        : dateMonthYearFormatFromDatetime(endDate);
  }

  /// Builds the duration text by calculating the time between start and end dates.
  /// If endDate is empty or null, it assumes the present time.
  String _buildDurationText(String startDate, String? endDate) {
    return (endDate == null || endDate.isEmpty)
        ? "${AppString.text_form_last.tr} ${workingTimeSinceFormString(startDate, null)}"
        : workingTimeSinceFormString(startDate, endDate);
  }

  /// Determines the color for the current status text.
  /// If the employee is still in the position (no end date), it returns the primary color.
  Color _getCurrentStatusColor(String? endDate) {
    return (endDate == null || endDate.isEmpty)
        ? AppColor.primaryColor
        : AppColor.hintColor;
  }

  /// Reusable base text style for status and duration display.
  TextStyle get _baseTextStyle {
    return AppStyle.mid_large_text.copyWith(
      fontSize: Dimensions.fontSizeDefault - 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

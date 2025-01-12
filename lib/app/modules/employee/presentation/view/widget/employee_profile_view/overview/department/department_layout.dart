import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import '../../../../../../../../../utils/utils.dart';
import '../../../../../../../../global/view/widget/app_margin.dart';

class DepartmentLayout extends StatelessWidget {
  final DepartmentModel departmentModel;

  const DepartmentLayout({
    Key? key,
    required this.departmentModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder,
        color: AppColor.bgColorWithPrimary.withOpacity(0.3),
        child: Padding(
          padding: marginLayout.copyWith(top: 12, bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildDepartmentInfo(),
              const SizedBox(height: 12),
              _buildShiftDetails(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return customSvgImage(
      imageUrl: Images.departmentNotification,
      color: AppColor.primaryColor,
      height: 25,
      width: 25,
    );
  }

  Widget _buildDepartmentInfo() {
    return GestureDetector(
      onTap: () => departmentModel.onAction(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (departmentModel.departmentName.isNotEmpty)
            Text(
              departmentModel.departmentName,
              style: AppStyle.mid_large_text
                  .copyWith(color: AppColor.normalTextColor),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (departmentModel.parentDepartmentName != null)
                _buildParentInfo(),
              if (departmentModel.startDate.isNotEmpty)
                Expanded(
                  child: Text(
                    "${AppString.text_from.tr} - ${_formatDate(departmentModel.startDate)}",
                    style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.hintColor,
                      fontSize: Dimensions.fontSizeDefault - 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParentInfo() {
    return Row(
      children: [
        Text(
          departmentModel.parentDepartmentName ?? "",
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.secondaryColor,
            fontSize: Dimensions.fontSizeDefault - 1,
          ),
        ),
        if (departmentModel.parentDepartmentName != null) _buildDivider(),
      ],
    );
  }

  Widget _buildShiftDetails(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          _verticalDivider(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  departmentModel.workShiftName,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeDefault + 1,
                  ),
                ),
                _buildShiftTiming(),
                const SizedBox(height: 8),
                Text(
                  AppString.text_working_day.tr,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor.withOpacity(0.7),
                    fontSize: Dimensions.fontSizeDefault + 1,
                  ),
                ),
                _buildWorkingDaysSchedule(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    if (dateString.isEmpty) return "";
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd MMM, yyyy').format(dateTime);
  }

  Widget _buildShiftTiming() {
    return Row(
      children: [
        Text(
          "${_formatTime(departmentModel.workShiftStartTime)} - ${_formatTime(departmentModel.workShiftEndTime)}",
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeDefault + 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _buildDivider(),
        GestureDetector(
          onTap: () {},
          child: Text(
            _getTimeDifference(departmentModel.workShiftStartTime,
                departmentModel.workShiftEndTime),
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor.withOpacity(0.7),
              fontSize: Dimensions.fontSizeDefault - 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingDaysSchedule(BuildContext context) {
    return SizedBox(
      height: AppLayout.getHeight(76),
      width: MediaQuery.of(context).size.width / 1.5,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: departmentModel.workingDays.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final dayInfo = departmentModel.workingDays[index];
          return Padding(
            padding: const EdgeInsets.only(
                left: 0.0, right: 30, top: 12, bottom: 12),
            child: Column(
              children: [
                Text(
                  _getDayAbbreviation(dayInfo["day"]),
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeDefault,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  dayInfo["holiday"] ? Icons.close : Icons.done,
                  color: dayInfo["holiday"]
                      ? AppColor.errorColor
                      : AppColor.successColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: double.infinity,
      color: AppColor.hintColor.withOpacity(0.4),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: marginLayout.copyWith(left: 8, right: 8),
      child: Container(width: 1, height: 12, color: AppColor.hintColor),
    );
  }

  String _formatTime(String timeString) {
    // Implement your time formatting logic
    return amPmFormatTimeFromString(timeString);
  }

  String _getTimeDifference(String startTime, String endTime) {
    // Implement your time difference calculation logic
    return getTimeDifference(startTime, endTime);
  }

  String _getDayAbbreviation(String day) {
    // Implement your day abbreviation logic
    return getDayAbbreviation(day);
  }
}

class DepartmentModel {
  final String departmentName;
  final String? parentDepartmentName;
  final String startDate;
  final String workShiftStartTime;
  final String workShiftName;
  final String workShiftEndTime;
  final List<Map<String, dynamic>> workingDays;

  ///Using for department history
  final Function onAction;

  DepartmentModel({
    required this.departmentName,
    this.parentDepartmentName,
    required this.onAction,
    required this.startDate,
    required this.workShiftStartTime,
    required this.workShiftName,
    required this.workShiftEndTime,
    required this.workingDays,
  });
}

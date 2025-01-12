import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/modules/auth/view/screens/otp_screen.dart';
import '../../../modules/profile/view/widget/common_widget.dart';
import '../custom_network_image.dart';
import '../custom_spacer.dart';
import '../custom_status_button.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_style.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/utils.dart';

class UserInfoWidget extends StatelessWidget {
  final EmployeeStatus? employeeStatus;

  const UserInfoWidget({super.key, this.employeeStatus});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserImage(height: 32),
          customSpacerWidth(width: 20),
          Expanded(child: _buildUserInfo()),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${employeeStatus?.firstName ?? ''} ${employeeStatus?.lastName ?? ''}",
          style:
              AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor),
        ),
        Text(employeeStatus?.department ?? "",
            style: AppStyle.normal_text_grey),
        _buildEmploymentStatusLayout(),
      ],
    );
  }

  Widget _buildUserImage({double? height}) {
    return CustomNetworkImage(
      errorText:
          "${employeeStatus?.firstName?[0] ?? ""}${employeeStatus?.lastName?[0]}",
      height: height ?? 32,
      profileImageKey: employeeStatus?.profileImageKey ?? "",
      imgUrlKey: "",
    );
  }

  Widget _buildEmploymentStatusLayout() {
    return Row(
      children: [
        _buildEmploymentStatus(
            color: employeeStatus?.employmentStatusColorCode ?? "",
            text: employeeStatus?.employmentContractType ?? ""),
        customSpacerWidth(width: 12),
        employmentStatus(employeeStatus?.currentEmployeeStatus),
      ],
    );
  }

  Widget _buildEmploymentStatus({required String color, required String text}) {
    final colorCode = Color(int.parse("0xFF${color.replaceAll('#', '')}"));
    return CustomStatusButton(
      bgColor: colorCode.withOpacity(.2),
      textColor: colorCode,
      text: text,
    );
  }
}

class MonthlyStatusWidget extends StatelessWidget {
  final MonthlyStatus? status;

  const MonthlyStatusWidget({super.key, this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: marginLayout.copyWith(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _infoText(
            value: formatToTwoDecimalPlaces(status?.leaveBalance ?? "0.0"),
            label: AppString.text_leave_balance.tr,
          ),
          _verticalDivider(),
          _infoText(
            value: status?.monthlyGoal ?? "0.0",
            label: AppString.text_monthly_goal.tr,
          ),
          _verticalDivider(),
          _infoText(
            value: status?.loggedTime ?? "0.0",
            label: AppString.text_logged_time.tr,
          ),
        ],
      ),
    );
  }

  Widget _infoText({required String value, required String label}) {
    return Column(
      children: [
        Text(
          value,
          style: AppStyle.normal_text_grey
              .copyWith(color: AppColor.normalTextColor),
        ),
        Text(
          label,
          style: AppStyle.mid_large_text.copyWith(
            fontSize: Dimensions.fontSizeDefault - 3,
            color: AppColor.hintColor,
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 20,
      color: AppColor.disableColor,
    );
  }
}

class EmployeeStatus {
  String? firstName;
  String? lastName;
  String? department;
  String? profileImageKey;
  String? employmentStatusColorCode;
  String? employmentContractType;
  String? currentEmployeeStatus;

  EmployeeStatus({
    this.firstName,
    this.lastName,
    this.department,
    this.profileImageKey,
    this.employmentStatusColorCode,
    this.employmentContractType,
    this.currentEmployeeStatus,
  });
}

class MonthlyStatus {
  String? leaveBalance;
  String? monthlyGoal;
  String? loggedTime;

  MonthlyStatus({
    this.leaveBalance,
    this.monthlyGoal,
    this.loggedTime,
  });
}

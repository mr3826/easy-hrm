import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/view/widget/app_margin.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/models/employee_overview.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../controllers/hr_deshboard_controller.dart';

class BuildEmployeeOverview extends GetView<HrDashBoardController> {
  const BuildEmployeeOverview({super.key});

  @override
  Widget build(BuildContext context) {
    GetEmployeeOverview? getEmployeeOverview =
        controller.employeeOverview?.getEmployeeOverview;

    return Padding(
      padding: marginLayout,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding:
              const EdgeInsets.all(24.0), // Adjusted padding for better layout
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                child: _buildText(
                  label: AppString.text_present.tr,
                  value: getEmployeeOverview?.workingToday.toString() ?? "0",
                ),
              ),
              _divider(),
              Flexible(
                flex: 1,
                child: _buildText(
                  label: AppString.text_on_leave.tr,
                  value: getEmployeeOverview?.onLeaveToday.toString() ?? "0",
                ),
              ),
              _divider(),
              Flexible(
                flex: 1,
                child: _buildText(
                  label: AppString.text_absent.tr,
                  value: getEmployeeOverview?.notWorkingToday.toString() ?? "0",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText({required String label, required String value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _formatNumber(value),
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.cardColor,
            fontSize: Dimensions.fontSizeLarge,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1, // Ensures ellipsis is applied for overflow
        ),
        Text(
          label,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.cardColor,
            fontSize: Dimensions.fontSizeSmall + 1,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1, // Ensures ellipsis is applied for overflow
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      height: 30,
      width: 0.6,
      color: AppColor.cardColor,
    );
  }

  String _formatNumber(String value) {
    double number = double.tryParse(value) ?? 0.0;
    return number.toStringAsFixed(1);
  }
}

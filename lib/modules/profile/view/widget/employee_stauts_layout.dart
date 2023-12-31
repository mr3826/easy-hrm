import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/view/widget/designation_layout.dart';
import 'package:payrun_mobile/modules/profile/view/widget/employeement_status_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';

Widget employeeStatusLayout({BuildContext? context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: GestureDetector(
          onTap: () => customButtonSheet(
              child: const DesignationLayout(), height: .7, context: context),
          child: Card(
            elevation: 0,
            color: AppColor.primaryColor.withOpacity(0.05),
            shape: roundedRectangleBorder,
            child: Padding(
              padding: marginLayout.copyWith(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSvgImage(
                      imageUrl: Images.EMPLOYEE_STATUS, height: 25, width: 25),
                  customSpacerHeight(height: 12),
                  Text(
                    Get.find<UserProfileController>()
                            .employeeWorkHistory
                            ?.getOrganizationUserHistory
                            ?.designationHistories?[0]
                            .designation
                            ?.name ??
                        "",
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.normalTextColor,
                        fontSize: Dimensions.fontSizeMid),
                  ),
                  Text(
                    "From - ${dateMonthYearFormatFromDatetime(Get.find<UserProfileController>().employeeWorkHistory?.getOrganizationUserHistory?.designationHistories?[0].startDate ?? "")}",
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault - 1),
                  ),
                  customSpacerHeight(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
      customSpacerWidth(width: 4),
      Expanded(
        child: GestureDetector(
          onTap: () => customButtonSheet(
              context: context, height: .7, child: const EmploymentLayout()),
          child: Card(
            elevation: 0,
            color: AppColor.primaryColor.withOpacity(0.05),
            shape: roundedRectangleBorder,
            child: Padding(
              padding: marginLayout.copyWith(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSvgImage(imageUrl: Images.FLAG, height: 25, width: 25),
                  customSpacerHeight(height: 12),
                  Text(
                    "${Get.find<UserProfileController>().employeeWorkHistory?.getOrganizationUserHistory?.employmentHistories?[0]?.employmentStatus?.name ?? ""} \nEmployee",
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.normalTextColor,
                        fontSize: Dimensions.fontSizeMid),
                  ),
                  Text(
                    "From - ${dateMonthYearFormatFromDatetime(Get.find<UserProfileController>().employeeWorkHistory?.getOrganizationUserHistory?.designationHistories?[0].startDate ?? "")}",
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault - 1),
                  ),
                  customSpacerHeight(height: 12),
                ],
              ),
            ),
          ),
        ),
      )
    ],
  );
}

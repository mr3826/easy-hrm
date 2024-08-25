import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/view/widget/designation_layout.dart';
import 'package:payrun_mobile/modules/profile/view/widget/employeement_status_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../timeline/view/widget/timeline_calendar.dart';
import 'department_layout_widget.dart';

Widget employeeStatusLayout({BuildContext? context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Get.find<UserProfileController>()
                      .employeeWorkHistory
                      ?.getOrganizationUserHistory
                      ?.designationHistories !=
                  null &&
              Get.find<UserProfileController>()
                  .employeeWorkHistory!
                  .getOrganizationUserHistory!
                  .designationHistories!
                  .isNotEmpty
          ? Expanded(
              child: GestureDetector(
                onTap: () => customAntButtonSheet(
                    child: const DesignationLayout(), context: context!),
                child: SizedBox(
                  child: Card(
                    elevation: 0,
                    color: AppColor.bgColorWithPrimary.withOpacity(0.3),
                    shape: roundedRectangleBorder,
                    child: Padding(
                      padding: marginLayout.copyWith(top: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customSvgImage(
                              imageUrl: Images.EMPLOYEE_STATUS,
                              height: 25,
                              width: 25),
                          customSpacerHeight(height: 12),
                          _designationInfo(),
                          customSpacerHeight(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Container(),
      Get.find<UserProfileController>()
                      .employeeWorkHistory
                      ?.getOrganizationUserHistory
                      ?.designationHistories !=
                  null &&
              Get.find<UserProfileController>()
                  .employeeWorkHistory!
                  .getOrganizationUserHistory!
                  .designationHistories!
                  .isNotEmpty
          ? customSpacerWidth(width: 4)
          : Container(),
      Expanded(
        child: GestureDetector(
          onTap: () => customAntButtonSheet(
              context: context!, child: const EmploymentLayout()),
          child: SizedBox(
            child: Card(
              elevation: 0,
              color: AppColor.bgColorWithPrimary.withOpacity(0.3),
              shape: roundedRectangleBorder,
              child: Padding(
                padding: marginLayout.copyWith(top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customSvgImage(
                        imageUrl: Images.FLAG, height: 25, width: 25),
                    customSpacerHeight(height: 12),
                    _employmentInfo(),
                    customSpacerHeight(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ],
  );
}

_employmentInfo() {
  return Get.find<UserProfileController>()
                  .employeeWorkHistory
                  ?.getOrganizationUserHistory
                  ?.employmentHistories !=
              null &&
          Get.find<UserProfileController>()
              .employeeWorkHistory!
              .getOrganizationUserHistory!
              .employmentHistories!
              .isNotEmpty
      ? Wrap(
          children: [
            SizedBox(
              height: 60,
              child: Text(
                Get.find<UserProfileController>()
                        .employeeWorkHistory
                        ?.getOrganizationUserHistory
                        ?.employmentHistories?[0]
                        .employmentStatus
                        ?.name ??
                    "",
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.fontSizeMid),
                maxLines: 2,
              ),
            ),
            Text(
              "${AppString.text_from.tr} - ${getDateTimeFormat(Get.find<UserProfileController>().employeeWorkHistory?.getOrganizationUserHistory?.employmentHistories?[0].startDate ?? "")}",
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 1),
            ),
          ],
        )
      : Container();
}

_designationInfo() {
  return Get.find<UserProfileController>()
                  .employeeWorkHistory
                  ?.getOrganizationUserHistory
                  ?.designationHistories !=
              null &&
          Get.find<UserProfileController>()
              .employeeWorkHistory!
              .getOrganizationUserHistory!
              .designationHistories!
              .isNotEmpty
      ? Wrap(
          children: [
            SizedBox(
              height: 60,
              child: Text(
                Get.find<UserProfileController>()
                        .employeeWorkHistory
                        ?.getOrganizationUserHistory
                        ?.designationHistories
                        ?.first
                        .designation
                        ?.name ??
                    "",
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.fontSizeMid),
                maxLines: 2,
              ),
            ),
            Text(
              "${AppString.text_from.tr} - ${getDateTimeFormat(Get.find<UserProfileController>().employeeWorkHistory?.getOrganizationUserHistory?.designationHistories?[0].startDate ?? "")}",
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 1),
            ),
          ],
        )
      : Container();
}

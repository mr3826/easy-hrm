import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/view/widget/dotted_style_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';

class DesignationLayout extends StatelessWidget {
  const DesignationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customButtonSheetAppbar(
            text: AppString.text_designation.tr,
            subtext: AppString.text_history.tr),
        Expanded(
            child: ListView.builder(
          physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,

              itemCount: Get.find<UserProfileController>()
                  .employeeWorkHistory
                  ?.getOrganizationUserHistory
                  ?.designationHistories
                  ?.length ??
              0,
          itemBuilder: (context, index) {
            return _employeeStatusInfoLayout(
                developerStatus: Get.find<UserProfileController>()
                        .employeeWorkHistory
                        ?.getOrganizationUserHistory
                        ?.designationHistories?[index]
                        .designation
                        ?.name ??
                    "",
                date: dateMonthYearFormatFromDatetime(
                    Get.find<UserProfileController>()
                            .employeeWorkHistory
                            ?.getOrganizationUserHistory
                            ?.designationHistories?[index]
                            .startDate ??
                        ""),
                durationText:
                    "${AppString.text_form_last.tr} ${workingTimeSinceFormString(Get.find<UserProfileController>().employeeWorkHistory?.getOrganizationUserHistory?.designationHistories?[index].startDate ?? "")}",
                employeeCurrentStatus: Get.find<UserProfileController>()
                            .employeeWorkHistory
                            ?.getOrganizationUserHistory
                            ?.designationHistories?[index]
                            .endDate ==
                        null
                    ? AppString.textPresent.tr
                    : dateMonthYearFormatFromDatetime(
                        Get.find<UserProfileController>()
                                .employeeWorkHistory
                                ?.getOrganizationUserHistory
                                ?.designationHistories?[index]
                                .endDate ??
                            ""));
          },
        ))
      ],
    );
  }

  _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6),
      child: Container(
        width: 1,
        color: AppColor.hintColor,
        height: 12,
      ),
    );
  }

  _employeeStatusInfoLayout({
    required String developerStatus,
    required String date,
    required String durationText,
    required String employeeCurrentStatus,
  }) {
    final baseTextStyle = AppStyle.mid_large_text.copyWith(
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
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      developerStatus,
                      style: AppStyle.normal_text_grey.copyWith(
                        color: AppColor.normalTextColor,
                        fontSize: Dimensions.fontSizeMid - 2,
                      ),
                    ),
                    customSpacerHeight(height: 4),
                    Row(
                      children: [
                        FittedBox(
                          child: Text(
                            "$date - ",
                            style: baseTextStyle.copyWith(
                              color: AppColor.hintColor,
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            employeeCurrentStatus,
                            style: baseTextStyle.copyWith(
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                        _divider(),
                        Expanded(
                          child: Text(
                            durationText,
                            style: baseTextStyle.copyWith(
                              color: AppColor.hintColor,
                            ),
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
        _dottedLayout(),
      ],
    );
  }



  _dottedLayout() {
    return Positioned(
        top: 55, left: 1, bottom: 0, child: dottedStyleLayout(height: 46));
  }
}

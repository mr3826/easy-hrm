import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/app/modules/profile/models/user_profile.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../../common/widget/employee/department_info_widget.dart';
import '../../../../global/view/widget/app_margin.dart';

class BuildEmployeeStatusLayout extends StatelessWidget {
  final UserDetails userDetails;
  final Function onDesignation;
  final Function onEmployeeStatus;

  const BuildEmployeeStatusLayout({
    super.key,
    required this.userDetails,
    required this.onDesignation,
    required this.onEmployeeStatus,
  });

  @override
  Widget build(BuildContext context) {
    Designation? designation =
        userDetails.getOrganizationUserDetails?.designation;

    EmploymentStatusData? employmentStatus =
        userDetails.getOrganizationUserDetails?.employmentStatus;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (designation != null)
          Expanded(
            child: GestureDetector(
              onTap: () => onDesignation(),
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
        if (employmentStatus != null) ...[
          customSpacerWidth(width: 4),
          Expanded(
            child: GestureDetector(
              onTap: () => onEmployeeStatus(),
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
          )
        ]
      ],
    );
  }

  _employmentInfo() {
    EmploymentStatusData? employmentStatus =
        userDetails.getOrganizationUserDetails?.employmentStatus;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: Text(
            employmentStatus?.name ?? "",
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor,
                overflow: TextOverflow.ellipsis,
                fontSize: Dimensions.fontSizeMid),
            maxLines: 1,
          ),
        ),
        customSpacerWidth(width: 4),
        Text(
          "${AppString.text_from.tr} - ${getDateTimeFormat("")}",
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor,
              fontSize: Dimensions.fontSizeDefault - 1),
        ),
      ],
    );
  }

  _designationInfo() {
    Designation? designation =
        userDetails.getOrganizationUserDetails?.designation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: Text(
            designation?.name ?? "",
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor,
                overflow: TextOverflow.ellipsis,
                fontSize: Dimensions.fontSizeMid),
            maxLines: 1,
          ),
        ),
        Text(
          "${AppString.text_from.tr} - ${getDateTimeFormat("")}",

          ///todo [api query]
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor,
              fontSize: Dimensions.fontSizeDefault - 1),
        ),
      ],
    );
  }
}

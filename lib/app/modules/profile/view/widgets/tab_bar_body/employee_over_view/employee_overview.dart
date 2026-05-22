import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/tab_bar_body/employee_over_view/expanded_text_layout.dart';
import '../../../../../../global/view/widget/app_margin.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/success_message.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../models/user_profile.dart';
import '../../user_info_section_layout.dart';
import '../../department_layout.dart';
import '../../employee_status.dart';

class ProfileOverView extends StatelessWidget {
  final UserDetails userDetails;
  final String orgUserId;

  const ProfileOverView(
      {super.key,
      required this.userDetails,
      required this.orgUserId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: marginLayout,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSpacerHeight(height: 8),

            /// User description
            _descriptionLayout(),

            customSpacerHeight(height: 8),

            /// User email
            _buildEmail(),

            /// Phone number
            customSpacerHeight(height: 15),
            _phoneNumberText(),
            customSpacerHeight(height: 15),
            _emergencyPhoneNumber(),
            customSpacerHeight(height: 15),

            /// Employee address
            _addressText(),
            customSpacerHeight(height: 15),

            /// Department layout
            _buildDepartmentLayout(),

            customSpacerHeight(height: 5),

            /// Designation history
            _buildEmploymentHistoryLayout(context),
            customSpacerHeight(height: 50),
          ],
        ),
      ),
    );
  }

  _descriptionLayout() {
    String drc = userDetails.getOrganizationUserDetails?.profile?.about ?? '';
    final wordCount = drc.split(' ').length;
    if (wordCount > 20) {
      return ExpandedText(
        text: drc,
      );
    } else {
      return Text(
        drc,
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.hintColor, fontSize: Dimensions.fontSizeDefault),
      );
    }
  }

  _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.text_email.tr,
          style: AppStyle.normal_text_grey.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault + 1,
          ),
        ),
        customSpacerHeight(height: 2),
        Row(
          children: [
            Flexible(
              child: Text(
                userDetails.getOrganizationUserDetails?.user?.email ?? "",
                maxLines: 2,
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.fontSizeDefault - 1),
              ),
            ),
            const SizedBox(width: 12),
            if (userDetails.getOrganizationUserDetails?.user?.email != null)
              SizedBox(
                height: 17,
                width: 17,
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                        text: userDetails
                                .getOrganizationUserDetails?.user?.email ??
                            ""));

                    showSuccessMessage(message: "Copied");
                  },
                  child: const Icon(
                    Icons.copy,
                    size: 14,
                    color: AppColor.secondaryColor,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  _phoneNumberText() {
    return userInfoSectionLayout(
      staticText: AppString.text_phone.tr,
      dynamicText:
          userDetails.getOrganizationUserDetails?.profile?.personalNumber ?? "",
    );
  }

  _emergencyPhoneNumber() {
    return userInfoSectionLayout(
      staticText: AppString.text_emergency_phone.tr,
      dynamicText:
          userDetails.getOrganizationUserDetails?.profile?.emergencyNumber ??
              "",
    );
  }

  _addressText() {
    return userInfoSectionLayout(
        staticText: AppString.text_address.tr,
        dynamicText:
            userDetails.getOrganizationUserDetails?.profile?.address ?? "");
  }

  Widget _buildDepartmentLayout() {
    String? department =
        userDetails.getOrganizationUserDetails?.department?.name;
    if (department != null) {
      return BuildDepartment(
        userDetails: userDetails,
        orgUserId: orgUserId,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildEmploymentHistoryLayout(BuildContext context) {
    return BuildEmployeeStatusLayout(
      orgUserId: orgUserId,
      userDetails: userDetails,
    );
  }

  _employmentHistoryInfo(title, date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: Text(
            title,
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor,
                overflow: TextOverflow.ellipsis,
                fontSize: Dimensions.fontSizeMid),
            maxLines: 1,
          ),
        ),
        Text(
          "${AppString.text_from.tr} - $date",

          ///todo [api query]
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor,
              fontSize: Dimensions.fontSizeDefault - 1),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/tab_bar_body/employee_over_view/expanded_text_layout.dart';
import '../../../../../../global/view/widget/app_margin.dart';
import '../../../../../auth/view/screens/otp_screen.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/success_message.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../../modules/timeline/view/widget/timeline_calendar.dart';
import '../../../../controller/global_profile_controller.dart';
import '../../../../models/user_profile.dart';
import 'designation_layout.dart';
import '../../user_info_section_layout.dart';
import '../../department_history_view.dart';
import '../../department_layout.dart';
import '../../employee_status.dart';
import 'employee_status_layout.dart';

class ProfileOverView extends StatelessWidget {
  final UserDetails userDetails;
  final Function onRefresh;

  const ProfileOverView(
      {super.key, required this.userDetails, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _fetchProfileData, // Call the refresh method
      child: SingleChildScrollView(
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
              _buildDepartmentLayout(context),

              customSpacerHeight(height: 5),

              /// Designation history
              _buildDesignationHistoryLayout(context),
              customSpacerHeight(height: 50),
            ],
          ),
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

  Widget _buildDepartmentLayout(BuildContext context) {
    String? department =
        userDetails.getOrganizationUserDetails?.department?.name;
    if (department != null) {
      return BuildDepartment(
        userDetails: userDetails,
        onDtpHistoryAction: () {
          Get.find<ProfileGlobalController>().getEmploymentInfo();
          customAntButtonSheet(
              context: context, child: const DepartmentHistoryView());
        },
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildDesignationHistoryLayout(BuildContext context) {
    return BuildEmployeeStatusLayout(
      userDetails: userDetails,
      onDesignation: () {
        print("BuildEmployeeStatusLayout clicked");
        Get.find<ProfileGlobalController>().getEmploymentInfo();
        customAntButtonSheet(
            child: const DesignationLayout(), context: context);
      },
      onEmployeeStatus: () {
        print("BuildEmployeeStatusLayout clicked");
        Get.find<ProfileGlobalController>().getEmploymentInfo();
        customAntButtonSheet(context: context, child: const EmploymentLayout());
      },
    );
  }

  /// Fetches the latest profile data from the server.
  Future<void> _fetchProfileData() async {
    onRefresh();
  }
}

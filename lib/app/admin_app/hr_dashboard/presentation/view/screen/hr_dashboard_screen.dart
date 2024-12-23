import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../modules/dashboard/controller/dashbpard_controller.dart';
import '../../../../../../modules/profile/controller/user_profile_controller.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';


class HrDashboardScreen extends StatelessWidget {
  const HrDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userInfoAppbarLayout()

        ],
      ),
    );
  }


  _userInfoAppbarLayout() {
    var controller = Get.find<DashboardController>();
    return Row(
      children: [
        _userImageLayout(),
        customSpacerWidth(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.text_welcome.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault),
            ),
            Text(
              controller.profileSummaryForDashboard?.getProfileSummaryForDashboard
                  ?.profile?.firstName ??
                  "",
              style: AppStyle.normal_text_grey.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeMid),
            ),
          ],
        )
      ],
    );
  }

  _userImageLayout() {
    var controller = Get.find<DashboardController>();

    return CustomNetworkImage(
      height: 22.4,
      errorText: (controller.profileSummaryForDashboard
          ?.getProfileSummaryForDashboard?.profile?.firstName !=
          null &&
          controller.profileSummaryForDashboard!
              .getProfileSummaryForDashboard!.profile!.firstName!.isNotEmpty)
          ? "${controller.profileSummaryForDashboard?.getProfileSummaryForDashboard?.profile?.firstName?[0].toUpperCase() ?? ""}"
          "${(Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.lastName != null && Get.find<UserProfileController>().userDetails!.getOrganizationUserDetails!.profile!.lastName!.isNotEmpty) ? Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.lastName![0].toUpperCase() ?? "" : ""}"
          : "",
      profileImageKey: controller.profileSummaryForDashboard
          ?.getProfileSummaryForDashboard?.profile?.image ??
          "",
      imgUrlKey: '',
      borderColor: Colors.transparent,
    );
  }

  _decorationStyle() {
    return BoxDecoration(
        color: AppColor.bgColorWithPrimary,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimensions.radiusExtraLarge - 10),
            bottomRight: Radius.circular(Dimensions.radiusExtraLarge - 10)));
  }

}

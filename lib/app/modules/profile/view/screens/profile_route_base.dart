import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/profile/models/user_log_history.dart';
import 'package:payrun_mobile/app/modules/profile/models/user_profile.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/tab_bar_body/employee_over_view/employee_overview.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/widgtes.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/images.dart';
import '../../../../../common/widget/loading_indicator.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../bindings/route_base_profile_binding.dart';
import '../../controller/global_profile_controller.dart';
import '../../controller/route_base_profile_controller.dart';
import '../widgets/profile_appbar.dart';

class ProfileRouteBase extends StatelessWidget {
  const ProfileRouteBase({super.key});
  @override
  Widget build(BuildContext context) {
    RouteBaseProfileBinding().dependencies();
    Get.put(ProfileGlobalController());

    UserLogHistory? userLogHistory = Get.find<ProfileGlobalController>().userLogHistory;
    return Obx(() {
      if (Get.find<ProfileRouteBaseController>().isLoadingProfile.isTrue) {
        return const LoadingIndicator();
      } else {
        return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            appBar: _profileAppbar(context),
            body: Column(
              children: [
                UserInfoLayout(
                  information:
                      Get.find<ProfileRouteBaseController>().userDetails ??
                          UserDetails(),
                  editIconUrl: Images.EDIT_ICON,
                ),
                customSpacerHeight(height: 30),
                LeaveStatusGoal(
                  userLogHistory: userLogHistory ?? UserLogHistory(),
                ),
                Expanded(
                  child: ProfileOverView(
                    userDetails:
                        Get.find<ProfileRouteBaseController>().userDetails ??
                            UserDetails(),
                    onRefresh: () {
                      Get.find<ProfileRouteBaseController>().getUserProfile();
                    },
                  ),
                ),
              ],
            ));
      }
    });
  }

  _profileAppbar(BuildContext context) {
    return buildProfileAppBar(
      backgroundColor: AppColor.backgroundColor,
      leadingWidget: Row(
        children: [
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
          const SizedBox(
            width: 8,
          ),
          Text(
            AppString.text_profile.tr,
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.fontSizeMid,
            ),
          ),
        ],
      ),
      actionIcon: CupertinoIcons.bell,
      onAction: () {},
    );
  }
}

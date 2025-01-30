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
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../bindings/route_base_profile_binding.dart';
import '../../controller/global_profile_controller.dart';
import '../../controller/route_base_profile_controller.dart';
import '../widgets/profile_appbar.dart';
import '../widgets/profile_tab_bar.dart';

class ProfileRouteBase extends StatelessWidget {
  final String orgUserId;

  const ProfileRouteBase({super.key, required this.orgUserId});

  @override
  Widget build(BuildContext context) {
    _initializationDependencies();
    UserLogHistory? userLogHistory =
        Get.find<ProfileGlobalController>().userLogHistory;
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Obx(() {
        if (Get.find<ProfileRouteBaseController>().isLoadingProfile.isTrue) {
          return const LoadingIndicator();
        } else {
          return Scaffold(
              backgroundColor: AppColor.backgroundColor,
              appBar: _profileAppbar(),
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
                  customSpacerHeight(height: 30),
                  ProfileTabBar(
                    userDetails:
                        Get.find<ProfileRouteBaseController>().userDetails ??
                            UserDetails(),
                    leaveSummaryApiCall: () =>
                        Get.find<ProfileRouteBaseController>()
                            .getLeaveSummary(orgUserId: orgUserId),
                    getLeaveRecordList: () =>
                        Get.find<ProfileRouteBaseController>()
                            .getLeaveRecordsData(orgUserId: orgUserId),
                  )
                ],
              ));
        }
      }),
    );
  }

  _profileAppbar() {
    return AppBar(
      leadingWidth: AppLayout.getWidth(200),
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            color: AppColor.normalTextColor,
            icon: const Icon(Icons.arrow_back_ios), // Back button icon
            onPressed: () {
              Get.back(canPop: false); // Navigate back
            },
          ),
          Text(
            AppString.text_profile.tr,
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.fontSizeMid + 1,
            ),
          ),
        ],
      ),
    );
  }

  void _initializationDependencies() {
    RouteBaseProfileBinding().dependencies();
    Get.put(ProfileGlobalController());
    Get.find<ProfileRouteBaseController>().getUserProfile(ordId: orgUserId);
  }
}

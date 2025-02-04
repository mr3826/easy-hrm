import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/app/modules/profile/controller/hr_profile_controller.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/app/modules/profile/models/user_log_history.dart';
import 'package:payrun_mobile/app/modules/profile/models/user_profile.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/profile_tab_bar.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/widgtes.dart';
import '../../../../../common/widget/custom_drawer.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/images.dart';
import '../../bindings/hr_profile_bindings.dart';
import '../../controller/global_profile_controller.dart';
import '../widgets/profile_appbar.dart';

class HrProfileScreen extends GetView<HrProfileController> {
  const HrProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _initializationDependencies();

    ///todo [UserProfileController]
    ///todo global
    UserLogHistory? userLogHistory =
        Get.find<ProfileGlobalController>().userLogHistory;
    return Obx(() {
      if (controller.isLoadingProfile.isTrue) {
        return const LoadingIndicator();
      } else {
        return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            appBar: _profileAppbar(
                context, controller.userDetails ?? UserDetails()),
            body: Column(
              children: [
                UserInfoLayout(
                  information: controller.userDetails ?? UserDetails(),
                  editIconUrl: Images.EDIT_ICON,
                ),
                customSpacerHeight(height: 30),
                LeaveStatusGoal(
                  userLogHistory: userLogHistory ?? UserLogHistory(),
                ),
                customSpacerHeight(height: 30),
                ProfileTabBar(
                  userDetails: controller.userDetails ?? UserDetails(),
                  leaveSummaryApiCall: () => controller.getLeaveSummary(),
                  getLeaveRecordList: () => controller.getLeaveRecordsData(),
                  orgUserId: GetStorage().read(AppString.ORGANIZATION_USER_ID),
                )
              ],
            ));
      }
    });
  }

  _profileAppbar(BuildContext context, UserDetails userDetails) {
    return buildProfileAppBar(
      backgroundColor: AppColor.backgroundColor,
      onAction: () {
        showCustomDrawer(
          context: context,
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: endDrawer(context, userDetails),
          ),
        );
      },
    );
  }

  void _initializationDependencies() {
    HrProfileBindings().dependencies();
    Get.put(ProfileGlobalController());
  }
}

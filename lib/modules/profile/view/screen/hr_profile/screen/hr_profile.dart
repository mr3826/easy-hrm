import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/profile/model/user_log_history.dart';
import 'package:payrun_mobile/modules/profile/model/user_profile.dart';
import 'package:payrun_mobile/modules/profile/view/screen/hr_profile/screen/profile_tab_bar.dart';
import 'package:payrun_mobile/modules/profile/view/screen/hr_profile/widgets/widgtes.dart';
import '../../../../../../common/widget/custom_drawer.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/images.dart';
import '../../../../controller/profile_module/hr_profile_controller.dart';
import '../../../../controller/user_profile_controller.dart';
import '../../../widget/profile_appbar.dart';


class HrProfileScreen extends StatelessWidget {
  const HrProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HrProfileController());
    ///todo [ProfileController]
    ///todo global
    UserLogHistory? userLogHistory = Get.find<UserProfileController>().userLogHistory;

    return DefaultTabController(
      length: 3, // Number of tabs
      child: Obx(() {
        if (Get.find<HrProfileController>().isLoadingProfile.isTrue) {
          return const LoadingIndicator();
        } else {
          return Scaffold(
              backgroundColor: AppColor.backgroundColor,
              appBar: _profileAppbar(context,
                  Get.find<HrProfileController>().userDetails ?? UserDetails()),
              body: Column(
                children: [
                  UserInfoLayout(
                    information: Get.find<HrProfileController>().userDetails ?? UserDetails(),
                    editIconUrl: Images.EDIT_ICON,
                  ),

                  customSpacerHeight(height: 30),

                  LeaveStatusGoal(
                    userLogHistory: userLogHistory ?? UserLogHistory(),
                  ),

                  customSpacerHeight(height: 30),

                  const ProfileTabBar()
                ],
              ));
        }
      }),
    );
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

}

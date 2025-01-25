import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/profile/model/user_log_history.dart';
import 'package:payrun_mobile/modules/profile/model/user_profile.dart';
import 'package:payrun_mobile/modules/profile/view/screen/hr_profile/widgets/employee_overview.dart';
import 'package:payrun_mobile/modules/profile/view/screen/hr_profile/widgets/widgtes.dart';
import '../../../../../../common/widget/custom_drawer.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../common/widget/loading_indicator.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/images.dart';
import '../../../../controller/profile_module/profile_controller.dart';
import '../../../../controller/user_profile_controller.dart';
import '../../../widget/profile_appbar.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    UserLogHistory? userLogHistory =
        Get.find<UserProfileController>().userLogHistory;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _profileAppbar(context),
      body: Obx(() {
        if (Get.find<ProfileController>().isLoadingProfile.isTrue) {
          return const LoadingIndicator();
        } else {
          return Column(
            children: [
              UserInfoLayout(
                information:
                    Get.find<ProfileController>().userDetails ?? UserDetails(),
                editIconUrl: Images.EDIT_ICON,
              ),
              customSpacerHeight(height: 30),
              LeaveStatusGoal(
                userLogHistory: userLogHistory ?? UserLogHistory(),
              ),
              Expanded(
                  child: ProfileOverView(
                userDetails:
                    Get.find<ProfileController>().userDetails ?? UserDetails(),
                onRefresh: () {
                  Get.find<ProfileController>().getUserProfile();
                },
              )),
            ],
          );
        }
      }),
    );
  }

  _profileAppbar(BuildContext context) {
    return buildProfileAppBar(
      backgroundColor: AppColor.backgroundColor,
      onAction: () {
        showCustomDrawer(
          context: context,
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: endDrawer(context),
          ),
        );
      },
    );
  }
}

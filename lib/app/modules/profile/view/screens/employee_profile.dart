import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/app/modules/profile/models/user_log_history.dart';
import 'package:payrun_mobile/app/modules/profile/models/user_profile.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/tab_bar_body/employee_over_view/employee_overview.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/user_info_layout.dart';
import '../../../../../common/widget/custom_drawer.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../common/widget/loading_indicator.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/images.dart';
import '../../bindings/employee_profile_bindings.dart';
import '../../controller/employee_profile_controller.dart';
import '../../controller/global_profile_controller.dart';
import '../widgets/profile_appbar.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    EmployeeProfileBindings().dependencies();
    Get.put(ProfileGlobalController());

    UserLogHistory? userLogHistory =
        Get.find<ProfileGlobalController>().userLogHistory;
    Get.find<ProfileGlobalController>().isEmployee(true);

    return Obx(() {
      if (Get.find<EmployeeProfileController>().isLoadingProfile.isTrue) {
        return const LoadingIndicator();
      }
      return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          appBar: _profileAppbar(
              context,
              Get.find<EmployeeProfileController>().userDetails ??
                  UserDetails()),
          body: Column(
            children: [
              UserInfoLayout(
                information:
                    Get.find<EmployeeProfileController>().userDetails ??
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
                    Get.find<EmployeeProfileController>().userDetails ??
                        UserDetails(),
                orgUserId: GetStorage().read(AppString.ORGANIZATION_USER_ID),
              )),
            ],
          ));
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
}

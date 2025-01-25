import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/profile/model/user_log_history.dart';
import 'package:payrun_mobile/modules/profile/model/user_profile.dart';
import 'package:payrun_mobile/modules/profile/view/screen/hr_profile/widgets/employee_overview.dart';
import 'package:payrun_mobile/modules/profile/view/screen/hr_profile/widgets/widgtes.dart';
import '../../../../../../common/widget/custom_drawer.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/images.dart';
import '../../../../controller/profile_module/hr_profile_controller.dart';
import '../../../../controller/user_profile_controller.dart';
import '../../../widget/profile_appbar.dart';
import '../../../widget/profile_tabbar_body/build_profile_leave_record.dart';
import '../../../widget/profile_tabbar_body/leave_summary/leave_summary_widget.dart';

class HrProfileScreen extends StatelessWidget {
  const HrProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HrProfileController());

    ///todo [ProfileController]
    ///todo global
    UserLogHistory? userLogHistory =
        Get.find<UserProfileController>().userLogHistory;

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
                    information: Get.find<HrProfileController>().userDetails ??
                        UserDetails(),
                    editIconUrl: Images.EDIT_ICON,
                  ),

                  customSpacerHeight(height: 30),

                  LeaveStatusGoal(
                    userLogHistory: userLogHistory ?? UserLogHistory(),
                  ),

                  customSpacerHeight(height: 30),
                  // TabBar Section
                  _buildTabBarItem(),

                  Expanded(
                    child: TabBarView(
                      children: [
                        ProfileOverView(
                          userDetails:
                              Get.find<HrProfileController>().userDetails ??
                                  UserDetails(),
                          onRefresh: () {
                            Get.find<HrProfileController>().getUserProfile();
                          },
                        ),
                        const BuildLeaveRecord(),
                        const BuildProfileLeaveSummary(),
                      ],
                    ),
                  ),
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

  _buildTabBarItem() {
    final HrProfileController controller = Get.put(HrProfileController());
    return Container(
      color: Colors.white,
      child: TabBar(
        isScrollable: true,
        onTap: (index) {
          // Perform additional actions on tab change
          if (index == 1 && controller.leaveRecordList == null) {
            controller.getLeaveRecordsData();
          } else if (index == 2 &&
              controller.leaveSummary?.getOrganizationUsersLeaveSummary ==
                  null) {
            controller.getLeaveSummary();
          }
        },
        labelColor: AppColor.primaryColor,
        unselectedLabelColor: Colors.black.withOpacity(0.4),
        indicatorColor: AppColor.primaryColor,
        tabAlignment: TabAlignment.start,
        indicatorWeight: 3,
        tabs: const [
          Tab(text: "Overview"),
          Tab(text: "Leave Records"),
          Tab(text: "Leave Summary"),
        ],
      ),
    );
  }
}

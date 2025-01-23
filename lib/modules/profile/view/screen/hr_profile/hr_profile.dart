import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/profile/model/user_log_history.dart';
import 'package:payrun_mobile/modules/profile/model/user_profile.dart';
import 'package:payrun_mobile/modules/profile/view/screen/hr_profile/widgets/employee_overview.dart';
import 'package:payrun_mobile/modules/profile/view/screen/hr_profile/widgets/widgtes.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/images.dart';
import '../../../controller/profile_module/hr_profile_controller.dart';
import '../../../controller/user_profile_controller.dart';
import '../../widget/profile_appbar.dart';
import '../../widget/profile_tabbar_body/build_profile_leave_record.dart';
import '../../widget/profile_tabbar_body/leave_summary/leave_summary_widget.dart';

class HrProfileScreen extends StatelessWidget {
  const HrProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {

    Get.put(HrProfileController());
  UserDetails? data=  Get.find<UserProfileController>().userDetails;  ///todo [ProfileController]

  UserLogHistory? userLogHistory=  Get.find<UserProfileController>().userLogHistory;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _profileAppbar(context),
      body: Expanded(

        child: Column(
          children: [
            UserInfoLayout(information:data??UserDetails(),editIconUrl:Images.EDIT_ICON,),
            customSpacerHeight(height: 30),
            LeaveStatusGoal(userLogHistory: userLogHistory??UserLogHistory(),),
            customSpacerHeight(height: 30),
        
        
            _buildProfileTabBar([
              Expanded(child: ProfileOverView(userDetails: data??UserDetails(),)),
               const Expanded(child: BuildLeaveRecord()),
              const Expanded(child: BuildProfileLeaveSummary())
            ])
        
        
          ],
        ),
      ),
    );
  }

  _profileAppbar(BuildContext context) {
    return profileAppbar(
      bgColor: AppColor.backgroundColor ,
      onAction: () {
        // showCustomDrawer(
        //   context: context,
        //   child: Container(
        //     color: Colors.transparent,
        //     width: double.infinity,
        //     child: endDrawer(context),
        //   ),
        // );
      },
    );
  }

}



_buildProfileTabBar(List<Widget> profileTabView) {
  // GetX Controller to manage the selected tab index
  HrProfileController controller = Get.find<HrProfileController>();

  return Expanded(
    child: Column(
      children: [
        _tabBarList(controller), // Pass the controller to manage the selected index
        Obx(() => profileTabView.isNotEmpty
            ? profileTabView[controller.profileTabIndex.value]
            : Container()),
      ],
    ),
  );
}

_tabBarList(HrProfileController controller) {
  List<String> tabIndex = ["Overview", "Leave records", "Leave summary"];

  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(0, 1),
          blurRadius: 6,
          spreadRadius: 0,
        ),
      ],
    ),
    child: Center(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabIndex.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              controller.profileTabIndex.value =
                  index; // Change the selected tab index
              if (controller.profileTabIndex.value == 1) {
                if (controller.leaveRecordList == null) {
                  controller.getLeaveRecordsData();
                }
              } else if (controller.profileTabIndex.value == 2) {
                if (controller.leaveSummary?.getOrganizationUsersLeaveSummary == null) {
                  controller.getLeaveSummary();
                }
              }
            },
            child: Obx(
                  () => Center(
                child: Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        tabIndex[index],
                        style: TextStyle(
                          color: controller.profileTabIndex.value == index
                              ? AppColor.primaryColor // Active tab color
                              : Colors.black.withOpacity(0.4),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Show underline for active tab with dynamic width
                    if (controller.profileTabIndex.value == index)
                      Container(
                        width: _calculateTextWidth(
                            tabIndex[index],
                            const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        height: 2,
                        color: AppColor.primaryColor, // Underline color
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

// Function to calculate text width
double _calculateTextWidth(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.width;
}




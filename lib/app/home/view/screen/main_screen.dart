import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/controller/user_info_controller.dart';
import 'package:payrun_mobile/app/home/view/widget/main_screen_widget.dart';
import 'package:payrun_mobile/modules/leave/presentation/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:upgrader/upgrader.dart';
import '../../../../app/admin_app/employee/presentation/controller/employment_controller.dart';
import '../../../../app/admin_app/employee/presentation/view/screen/employee_screen.dart';
import '../../../../modules/dashboard/presentation/controller/dashbpard_controller.dart';
import '../../../../modules/dashboard/presentation/view/screen/dashboard.dart';
import '../../../../modules/leave/presentation/controller/leave_record_controller.dart';
import '../../../../modules/leave/presentation/controller/update_leave_controller.dart';
import '../../../../modules/notification/presentation/controller/notification_controller.dart';
import '../../../../modules/notification/presentation/view/screen/notification.dart';
import '../../../../modules/profile/controller/user_profile_controller.dart';
import '../../../../modules/profile/view/screen/user_profile.dart';
import '../../../../modules/subscription/view/subscription_screen.dart';
import '../../../../modules/timeline/controller/timeline_controller.dart';
import '../../../../modules/timeline/controller/timelog_summary_controller.dart';
import '../../../../modules/timeline/view/screen/timeline.dart';
import '../../../admin_app/leave_hr/presentation/view/screen/leave_hr_screen.dart';
import '../../../admin_app/leave_hr/presentation/view/widget/range_calendar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.routeIndex = 2}) : super(key: key);
  final int? routeIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController controller;

  @override
  void initState() {
    controller = PersistentTabController(
      initialIndex: widget.routeIndex ?? 2,
    );
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    /// initialController controller

    if (Get.find<UserInfoController>().isSubscriptionExpired.isFalse) {
      _initialController();
    }

    return WillPopScope(
      onWillPop: () => appExitChecker,
      child: Scaffold(
          body: UpgradeAlert(
        dialogStyle: Platform.isIOS
            ? UpgradeDialogStyle.cupertino
            : UpgradeDialogStyle.material,
        upgrader: Upgrader(
            durationUntilAlertAgain: const Duration(days: 1),
            countryCode: GetStorage().read("countryCode") ?? "US"),
        child: Obx(
          () => PersistentTabView(
            context,
            controller: controller,
            screens: Get.find<UserInfoController>().isSubscriptionExpired.isTrue
                ? _ifNeedSubscription()
                : _screenListLayout(),
            items: iconList,
            // confineToSafeArea: false,
            backgroundColor: AppColor.backgroundColor,
            decoration: NavBarDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(1.0),
              colorBehindNavBar: Colors.white,
            ),

            padding: const EdgeInsets.only(top: 8),

            confineToSafeArea: true,
            navBarStyle: NavBarStyle.style15,
            navBarHeight: 60,
            hideNavigationBarWhenKeyboardAppears: true,
            onItemSelected: (value) {
              print(controller.index == value);
            },
          ),
        ),
      )),
    );
  }

  void _initialController() async {
    bool isAdmin =
        Get.find<UserInfoController>().userInfo.user?.role?.contains("admin") ??
            false;
    Get.put(DashboardController());
    Get.put(TimelineController());
    Get.put(NotificationController());
    Get.put(TimelineSummaryController());
    Get.put(LeaveScreenController());
    Get.put(LeaveRecordsController());
    Get.put(UserProfileController());
    if(isAdmin){
      Get.put(EmploymentController());
    }
    Get.put(UpDateLeaveController());
  }

  _screenListLayout() {
    bool isAdmin =
        Get.find<UserInfoController>().userInfo.user?.role?.contains("admin") ??
            false;
    return [
      const TimelineScreen(),
    //  const LeaveScreen(),
      LeaveHrScreen(),
      const Dashboard(),
      isAdmin ? const EmployeeScreen() : const NotificationScreen(),
      const ProfileScreen(),
    ];
  }

  _ifNeedSubscription() {
    return [
      const SubscriptionScreen(),
      const SubscriptionScreen(),
      const SubscriptionScreen(),
      const SubscriptionScreen(),
      const SubscriptionScreen(),
    ];
  }
}

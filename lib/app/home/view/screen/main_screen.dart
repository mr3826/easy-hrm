import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/screen/hr_timeline_screen.dart';
import 'package:payrun_mobile/modules/leave/presentation/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:upgrader/upgrader.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../common/widget/custom_svg_image.dart';
import '../../../../modules/dashboard/presentation/controller/dashbpard_controller.dart';
import '../../../../modules/dashboard/presentation/view/screen/dashboard.dart';
import '../../../../modules/leave/presentation/controller/leave_record_controller.dart';
import '../../../../modules/leave/presentation/controller/update_leave_controller.dart';
import '../../../../modules/leave/presentation/view/screen/leave_screen.dart';
import '../../../../modules/notification/presentation/controller/notification_controller.dart';
import '../../../../modules/notification/presentation/view/screen/notification.dart';
import '../../../../modules/profile/controller/user_profile_controller.dart';
import '../../../../modules/profile/view/screen/hr_profile/screen/employee_profile.dart';
import '../../../../modules/profile/view/screen/hr_profile/screen/hr_profile.dart';
import '../../../../modules/profile/view/screen/hr_profile/screen/profile_route_base.dart';
import '../../../../modules/profile/view/screen/user_profile.dart';
import '../../../../modules/timeline/controller/timeline_controller.dart';
import '../../../../modules/timeline/controller/timelog_summary_controller.dart';
import '../../../../modules/timeline/view/screen/timeline.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/images.dart';
import '../../../modules/employee/view/screen/employee_screen.dart';
import '../../../modules/leave_hr/presentation/controller/hr_leave_controller.dart';
import '../../../modules/leave_hr/presentation/view/screen/leave_hr_screen.dart';
import '../widget/main_screen_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    this.routeIndex = 2,
  }) : super(key: key);
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

    _initialController();

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
          child: PersistentTabView(
            context,
            controller: controller,
            screens: _screenListLayout(),
            items: _navBarsItems(),
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
          ),
        ),
      ),
    );
  }

  void _initialController() async {
    bool isEmployee = true;
    Get.put(DashboardController());
    Get.put(TimelineController());
    Get.put(NotificationController());
    Get.put(TimelineSummaryController());
    Get.put(LeaveScreenController());
    Get.put(LeaveRecordsController());
    Get.put(UserProfileController());
    if (!isEmployee) {
      Get.put(HrLeaveController());
    }
    Get.put(UpDateLeaveController());
  }

  _screenListLayout() {
    bool isEmployee = false;
    return [
      HrTimelineScreen(),
      isEmployee ? const LeaveScreen() : const LeaveHrScreen(),
      const Dashboard(),
      isEmployee ? const NotificationScreen() : const EmployeeScreen(),
     // const ProfileScreen(),
      const HrProfileScreen()
     // EmployeeProfileScreen()
     //ProfileRouteBase()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    bool isEmployee = true;
    return [
      _navbarIcon(
          activeIcon: Images.timelineIconNav,
          text: AppString.text_time_line.tr,
          imgUrl: Images.clockNav),
      _navbarIcon(
          activeIcon: Images.leaveIconNav,
          text: AppString.text_leave.tr,
          imgUrl: Images.leaveIconNavOutLine),
      PersistentBottomNavBarItem(
        icon: customSvgImage(imageUrl: Images.home, height: 25, width: 25),
        activeColorPrimary: AppColor.primaryColor,
        inactiveIcon:
            customSvgImage(imageUrl: Images.home, height: 25, width: 25),
      ),
      _navbarIcon(
          activeIcon:
              isEmployee ? Images.notificationIconNav : Images.employees_active,
          text: isEmployee
              ? AppString.text_notication.tr
              : AppString.text_employees.tr,
          imgUrl: isEmployee
              ? Images.notificationIconNavOutLine
              : Images.employees_inactive),
      _navbarIcon(
          activeIcon: Images.profileIconNav,
          text: AppString.text_profile.tr,
          imgUrl: Images.profileIconNavOutLine),
    ];
  }

  PersistentBottomNavBarItem _navbarIcon(
      {required activeIcon, required String text, imgUrl}) {
    return PersistentBottomNavBarItem(
      icon: _activeIcon(text, activeIcon),
      inactiveIcon: _inActiveIcon(text, imgUrl),
    );
  }

  _inActiveIcon(text, imgUrl) {
    return SizedBox(
      height: AppLayout.getHeight(25),
      child: Column(
        children: [
          customSvgImage(
              imageUrl: imgUrl,
              color: AppColor.hintColor,
              height: 25,
              width: 25),
          customSpacerHeight(height: 2),
          Text(
            text,
            style: AppStyle.mid_large_text
                .copyWith(fontSize: 10, color: AppColor.hintColor),
          )
        ],
      ),
    );
  }

  _activeIcon(text, activeIcon) {
    return SizedBox(
      height: AppLayout.getHeight(25),
      child: Column(
        children: [
          customSvgImage(imageUrl: activeIcon, height: 25, width: 25),
          customSpacerHeight(height: 2),
          Text(
            text,
            style: AppStyle.mid_large_text
                .copyWith(fontSize: 10, color: AppColor.primaryColor),
          )
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/app/global/controller/user_info_controller.dart';
import 'package:payrun_mobile/app/global/enum/user_enum.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/screen/employee_timeline_screen.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/screen/hr_timeline_screen.dart';
import 'package:payrun_mobile/modules/leave/presentation/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:upgrader/upgrader.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../common/widget/custom_svg_image.dart';
import '../../../../modules/dashboard/presentation/view/screen/dashboard.dart';
import '../../../../modules/leave/presentation/controller/leave_record_controller.dart';
import '../../../../modules/leave/presentation/controller/update_leave_controller.dart';
import '../../../../modules/leave/presentation/view/screen/leave_screen.dart';
import '../../../../modules/notification/presentation/controller/notification_controller.dart';
import '../../../../modules/notification/presentation/view/screen/notification.dart';
import '../../../modules/profile/view/screens/employee_profile.dart';
import '../../../modules/profile/view/screens/hr_profile.dart';
import '../../../../modules/timeline/controller/timeline_controller.dart';
import '../../../../utils/app_layout.dart';
import '../../../modules/hr_dashboard/view/screens/hr_dashboard_screen.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/images.dart';
import '../../../modules/employee/view/screen/employee_screen.dart';
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
  bool isEmployee = true;

  @override
  void initState() {
    controller = PersistentTabController(
      initialIndex: widget.routeIndex ?? 2,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// initialController controller

    _initialController();
    if (Get.find<UserInfoController>().userRole != UserEnum.employee) {

      print('role:${Get.find<UserInfoController>().userRole} enum: ${UserEnum.employee} b:${Get.find<UserInfoController>().userRole != UserEnum.employee}  ');

      isEmployee = false;
    }


    print("isEmployee: $isEmployee");


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
    Get.put(TimelineController());
    Get.put(NotificationController());
    Get.put(LeaveScreenController());
    Get.put(LeaveRecordsController());
    Get.put(UpDateLeaveController());
  }

  _screenListLayout() {
    if (isEmployee) {
      return [
        const EmployeeTimelineScreen(),
        const LeaveScreen(),
        const Dashboard(),
        const NotificationScreen(),
        const EmployeeProfileScreen(),
      ];
    } else {
      return [
        const HrTimelineScreen(),
        const LeaveHrScreen(),
        const HrDashboardScreen(),
        const EmployeeScreen(),
        const HrProfileScreen(),
      ];
    }
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
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

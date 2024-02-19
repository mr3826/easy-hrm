import 'package:get/get.dart';
import 'package:payrun_mobile/modules/dashboard/controller/dashbpard_controller.dart';
import 'package:payrun_mobile/modules/home/view/widget/main_screen_widget.dart';
import 'package:payrun_mobile/modules/leave/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../dashboard/view/screen/dashboard.dart';
import '../../../leave/view/screen/leave_screen.dart';
import '../../../notification/controller/notification_controller.dart';
import '../../../notification/view/screen/notification.dart';
import '../../../profile/controller/user_profile_controller.dart';
import '../../../profile/view/screen/user_profile.dart';
import '../../../timeline/controller/timeline_controller.dart';
import '../../../timeline/view/screen/timeline.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.routeIndex = 2}) : super(key: key);
  final int? routeIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController controller;

  var currentIndex = 0;
  @override
  void initState() {
    controller = PersistentTabController(initialIndex: widget.routeIndex ?? 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// initialController controller
    _initialController();
    return WillPopScope(
      onWillPop: () => appExitChecker,
      child: Scaffold(
        body: PersistentTabView(
          context,
          controller: controller,
          screens:  [
            const TimelineScreen(),
            const LeaveScreen(),
            const Dashboard(),
            const NotificationScreen(),
            ProfileScreen(),
          ],
          items: iconList,
          backgroundColor: AppColor.backgroundColor,
          confineInSafeArea: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(1.0),
            colorBehindNavBar: Colors.white,
          ),
          navBarStyle: NavBarStyle.style15,
          navBarHeight: 60,
          hideNavigationBarWhenKeyboardShows: true,
        ),
      ),
    );
  }

  void _initialController() {
    Get.put(LeaveScreenController());
    Get.put(UserProfileController());
    Get.put(TimelineController());
    Get.put(DashboardController());
    Get.put(NotificationController());
  }
}

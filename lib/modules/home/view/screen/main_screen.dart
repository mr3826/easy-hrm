import 'package:get/get.dart';
import 'package:payrun_mobile/modules/dashboard/controller/dashbpard_controller.dart';
import 'package:payrun_mobile/modules/home/view/widget/main_screen_widget.dart';
import 'package:payrun_mobile/modules/leave/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:update_notification/screens/update_notification.dart';
import '../../../auth/presentation/controller/signin_controller.dart';
import '../../../dashboard/view/screen/dashboard.dart';
import '../../../leave/controller/leave_record_controller.dart';
import '../../../leave/view/screen/leave_screen.dart';
import '../../../notification/controller/notification_controller.dart';
import '../../../notification/view/screen/notification.dart';
import '../../../profile/controller/user_profile_controller.dart';
import '../../../profile/view/screen/user_profile.dart';
import '../../../subscription/view/subscription_screen.dart';
import '../../../timeline/controller/timeline_controller.dart';
import '../../../timeline/controller/timelog_summary_controller.dart';
import '../../../timeline/view/screen/timeline.dart';

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
    UpdateNotification(
        androidAppId: 'com.gainhq.payrun', minimumVersion: '1.0.0+1');
    super.initState();
  }

  SignInController isValue = Get.find<SignInController>();
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
        screens: isValue.isSubscriptionExpired.isTrue
            ? _ifNeedSubscription()
            : _screenListLayout(),
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
        onItemSelected: (value) {
          print(controller.index == value);
        },
      )),
    );
  }

  void _initialController() async {
    Get.put(DashboardController());
    Get.put(TimelineController());
    Get.put(NotificationController());
    Get.put(TimelineSummaryController());
    Get.put(LeaveScreenController());
    Get.put(LeaveRecordsController());
    Get.put(UserProfileController());
  }

  _screenListLayout() {
    return [
      const TimelineScreen(),
      const LeaveScreen(),
      const Dashboard(),
      const NotificationScreen(),
      ProfileScreen(),
    ];
  }

  _ifNeedSubscription() {
    return [
      SubscriptionScreen(),
      SubscriptionScreen(),
      SubscriptionScreen(),
      SubscriptionScreen(),
      SubscriptionScreen(),
    ];
  }
}

import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/modules/dashboard/controller/dashbpard_controller.dart';
import 'package:payrun_mobile/modules/leave/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../dashboard/view/screen/dashboard.dart';
import '../../../leave/view/screen/leave_screen.dart';
import '../../../notification/view/screen/notification.dart';
import '../../../profile/controller/profile_image_selected_controller.dart';
import '../../../profile/view/screen/user_profile.dart';
import '../../../timeline/view/screen/timeline.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.routeIndex = 2}) : super(key: key);
  final int? routeIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PersistentTabController controller;

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      _navbarIcon(
          activeIcon: Images.clock_nav_svg,
          unActiveIcon: Images.clock_outline_nav),
      _navbarIcon(
          activeIcon: Images.airplane_nav,
          unActiveIcon: Images.airplane_outline_nav),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home_filled,
          size: 30,
          color: AppColor.cardColor,
        ),
        activeColorPrimary: AppColor.primaryColor,
        inactiveIcon: const Icon(
          Icons.home_filled,
          size: 30,
          color: AppColor.cardColor,
        ),
      ),
      _navbarIcon(
          activeIcon: Images.notification_nav,
          unActiveIcon: Images.notification_out_nav),
      _navbarIcon(
          activeIcon: Images.profile_nav, unActiveIcon: Images.profile_out_nav),
    ];
  }

  var currentIndex = 0;

  @override
  void initState() {
    controller = PersistentTabController(initialIndex: widget.routeIndex ?? 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: PersistentTabView(
          context,
          controller: controller,
          screens: const [
            TimelineScreen(),
            LeaveScreen(),
            Dashboard(),
            NotificationScreen(),
            ProfileScreen(),
          ],
          items: _navBarsItems(),
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
}

Future<bool> _onWillPop(BuildContext context) async {
  return customDialog(
    context: context,
    saveBtnAction: () {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    },
    icon: Icons.logout,
    titleText: AppString.text_are_you_sure.tr,
    subText: AppString.text_are_you_sure_want_to_exit_from_app.tr,
    iconBgColor: AppColor.secondaryColor,
    btnBgColor: AppColor.secondaryColor,
    btnText: AppString.text_yes.tr,
    drcText: "",
    drcFontSize: Dimensions.fontSizeDefault,
  );
}

PersistentBottomNavBarItem _navbarIcon(
    {required activeIcon, required unActiveIcon}) {
  return PersistentBottomNavBarItem(
    icon: SizedBox(
      height: AppLayout.getHeight(25),
      child: SvgPicture.asset(
        activeIcon,
        fit: BoxFit.cover,
      ),
    ),
    inactiveIcon: SizedBox(
      height: AppLayout.getHeight(25),
      child: SvgPicture.asset(
        unActiveIcon,
        fit: BoxFit.cover,
      ),
    ),
  );
}

_userProfileImgLayout() {
  return Column(
    children: [
      CircleAvatar(
        radius: 48,
        backgroundColor: AppColor.disableColor,
        child: CircleAvatar(
          radius: 47,
          backgroundColor: AppColor.backgroundColor,
          child: CircleAvatar(
            radius: 47,
            backgroundColor: AppColor.primaryColor.withOpacity(0.08),
            child: Get.find<PikedProfileImgController>()
                    .storageForUpload
                    .filePath
                    .value
                    .isNotEmpty
                ? CircleAvatar(
                    radius: 45,
                    backgroundImage: FileImage(File(
                            Get.find<PikedProfileImgController>()
                                .storageForUpload
                                .filePath
                                .value)
                        .absolute),
                  )
                : CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(Images.user),
                  ),
          ),
        ),
      ),
      customSpacerWidth(width: 18),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Agens Neilson",
            style: AppStyle.mid_large_text
                .copyWith(color: AppColor.normalTextColor),
          ),
          Text(
            "Laravel department",
            style: AppStyle.normal_text_grey,
          ),
          customSpacerHeight(height: 8),
        ],
      ),
    ],
  );
}

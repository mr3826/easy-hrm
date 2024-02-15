import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../../common/widget/custom_dialog.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/images.dart';

List<PersistentBottomNavBarItem> get iconList => _navBarsItems();
Future<bool> get appExitChecker => _onWillPop();

Future<bool> _onWillPop() async {
  return customDialog(
    context: Get.context!,
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

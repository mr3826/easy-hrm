import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../common/widget/custom_dialog.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/images.dart';
import '../../../auth/presentation/controller/signin_controller.dart';

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
    subText: "${AppString.text_are_you_sure_want_to_exit_from_app.tr}.",
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
        activeIcon: Images.timelineIconNav,
        text: AppString.text_time_line.tr,
        imgUrl: Images.clock_nav),
    _navbarIcon(
        activeIcon: Images.leaveIconNav,
        text: AppString.text_leave.tr,
        imgUrl: Images.leaveIconNavOutLine),
    PersistentBottomNavBarItem(
      icon: customSvgImage(imageUrl: Images.home,height: 25,width: 25),

      activeColorPrimary: AppColor.primaryColor,
      inactiveIcon: customSvgImage(imageUrl: Images.home,height: 25,width: 25),
    ),
    _navbarIcon(
        activeIcon: Images.notificationIconNav,
        text: AppString.text_notication.tr,
        imgUrl: Images.notificationIconNavOutLine),
    _navbarIcon(
        activeIcon: Images.profileIconNav,
        text: AppString.text_profile.tr,
        imgUrl: Images.profileIconNavOutLine),
  ];
}



PersistentBottomNavBarItem _navbarIcon(
    {required activeIcon, required String text, imgUrl}) {
  SignInController isValue = Get.find<SignInController>();

  return PersistentBottomNavBarItem(
    icon: Obx(() => isValue.isSubscriptionExpired.isTrue
        ? _inActiveIcon(text, imgUrl)
        : _activeIcon(text, activeIcon)),
    inactiveIcon: _inActiveIcon(text, imgUrl),
  );
}




_inActiveIcon(text, imgUrl) {
  return SizedBox(
    height: AppLayout.getHeight(25),
    child: Column(
      children: [
        customSvgImage(
            imageUrl: imgUrl, color: AppColor.hintColor, height: 25, width: 25),
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

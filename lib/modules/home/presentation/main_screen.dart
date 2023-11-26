import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/modules/profile/presentation/controller/profile_image_selected_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../common/widget/custom_spacer.dart';
import '../../../utils/app_style.dart';
import '../../../utils/dimensions.dart';

class MainScreen extends StatelessWidget {
   MainScreen({Key? key}) : super(key: key);

  final controller = PersistentTabController(initialIndex: 2);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      _navbarIcon(activeIcon: Images.clock_nav_svg,unActiveIcon: Images.clock_outline_nav),
      _navbarIcon(activeIcon: Images.airplane_nav,unActiveIcon: Images.airplane_outline_nav),
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
      _navbarIcon(activeIcon: Images.notification_nav,unActiveIcon: Images.notification_out_nav),
      _navbarIcon(activeIcon: Images.profile_nav,unActiveIcon: Images.profile_out_nav),

    ];
  }

  var currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(

        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 14.0,right: 14,bottom: 14,top: 14),
                child: SizedBox(
                  height: AppLayout.getHeight(400), // Set the desired height
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
                    ),
                    child:_userProfileImgLayout(),
                  ),
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Do something
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Do something
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),

        body: PersistentTabView(
          context,
          controller: controller,
          screens: buildScreens(),
          items: _navBarsItems(),
          backgroundColor: AppColor.backgroundColor,
          confineInSafeArea: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(1.0),
            colorBehindNavBar: Colors.white,
          ),
          navBarStyle: NavBarStyle.style15,
          navBarHeight: 60,
        ),
      ),
    );
  }
}

Future<bool> _onWillPop(BuildContext context) async {
  return await customAlertDialog(
      context: context,
      yesAction: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      });
}

PersistentBottomNavBarItem _navbarIcon({required activeIcon,required unActiveIcon}){
  return  PersistentBottomNavBarItem(
    icon: SizedBox(
      height: AppLayout.getHeight(25),
      child: SvgPicture.asset(
        activeIcon,fit: BoxFit.cover,
      ),

    ),


    inactiveIcon: SizedBox(
    height: AppLayout.getHeight(25),
    child: SvgPicture.asset(
      unActiveIcon,fit: BoxFit.cover,
    ),

  ),
  );
}

_userProfileImgLayout() {
  return  Column(
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
            child:Get.find<PikedProfileImgController>()
                .storageForUpload
                .filePath
                .value.isNotEmpty?

            CircleAvatar(
              radius: 45,
              backgroundImage:
              FileImage(
                  File(Get.find<PikedProfileImgController>()
                      .storageForUpload
                      .filePath
                      .value

                  )
                      .absolute

              ),
            ): CircleAvatar(
              radius: 45,
              backgroundImage:AssetImage(Images.user),
            ),
          ),
        ),
      ),
      customSpacerWidth(width: 18),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Agens Neilson",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor),),
          Text("Laravel department",style: AppStyle.normal_text_grey,),
          customSpacerHeight(height: 8),
        ],
      ),


    ],
  );
}
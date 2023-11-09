import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final controller = PersistentTabController(initialIndex: 2);

  List<Widget> _buildScreens() {
    return [
      Text("Home0"),
      Text("Home1"),
      Text("Home2"),
      Text("Home3"),
      Text("Home3"),
    ];
  }



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
      _navbarIcon(activeIcon: Images.calendar_nav,unActiveIcon: Images.calendar_out_nav),
      _navbarIcon(activeIcon: Images.profile_nav,unActiveIcon: Images.profile_out_nav),









    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: PersistentTabView(
        context,
        controller: controller,
        screens: _buildScreens(),
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
    );
  }
}

Future<bool> _onWillPop(BuildContext context) async {
  return await exitDialog(
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
import 'dart:io';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final _screens = <Widget>[
    Container(),
    Container(),
    Container(),
    Container(),

  ];

  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: _icon(icon: Icons.watch_later_outlined),
          activeIcon: _icon(icon: Icons.watch_later),
          label: "text_attendance".tr),
      BottomNavigationBarItem(
          icon: _icon(icon: Icons.calendar_today_outlined),
          activeIcon: _icon(icon: Icons.calendar_today),
          label: "text_leave".tr),
      BottomNavigationBarItem(
          icon: const Icon(Icons.description_outlined),
          activeIcon: const Icon(Icons.description),
          label: "text_payslip".tr),
      BottomNavigationBarItem(
          icon: _icon(icon: Icons.dashboard_customize_outlined),
          activeIcon: _icon(icon: Icons.dashboard),
          label: "text_more".tr),
    ];

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: _screens[currentIndex],
        bottomNavigationBar: Localizations.override(
          context: context,
          child: Wrap(children: [
            BottomNavigationBar(
              selectedItemColor: AppColor.primaryColor,
              unselectedItemColor: AppColor.hintColor.withOpacity(0.8),
              type: BottomNavigationBarType.fixed,
              selectedFontSize: Dimensions.fontSizeDefault - 1,
              unselectedFontSize: Dimensions.fontSizeDefault - 1,
              showUnselectedLabels: true,
              items: items,
              elevation: 3,
              backgroundColor: AppColor.backgroundColor,
              currentIndex: currentIndex,
              onTap: (index) => onTap(index),
            )
          ]),
        ),
      ),
    );
  }
}

Widget _icon({required icon}) {
  return Icon(icon);
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

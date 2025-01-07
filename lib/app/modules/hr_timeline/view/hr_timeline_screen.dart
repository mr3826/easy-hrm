import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/widgets/build_hr_timeline_calendar.dart';
import 'package:payrun_mobile/app/modules/hr_timeline/view/widgets/build_time_sheet.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../common/widget/custom_appbar.dart';
import '../../../../common/widget/custom_svg_image.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/images.dart';
import '../../../global/view/custom_tabbar_with_search.dart';

class HrTimelineScreen extends StatelessWidget {
  const HrTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _buildAppbar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [

            _buildTabBarWithSearchSection(context),


          ],
        ),

      ),
    );
  }

  _buildAppbar() {
    return customAppbar(
      leadingIcon: Text(
        AppString.text_time_line.tr,
        style: AppStyle.normal_text_black.copyWith(
          fontSize: Dimensions.fontSizeMid,
        ),
      ),
      leadingWidth: MediaQuery.of(Get.context!).size.width / 3,
      centerTitle: false,
      actions: [
        customSvgImage(
          imageUrl: Images.notificationIconNavOutLine,
          height: 26,
          width: 26,
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}







Widget _buildTabBarWithSearchSection(context) {
  List<TabItem> tabs = [
    TabItem(label: AppString.textCalendar.tr, body: const HrTimelineCalendar()),
    TabItem(label: AppString.text_time_sheet.tr, body: const BuildTimeSheet()),
  ];
  return TabBarWidget(
    tabs: tabs,
    onTabSelect: (index) {
      print("Selected tab index: $index");
    },
  );
}



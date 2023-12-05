import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/presentation/widget/widget.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/floating_btn_layout.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/time_log_view.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timeline_widget.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: CustomScrollView(
        slivers: [sliverAppBar, sliverToBoxAdapter],
      ),
      floatingActionButton: _applyLeaveBtn(context),
    );

  }
  //component
  _applyLeaveBtn(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0,bottom: 18),
      child: Row(
        children: [
          floatingButton(bgBtnColor: AppColor.secondaryColor,onAction: (){},btnText: AppString.text_stat_timer),
          customSpacerWidth(width: 18),

          floatingButton(bgBtnColor: AppColor.primaryColor,onAction: ()=>Get.toNamed(Routes.NEW_ENTRY_SCREEN),btnText: AppString.text_add_time_entry),

        ],
      ),
    );
  }



}

SliverAppBar get sliverAppBar {
  return SliverAppBar(
    expandedHeight: AppLayout.getHeight(250),
    elevation: 0,
    bottom: _buttonRadiusLayout(),
    pinned: true,
    backgroundColor: AppColor.primaryColor,
    flexibleSpace: FlexibleSpaceBar(
      background: SizedBox(
        height: AppLayout.getHeight(100),
        width: AppLayout.getWidth(200),
        child: Padding(
          padding: marginLayout,
          child: Column(
            children: [
              customSpacerHeight(height: 6),
              appBar(text: AppString.text_time_line.tr),
              customSpacerHeight(height: 6),
              timelineLayout(),
              customSpacerHeight(height: 14),
            ],
          ),
        ),
      ),
    ),
  );
}
_buttonRadiusLayout() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(20),
    child: Container(
        decoration: BoxDecoration(
            color: AppColor.backgroundColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radiusMid+10), topLeft: Radius.circular(Dimensions.radiusMid+10))),
        width: double.maxFinite,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: const Center(
            child: Text(
              "",
              style: TextStyle(fontSize: 23),
            ))),
  );
}

SliverToBoxAdapter get sliverToBoxAdapter {
  return const SliverToBoxAdapter(
      child: TimeLogView()
  );
}



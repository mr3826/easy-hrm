import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/dashboard/controller/dashbpard_controller.dart';
import 'package:payrun_mobile/modules/dashboard/view/widget/entry_time_widget.dart';
import 'package:payrun_mobile/modules/dashboard/view/widget/upcoming_leave.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../widget/progress_bar_layout.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Scaffold(
              backgroundColor: AppColor.backgroundColor,
              body: RefreshIndicator(
                backgroundColor: Colors.white,
                onRefresh: _refreshScreen,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      ProgressbarLayout(),
                      customSpacerHeight(height: 12),
                      Obx(() => entryAndStartTimeLayout(context)),
                      customSpacerHeight(height: 12),
                      controller.upcommingLeaveDashboard
                                      ?.getUpcomingLeavesForApp !=
                                  null &&
                              controller.upcommingLeaveDashboard!
                                  .getUpcomingLeavesForApp!.isNotEmpty
                          ? Text(
                              AppString.text_upcoming_leave.tr,
                              style: AppStyle.mid_large_text
                                  .copyWith(color: AppColor.normalTextColor),
                            )
                          : Container(),
                      const UpcomingLeaveLayout()
                    ],
                  ),
                ),
              ),
            ),
        onLoading: const LoadingIndicator());
  }

  Future<void> _refreshScreen() async {
    await controller.getProfileInfoForDashboard();
    await controller.getMonthlyTimelineInfoForDashboard();
    await controller.getUpComingInfoForDashboard();
  }
}

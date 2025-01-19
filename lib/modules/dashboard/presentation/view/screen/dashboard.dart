import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../controller/dashbpard_controller.dart';
import '../widget/entry_time_widget.dart';
import '../widget/progress_bar_layout.dart';
import '../widget/upcoming_leave.dart';

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
                      customSpacerHeight(height: 16),


                      controller.upcommingLeaveDashboard
                                      ?.getUpcomingLeavesForApp !=
                                  null &&
                              controller.upcommingLeaveDashboard!
                                  .getUpcomingLeavesForApp!.isNotEmpty
                          ? Text(
                              AppString.text_upcoming_leave.tr,
                              style: AppStyle.normal_text_black
                                  .copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeMid),
                            )
                          : Container(),


                      const UpcomingLeaveLayout(),

                      customSpacerHeight(height: 50),

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

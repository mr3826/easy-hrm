import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../../common/widget/custom_network_image.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../auth/presentation/view/otp_screen.dart';
import '../../../profile/controller/user_profile_controller.dart';
import '../../controller/dashbpard_controller.dart';
import 'dashboad_widget.dart';

class ProgressbarLayout extends GetView<DashboardController> {
  ProgressbarLayout({super.key});

  final PageController _pageController = PageController();
  final currentPage = 0.obs;

  @override
  Widget build(BuildContext context) {
    _screenCheckerSize(context);

    return Container(
      height: _screenCheckerSize(context),
      decoration: _decorationStyle(),
      width: double.infinity,
      child: Padding(
        padding: marginLayout,
        child: Column(
          children: [
            customSpacerHeight(height: 46),
            _userInfoAppbarLayout(),
            customSpacerHeight(height: 18),
            Expanded(
              child: PageView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (page) {
                  currentPage.value = page;
                },
                children: [
                  Center(
                      child: Column(
                    children: [
                      _dailySummaryText(),
                      customSpacerHeight(height: 18),
                      _progressBarLayout(
                          percent: double.parse(controller
                                  .profileSummaryForDashboard
                                  ?.getProfileSummaryForDashboard
                                  ?.progressPercentage ??
                              "0")),
                      _golTimeLayout(
                          goalText: AppString.text_today_goal.tr,
                          loggedText: AppString.text_logged_time.tr,
                          goalValue: controller
                                  .profileSummaryForDashboard
                                  ?.getProfileSummaryForDashboard
                                  ?.totalSchedule ??
                              '',
                          loggedValue: controller
                                  .profileSummaryForDashboard
                                  ?.getProfileSummaryForDashboard
                                  ?.totalLogged ??
                              "")
                    ],
                  )),
                  _loggedLayout()
                ],
              ),
            ),
            Obx(() => dotsDecorator(currentIndex: currentPage)),
            customSpacerHeight(height: 20),
          ],
        ),
      ),
    );
  }

  double _screenCheckerSize(BuildContext context) {
    // Get the screen size
    var screenSize = MediaQuery.of(context).size;
    // Set a threshold height for conditional check
    double thresholdHeight = 600.0;
    if (screenSize.height >= 1366) {
      return 700;
    } else if (screenSize.height > thresholdHeight) {
      return 440;
    } else {
      return 500;
    }
  }

  _loggedLayout() {
    return Center(
        child: Column(
      children: [
        Text(
          AppString.text_monthly_summary.tr,
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor.withOpacity(0.7),
              fontSize: Dimensions.fontSizeDefault - 1,
              letterSpacing: 5),
        ),
        customSpacerHeight(height: 18),
        _progressBarLayout(
            percent: double.parse(controller.timelineSummaryDashboard
                    ?.getMonthlyTimelog?.progressPercentage ??
                "0")),
        _golTimeLayout(
            goalText: AppString.text_monthly_goal.tr,
            loggedText: AppString.text_logged_time.tr,
            goalValue: controller.timelineSummaryDashboard?.getMonthlyTimelog
                    ?.totalSchedule ??
                "",
            loggedValue: controller
                    .timelineSummaryDashboard?.getMonthlyTimelog?.totalLogged ??
                "")
      ],
    ));
  }

  _dailySummaryText() {
    return Text(
      AppString.text_daily_summary.tr,
      style: AppStyle.mid_large_text.copyWith(
          color: AppColor.normalTextColor.withOpacity(0.7),
          fontSize: Dimensions.fontSizeDefault - 1,
          letterSpacing: 5),
    );
  }
}

_progressBarLayout({required double percent}) {
  return SizedBox(
    height: MediaQuery.of(Get.context!).size.height / 4.7,
    child: SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: false,
          axisLineStyle: const AxisLineStyle(
            thickness: 0.17,
            cornerStyle: CornerStyle.bothCurve,
            color: AppColor.hintColor,
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: percent,
              cornerStyle: CornerStyle.bothCurve,
              width: 0.17,
              sizeUnit: GaugeSizeUnit.factor,
              color: AppColor.primaryColor,
              animationDuration: 600,
              enableAnimation: true,
            )
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                angle: 90,
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.text_progress.tr,
                      style: AppStyle.normal_text_grey.copyWith(
                          color: AppColor.hintColor,
                          fontSize: Dimensions.fontSizeDefault),
                    ),
                    customSpacerHeight(height: 5),
                    Text(
                      '${percent.toStringAsFixed(0)}%',
                      style: AppStyle.normal_text_grey.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeExtraLarge + 4,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ))
          ])
    ]),
  );
}

_golTimeLayout(
    {required String goalText,
    required String loggedText,
    required String goalValue,
    required String loggedValue}) {
  return Padding(
    padding: marginLayout.copyWith(top: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              goalText,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 1),
            ),
            Text(
              goalValue,
              style: AppStyle.normal_text_grey
                  .copyWith(fontSize: Dimensions.fontSizeMid),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              loggedText,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault - 1),
            ),
            Text(
              loggedValue,
              style: AppStyle.normal_text_grey.copyWith(
                  fontSize: Dimensions.fontSizeMid,
                  color: AppColor.primaryColor),
            )
          ],
        ),
      ],
    ),
  );
}

_userInfoAppbarLayout() {
  var controller = Get.find<DashboardController>();
  return Row(
    children: [
      _userImageLayout(),
      customSpacerWidth(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppString.text_welcome.tr,
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault),
          ),
          Text(
            controller.profileSummaryForDashboard?.getProfileSummaryForDashboard
                    ?.profile?.firstName ??
                "",
            style: AppStyle.normal_text_grey.copyWith(
                color: AppColor.normalTextColor,
                fontSize: Dimensions.fontSizeMid),
          ),
        ],
      )
    ],
  );
}

_userImageLayout() {
  var controller = Get.find<DashboardController>();

  return CustomNetworkImage(
    height: 22,
    errorText: (controller.profileSummaryForDashboard
                    ?.getProfileSummaryForDashboard?.profile?.firstName !=
                null &&
            controller.profileSummaryForDashboard!
                .getProfileSummaryForDashboard!.profile!.firstName!.isNotEmpty)
        ? "${controller.profileSummaryForDashboard?.getProfileSummaryForDashboard?.profile?.firstName?[0].toUpperCase() ?? ""}"
            "${(Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.lastName != null && Get.find<UserProfileController>().userDetails!.getOrganizationUserDetails!.profile!.lastName!.isNotEmpty) ? Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.lastName![0].toUpperCase() ?? "" : ""}"
        : "",
    profileImageKey: controller.profileSummaryForDashboard
            ?.getProfileSummaryForDashboard?.profile?.image ??
        "",
    borderColor: Colors.transparent,
    imgUrlKey: '',
  );
}

_decorationStyle() {
  return BoxDecoration(
      color: AppColor.primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Dimensions.radiusExtraLarge - 14),
          bottomRight: Radius.circular(Dimensions.radiusExtraLarge - 14)));
}

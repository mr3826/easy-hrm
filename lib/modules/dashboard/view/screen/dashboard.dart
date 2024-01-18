import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/dashboard/controller/dashbpard_controller.dart';
import 'package:payrun_mobile/modules/leave/model/leave_records.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../common/widget/custom_network_image.dart';
import '../../../../common/widget/custom_status_button.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../leave/view/widget/leave_record_details_view.dart';
import '../../../timeline/controller/timer_controller.dart';

class Dashboard extends GetView<DashboardController> {
  Dashboard({super.key});

  final PageController _pageController = PageController();
  final currentPage = 0.obs;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Scaffold(
              backgroundColor: AppColor.backgroundColor,
              body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 1.8,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    Dimensions.radiusExtraLarge - 14),
                                bottomRight: Radius.circular(
                                    Dimensions.radiusExtraLarge - 14))),
                        width: double.infinity,
                        child: Padding(
                          padding: marginLayout,
                          child: Column(
                            children: [
                              customSpacerHeight(height: 46),
                              _userInfoAppbarLayout(),
                              customSpacerHeight(height: 28),
                              Expanded(
                                child: PageView(
                                  physics: const BouncingScrollPhysics(),
                                  controller: _pageController,
                                  onPageChanged: (page) {
                                    print("${page.toDouble()}");
                                    currentPage.value = page;
                                  },
                                  children: [
                                    Center(
                                        child: Column(
                                      children: [
                                        Text(
                                          AppString.text_daily_summary.tr,
                                          style: AppStyle.mid_large_text
                                              .copyWith(
                                                  color: AppColor
                                                      .normalTextColor
                                                      .withOpacity(0.7),
                                                  fontSize: Dimensions
                                                          .fontSizeDefault -
                                                      1,
                                                  letterSpacing: 5),
                                        ),
                                        customSpacerHeight(height: 18),
                                        _progressBarLayout(
                                            percent: double.parse(controller
                                                    .profileSummaryForDashboard
                                                    ?.getProfileSummaryForDashboard
                                                    ?.progressPercentage ??
                                                "0")),
                                        _golTimeLayout(
                                            goalText:
                                                AppString.text_today_goal.tr,
                                            loggedText:
                                                AppString.text_logged_time.tr,
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
                                    Center(
                                        child: Column(
                                      children: [
                                        Text(
                                          AppString.text_monthly_summary.tr,
                                          style: AppStyle.mid_large_text
                                              .copyWith(
                                                  color: AppColor
                                                      .normalTextColor
                                                      .withOpacity(0.7),
                                                  fontSize: Dimensions
                                                          .fontSizeDefault -
                                                      1,
                                                  letterSpacing: 5),
                                        ),
                                        customSpacerHeight(height: 18),
                                        _progressBarLayout(
                                            percent: double.parse(controller
                                                    .timelineSummaryDashboard
                                                    ?.getMonthlyTimelog
                                                    ?.progressPercentage ??
                                                "0")),
                                        _golTimeLayout(
                                            goalText:
                                                AppString.text_monthly_goal.tr,
                                            loggedText:
                                                AppString.text_logged_time.tr,
                                            goalValue: controller
                                                    .timelineSummaryDashboard
                                                    ?.getMonthlyTimelog
                                                    ?.totalSchedule ??
                                                "",
                                            loggedValue: controller
                                                    .timelineSummaryDashboard
                                                    ?.getMonthlyTimelog
                                                    ?.totalLogged ??
                                                "")
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                              Obx(() =>
                                  _dotsDecorator(currentIndex: currentPage)),
                              customSpacerHeight(height: 20),
                            ],
                          ),
                        ),
                      ),
                      Obx(() => _entryAndStartTimeLayout()),
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
                      _upcomingLeaveLayout()
                    ],
                  ),
                ),
              ),
            ),
        onLoading: const LoadingIndicator());
  }

  _progressBarLayout({required double percent}) {
    return SizedBox(
      height: AppLayout.getHeight(190),
      width: AppLayout.getWidth(190),
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
              controller.profileSummaryForDashboard
                      ?.getProfileSummaryForDashboard?.profile?.firstName ??
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
    return CustomNetworkImage(
      height: 22,
      imgUrl:
          "${Api.PUBLIC_IMAGE_URL_DOMAIN}/files/${GetStorage().read(AppString.ORGANIZATION_ID)}/${controller.profileSummaryForDashboard?.getProfileSummaryForDashboard?.profile?.image}",
      borderColor: Colors.transparent,
    );
  }

  _entryAndStartTimeLayout() {
    final TimeCounterController controller = Get.put(TimeCounterController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          //todo
          onTap: () {
            if (Get.isRegistered<DateTimeController>()) {
              Get.delete<DateTimeController>();
            }
            Get.put(DateTimeController());
            Get.toNamed(Routes.NEW_ENTRY_SCREEN);
          },
          child: SizedBox(
              height: AppLayout.getHeight(170),
              width: AppLayout.getWidth(170),
              child: customSvgImage(imageUrl: Images.add_time_entry)),
        ),
        customSpacerWidth(width: 22),
        controller.isRunning.value
            ? _startingTimeOpen(time: "${controller.starTimeDashboard}")
            : _startingTime()
      ],
    );
  }

  _upcomingLeaveLayout() {
    return Padding(
      padding: marginLayout,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller
                .upcommingLeaveDashboard?.getUpcomingLeavesForApp?.length ??
            0,
        itemBuilder: (context, index) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GestureDetector(
                onTap: () => customButtonSheet(
                    context: context,
                    child: LeaveRecordDetails(
                      status: controller.upcommingLeaveDashboard
                              ?.getUpcomingLeavesForApp?[index].status ??
                          "taken",
                      leaveRecords: GetLeaveRecords(
                          status: controller.upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].status ??
                              "",
                          createdAt: controller.upcommingLeaveDashboard
                                  ?.getUpcomingLeavesForApp?[index].createdAt ??
                              "",
                          startDate: controller.upcommingLeaveDashboard
                                  ?.getUpcomingLeavesForApp?[index].startDate ??
                              "",
                          endDate: controller.upcommingLeaveDashboard
                                  ?.getUpcomingLeavesForApp?[index].endDate ??
                              "",
                          leaveType: controller.upcommingLeaveDashboard
                              ?.getUpcomingLeavesForApp?[index].leaveType,
                          duration: controller
                                  .upcommingLeaveDashboard
                                  ?.getUpcomingLeavesForApp?[index]
                                  .numberOfDays ??
                              0,
                          description: controller.upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].description),
                    ),
                    height: 0.5),
                child: Card(
                  elevation: 0,
                  color: AppColor.primaryColor.withOpacity(0.06),
                  shape: roundedRectangleBorder,
                  child: Padding(
                    padding: marginLayout.copyWith(
                        left: 12, right: 12, top: 12, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller
                                      .upcommingLeaveDashboard
                                      ?.getUpcomingLeavesForApp?[index]
                                      .status!
                                      .capitalizeFirst ??
                                  "",
                              style: AppStyle.normal_text_grey.copyWith(
                                color:
                                    AppColor.normalTextColor.withOpacity(0.8),
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                            customSpacerHeight(height: 4),
                            _leaveInfoRow(index),
                          ],
                        ),
                        SizedBox(
                            height: AppLayout.getHeight(24),
                            child: CustomStatusButton(
                                bgColor: AppColor.primaryColor.withOpacity(0.1),
                                text: "Taken",
                                textColor: AppColor.primaryColor))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _leaveInfoRow(int index) {
    String? leaveDate;
    String starDate = dateMonthFormatFromDatetime(controller
            .upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].startDate
            ?.substring(0, 10) ??
        "2023-01-01T08:23:49.550Z");
    String endDate = dateMonthFormatFromDatetime(controller
            .upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].endDate
            ?.substring(0, 10) ??
        "2023-01-01T08:23:49.550Z");
    if (starDate == endDate) {
      leaveDate = dateMonthFormatFromDatetime(controller.upcommingLeaveDashboard
              ?.getUpcomingLeavesForApp?[index].startDate ??
          "2023-01-01T08:23:49.550Z");
    } else {
      leaveDate =
          "${dateMonthFormatFromDatetime(controller.upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].startDate ?? "2023-01-01T08:23:49.550Z")} - ${dateMonthFormatFromDatetime(controller.upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].endDate ?? "2023-01-01T08:23:49.550Z")}";
    }

    return Row(
      children: [
        Text(
          leaveDate.toString(),
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.secondaryColor,
              fontSize: Dimensions.fontSizeDefault),
        ),
        customSpacerWidth(width: 8),
        Text(
          controller.upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index]
                      .numberOfDays ==
                  null
              ? ""
              : controller.upcommingLeaveDashboard
                          ?.getUpcomingLeavesForApp?[index].numberOfDays >
                      1
                  ? "| ${controller.upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].numberOfDays} days"
                  : "| ${controller.upcommingLeaveDashboard?.getUpcomingLeavesForApp?[index].numberOfDays} day",
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor, fontSize: Dimensions.fontSizeDefault),
        )
      ],
    );
  }
}

_startingTimeOpen({required time}) {
  return InkWell(
    onTap: () async {
      Get.toNamed(Routes.TIMER_SCREEN);
    },
    child: Stack(
      children: [
        SizedBox(
            height: AppLayout.getHeight(170),
            width: AppLayout.getWidth(170),
            child: customSvgImage(imageUrl: Images.start_time_open)),
        Positioned(
            bottom: 45,
            left: 36,
            child: Row(
              children: [
                Icon(
                  Icons.check_box_outline_blank,
                  color: AppColor.cardColor.withOpacity(0.9),
                  size: 20,
                ),
                customSpacerWidth(width: 4),
                Text(
                  "$time",
                  style: AppStyle.normal_text_grey.copyWith(
                      color: AppColor.cardColor,
                      fontSize: Dimensions.fontSizeDefault + 1),
                ),
              ],
            ))
      ],
    ),
  );
}

_startingTime() {
  return InkWell(
    onTap: () {
      Get.find<TimeCounterController>().timerStatus();
      Get.toNamed(Routes.TIMER_SCREEN);
    },
    child: SizedBox(
        height: AppLayout.getHeight(170),
        width: AppLayout.getWidth(170),
        child: customSvgImage(imageUrl: Images.start_time)),
  );
}

Widget _dotsDecorator({required currentIndex}) {
  return DotsIndicator(
    dotsCount: 2, // Number of dots should match the number of pages
    position: currentIndex.value,
    decorator: const DotsDecorator(
        color: AppColor.hintColor,
        activeColor: AppColor.primaryColor,
        size: Size.square(10.0),
        activeSize: Size(25.0, 9),
        activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(5.0), left: Radius.circular(5.0)))),
  );
}

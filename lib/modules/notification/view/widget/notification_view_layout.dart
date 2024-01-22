import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/images.dart';

import '../../../../common/widget/custom_icon_shape_style.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../enum.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import 'notification_info_sytle_layout.dart';

class NotificationViewLayout extends StatelessWidget {
  final int index;

  const NotificationViewLayout({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: index == 0 ? _newNotificationView() : _seenNotificationView(),
      ),
    );
  }

  _newNotificationView() {
    return ListView.builder(
        itemCount: 12,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return _getNotificationByContext("reject_a_timeline", index);
        });
  }

  _getNotificationByContext(String notificationContext, int index) {
    switch (notificationContext) {
    case "reject_a_timeline":
    return _timeLineNotification(
    changerName: "Rakib Hasan",
    iconColor: AppColor.errorColor,
    contextInfoText:
    _getTimelineContextInfoTex(contextName: "reject_a_timeline"),
    timeLineTimeInfo: _getNotificationDuration(notificationCreatedDate: "2024-01-03T03:03:04"),
    notificationDuration: "2mins",
    index: index);
    default:
    return Container();
    }
  }

  _timeLineNotification({required String changerName,
    required Color iconColor,
    required String contextInfoText,
    required String timeLineTimeInfo,
    required String notificationDuration,
    required int index}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        color: index.isOdd ? Colors.blueAccent.withOpacity(0.05) : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customIconShapeStyle(
              image: Images.time_log_notification, color: iconColor),
          customSpacerWidth(width: 20),
          SizedBox(
            width: Get.width / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  changerName,
                  style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.secondaryColor,
                      fontSize: Dimensions.fontSizeMid,
                      fontWeight: FontWeight.w500),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: contextInfoText,
                          style: TextStyle(
                            color: AppColor.normalTextColor,
                            fontSize: Dimensions.fontSizeDefault,
                          )),
                      TextSpan(
                        text: timeLineTimeInfo,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.fontSizeDefault,
                            color: AppColor.secondaryColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  notificationDuration,
                  style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.hintColor,
                      fontSize: Dimensions.fontSizeDefault),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String _getTimelineContextInfoTex({required String contextName}) {
    switch (contextName) {
      case "reject_a_timeline":
        return "has reject your timeline on ";
      default:
        return '';
    }
  }

  String _getNotificationDuration({required String notificationCreatedDate}) {
    if (notificationCreatedDate.isEmpty) return "";


    DateTime startTime = DateTime.parse(notificationCreatedDate);
    DateTime endTime = DateTime.now();

    // Calculate the duration between the two times
    Duration duration = endTime.difference(startTime);

    if (duration.inDays < 1 && !duration.isNegative) {
      //hr, mins
      if (duration.inHours < 1) {
        return duration.inMinutes < 2
            ? "${duration.inMinutes} min"
            : "${duration.inMinutes} mins";
      } else {
        return "${duration.inHours} h ${duration.inMinutes} m";
      }
    } else if (duration.inDays == 1) {
      return "Yesterday";
    } else {
      return DateFormat("d MMM y").format(
          DateTime.parse(notificationCreatedDate));
    }
  }
}

_seenNotificationView() {
  return ListView.builder(
      itemCount: 2,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: marginLayout.copyWith(top: 1),
          child: notificationInfoLayout(
              context: context,
              titleText: "Agnes Neslihan",
              subtext:
              "has added you as a Department headgbfdskfghdfsghoidsfhgdfsghdofihgoidfhgoidfhgoidfhgioihdfoghdfoghdfohgdfgd on Laravel department",
              min: "2 mins",
              iconColor: AppColor.successColor,
              iconUrl: Images.leave_notification,
              onAction: () {},
              unselectedColor: AppColor.backgroundColor,
              dateText: "2 Dec 2023"),
        );
      });
}

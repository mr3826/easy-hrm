import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/images.dart';

import '../../../../../common/widget/custom_icon_shape_style.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../controller/notification_controller.dart';

class NotificationViewLayout extends StatelessWidget {
  final int index;

  NotificationViewLayout({super.key, required this.index});

  final _controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
            child: SizedBox(
          child: index == 0 ? _newNotificationView() : _seenNotificationView(),
        )));
  }

  _newNotificationView() {
    return SingleChildScrollView(
      controller:
          Get.find<NotificationController>().newNotificationScrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: (_controller.newNotification != null &&
              _controller.newNotification!.isNotEmpty)
          ? Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _controller.newNotification?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      final notification =
                          _controller.newNotification?[index].notification;
                      return Column(
                        children: [
                          _getNotificationByContext(
                              notificationCreatedDate:
                                  notification?.createdAt ?? "",
                              index: index,
                              timeLineTimeInfo:
                                  notification?.timeline?.startDate ?? "",
                              changerName:
                                  "${notification?.changer?.profile?.firstName ?? ""} ${notification?.changer?.profile?.lastName ?? ""}",
                              notificationContext: notification?.context ?? "",
                              leaveTimeInfo:
                                  notification?.leave?.startDate ?? '',
                              departmentInfo:
                                  notification?.department?.name ?? "",
                              isDepartmentHead:
                                  (notification?.department?.managerId ==
                                      notification?.affectee?.id),
                              jobTitleInfo: notification?.job?.title ?? ""),
                          if (index == _controller.newNotification!.length - 1)
                            customSpacerHeight(height: 100)
                        ],
                      );
                    }),
                customSpacerHeight(height: 20),
                Get.find<NotificationController>()
                        .isMoreNewNotificationLoading
                        .isTrue
                    ? const Center(
                        child: CupertinoActivityIndicator(
                            radius: 18, color: Colors.blueAccent))
                    : Container()
              ],
            )
          : _emptyNotificationLayout(),
    );
  }

  _seenNotificationView() {
    return SingleChildScrollView(
      controller: _controller.seenNotificationScrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: (_controller.seenNotification != null &&
              _controller.seenNotification!.isNotEmpty)
          ? Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _controller.seenNotification?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) {
                      final notification =
                          _controller.seenNotification?[index].notification;
                      return Column(
                        children: [
                          _getNotificationByContext(
                              notificationCreatedDate:
                                  notification?.createdAt ?? "",
                              index: index,
                              timeLineTimeInfo:
                                  notification?.timeline?.startDate ?? "",
                              changerName:
                                  "${notification?.changer?.profile?.firstName ?? ""} ${notification?.changer?.profile?.lastName ?? ""}",
                              notificationContext: notification?.context ?? "",
                              leaveTimeInfo:
                                  notification?.leave?.startDate ?? '',
                              departmentInfo:
                                  notification?.department?.name ?? "",
                              isDepartmentHead:
                                  (notification?.department?.managerId ==
                                      notification?.affectee?.id),
                              jobTitleInfo: notification?.job?.title ?? ""),
                          if (index == _controller.seenNotification!.length - 1)
                            customSpacerHeight(height: 100)
                        ],
                      );
                    }),
                customSpacerHeight(height: 20),
                _controller.isMoreSeenNotificationLoading.isTrue
                    ? const Center(
                        child: CupertinoActivityIndicator(
                            radius: 18, color: Colors.blueAccent))
                    : Container()
              ],
            )
          : _emptyNotificationLayout(),
    );
  }

  _getNotificationByContext({
    required String notificationContext,
    required String changerName,
    required String timeLineTimeInfo,
    required String leaveTimeInfo,
    required String notificationCreatedDate,
    required String departmentInfo,
    required int index,
    required bool isDepartmentHead,
    required String jobTitleInfo,
  }) {
    print("""
    timeLineTimeInfo: $timeLineTimeInfo
    leaveTimeInfo:: $leaveTimeInfo
    """);
    switch (notificationContext) {
      /// timeline
      case "reject_a_timeline":
        return _timeLineNotification(
            changerName: changerName,
            iconColor: AppColor.errorColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            timeLineTimeInfo: _getCreationDate(creationDate: timeLineTimeInfo),
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            index: index);
      case "pending_a_timeline":
        return _timeLineNotification(
            changerName: changerName,
            iconColor: AppColor.pendingColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            timeLineTimeInfo: _getCreationDate(creationDate: timeLineTimeInfo),
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            index: index);
      case "added_new_timeline":
        return _timeLineNotification(
            changerName: changerName,
            iconColor: AppColor.successColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            timeLineTimeInfo: _getCreationDate(creationDate: timeLineTimeInfo),
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            index: index);
      case "approved_a_timeline":
        return _timeLineNotification(
            changerName: changerName,
            iconColor: AppColor.successColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            timeLineTimeInfo: _getCreationDate(creationDate: timeLineTimeInfo),
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            index: index);

      case "added_timeline_approver":
        return _addedAsApproverNotification(
          changerName: changerName,
          index: index,
          isForLeaveApprover: false,
          contextInfoText:
              _getContextInfoText(contextName: notificationContext),
          notificationDuration: _getNotificationDuration(
              notificationCreatedDate: notificationCreatedDate),
          approverContext: AppString.timelogApprover.tr,
        );

      /// leave
      case "pending_a_leave":
        return _leaveNotification(
            changerName: changerName,
            iconColor: AppColor.pendingColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            leaveTimeInfo: _getCreationDate(creationDate: leaveTimeInfo),
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            index: index);
      case "approved_a_leave":
        return _leaveNotification(
            changerName: changerName,
            iconColor: AppColor.successColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            leaveTimeInfo: _getCreationDate(creationDate: leaveTimeInfo),
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            index: index);

      case "rejected_a_leave":
        return _leaveNotification(
            changerName: changerName,
            iconColor: AppColor.errorColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            leaveTimeInfo: _getCreationDate(creationDate: leaveTimeInfo),
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            index: index);

      case "cancelled_a_leave":
        return _leaveNotification(
            changerName: changerName,
            iconColor: AppColor.errorColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            leaveTimeInfo: _getCreationDate(creationDate: leaveTimeInfo),
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            index: index);
      case "added_leave":
        print("added_leave:: $leaveTimeInfo");
        return _leaveNotification(
            changerName: changerName,
            iconColor: AppColor.successColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            leaveTimeInfo: _getCreationDate(creationDate: leaveTimeInfo),
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            index: index);
      case "updated_leave":
        return _leaveNotification(
            changerName: changerName,
            iconColor: AppColor.successColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            leaveTimeInfo: _getCreationDate(creationDate: leaveTimeInfo),
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            index: index);

      case "added_leave_approver":
        return _addedAsApproverNotification(
          changerName: changerName,
          index: index,
          isForLeaveApprover: true,
          contextInfoText:
              _getContextInfoText(contextName: notificationContext),
          notificationDuration: _getNotificationDuration(
              notificationCreatedDate: notificationCreatedDate),
          approverContext: AppString.leaveApprover.tr,
        );

      ///department
      case "added_to_department":
        return isDepartmentHead == false
            ? _departmentNotification(
                changerName: changerName,
                iconColor: AppColor.primaryColor,
                contextInfoText: _getContextInfoText(
                    contextName: notificationContext,
                    isDepartHead: isDepartmentHead),
                departmentInfo: departmentInfo,
                notificationDuration: _getNotificationDuration(
                    notificationCreatedDate: notificationCreatedDate),
                index: index)
            : _departmentNotificationForDepartmentHead(
                changerName: changerName,
                iconColor: AppColor.primaryColor,
                contextInfoText: _getContextInfoText(
                    contextName: notificationContext,
                    isDepartHead: isDepartmentHead),
                departmentInfo: departmentInfo,
                notificationDuration: _getNotificationDuration(
                    notificationCreatedDate: notificationCreatedDate),
                departmentRoleInfo: AppString.departmentHeaDText.tr,
                index: index);

      case "removed_from_department":
        return _departmentNotification(
            changerName: changerName,
            iconColor: AppColor.primaryColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            departmentInfo: departmentInfo,
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            index: index);

      ///hiring manager
      case "added_to_hiring_manager":
        return _hiringManager(
            changerName: changerName,
            iconColor: AppColor.primaryColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            index: index);

      ///hiring team
      case "added_to_hiring_team":
        return _hiringTeamWithJobName(
            changerName: changerName,
            iconColor: AppColor.primaryColor,
            contextInfoText:
                _getContextInfoText(contextName: notificationContext),
            notificationDuration: _getNotificationDuration(
                notificationCreatedDate: notificationCreatedDate),
            jobTitleInfo: jobTitleInfo,
            index: index);

      case "new_user_joined":
        return _newUserNotification(
          index: index,
          contextInfoText:
              _getContextInfoText(contextName: notificationContext),
          notificationDuration: _getNotificationDuration(
              notificationCreatedDate: notificationCreatedDate),
        );

      default:
        return Container();
    }
  }

  String _getContextInfoText(
      {required String contextName, bool? isDepartHead}) {
    switch (contextName) {
      ///timeline
      case "reject_a_timeline":
        return AppString.rejectedATimelogText.tr;
      case "pending_a_timeline":
        return AppString.pendingATimelogText.tr;
      case "added_new_timeline":
        return AppString.addedATimelogText.tr;
      case "approved_a_timeline":
        return AppString.approveATimelogText.tr;

      ///timeline
      ///leave
      case "pending_a_leave":
        return AppString.pendingALeaveText.tr;
      case "approved_a_leave":
        return AppString.approvedALeaveText.tr;
      case "rejected_a_leave":
        return AppString.rejectALeaveText.tr;
      case "cancelled_a_leave":
        return AppString.cancelALeaveText.tr;
      case "added_leave":
        return AppString.addedALeaveText.tr;
      case "updated_leave":
        return AppString.updateALeaveText.tr;

      ///leave
      ///department

      case "added_to_department":
        return isDepartHead != null && isDepartHead == true
            ? AppString.addedDepartmentHead.tr
            : AppString.addedDepartment.tr;

      case "removed_from_department":
        return AppString.removeDepartment.tr;

      case "added_to_hiring_team":
        return AppString.addedDepartmentHead.tr;

      case "new_user_joined":
        return AppString.newUserJoined.tr;

      default:
        return AppString.addedDepartmentHead.tr;
    }
  }

  ///department

  _departmentNotification(
      {required String changerName,
      required Color iconColor,
      required String contextInfoText,
      required String departmentInfo,
      required String notificationDuration,
      required int index}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 18,bottom: 18,left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        color: index.isOdd ? Colors.blueAccent.withOpacity(0.05) : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customIconShapeStyle(
              image: Images.department_notification, color: iconColor),
          customSpacerWidth(width: 20),
          SizedBox(
            width: Get.width / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  changerName,
                  style: _titleTextStyle(),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: contextInfoText,
                          style: _contentTextStyle()),
                      TextSpan(
                        text: departmentInfo,
                        style: _dateTextStyle(),
                      ),
                    ],
                  ),
                ),
                Text(
                  notificationDuration,
                  style: _minTextStyle(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ///department with job title

  _departmentNotificationForDepartmentHead(
      {required String changerName,
      required Color iconColor,
      required String contextInfoText,
      required String departmentInfo,
      required String notificationDuration,
      required String departmentRoleInfo,
      required int index}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 18,bottom: 18,left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        color: index.isOdd ? Colors.blueAccent.withOpacity(0.05) : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customIconShapeStyle(
              image: Images.department_notification, color: iconColor),
          customSpacerWidth(width: 20),
          SizedBox(
            width: Get.width / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  changerName,
                  style: _titleTextStyle(),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: contextInfoText,
                          style:_contentTextStyle()),
                      TextSpan(
                        text: departmentRoleInfo,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.fontSizeDefault,
                            color: AppColor.secondaryColor),
                      ),
                      TextSpan(
                          text: " on ",
                          style: _contentTextStyle()),
                      TextSpan(
                        text: departmentInfo,
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
                  style: _minTextStyle(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// hiring manager
  _hiringManager(
      {required String changerName,
      required Color iconColor,
      required String contextInfoText,
      required String notificationDuration,
      required int index}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 18,bottom: 18,left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        color: index.isOdd ? Colors.blueAccent.withOpacity(0.05) : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customIconShapeStyle(
              image: Images.announment_notification, color: iconColor),
          customSpacerWidth(width: 20),
          SizedBox(
            width: Get.width / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  changerName,
                  style:_titleTextStyle(),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: contextInfoText,
                          style:_contentTextStyle()),
                      TextSpan(
                        text: AppString.textHiringManager.tr,
                        style: _dateTextStyle(),
                      ),
                    ],
                  ),
                ),
                Text(
                  notificationDuration,
                  style:_minTextStyle(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ///hiring team
  _hiringTeamWithJobName(
      {required String changerName,
      required Color iconColor,
      required String contextInfoText,
      required String jobTitleInfo,
      required String notificationDuration,
      required int index}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 18,bottom: 18,left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        color: index.isOdd ? Colors.blueAccent.withOpacity(0.05) : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customIconShapeStyle(
              image: Images.department_notification, color: iconColor),
          customSpacerWidth(width: 20),
          SizedBox(
            width: Get.width / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  changerName,
                  style: _titleTextStyle(),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: contextInfoText,
                          style: _contentTextStyle()),
                      TextSpan(
                        text: AppString.textHiringTeam.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.fontSizeDefault,
                            color: AppColor.secondaryColor),
                      ),
                      TextSpan(
                          text: " ${AppString.textOn.tr} ",
                          style: TextStyle(
                            color: AppColor.normalTextColor,
                            fontSize: Dimensions.fontSizeDefault,
                          )),
                      TextSpan(
                        text: jobTitleInfo,
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
                  style: _minTextStyle(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ///leave info

  _leaveNotification(
      {required String changerName,
      required Color iconColor,
      required String contextInfoText,
      required String leaveTimeInfo,
      required String notificationDuration,
      required int index}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 18,bottom: 18,left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        color: index.isOdd ? Colors.blueAccent.withOpacity(0.05) : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customIconShapeStyle(
              image: Images.leave_notification, color: iconColor),
          customSpacerWidth(width: 20),
          SizedBox(
            width: Get.width / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  changerName,
                  style: _titleTextStyle(),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: contextInfoText,
                          style: _contentTextStyle()
                      ),
                      TextSpan(
                        text: leaveTimeInfo,
                        style: _dateTextStyle(),
                      ),
                    ],
                  ),
                ),
                Text(
                  notificationDuration,
                  style: _minTextStyle(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// time log info
  _timeLineNotification(
      {required String changerName,
      required Color iconColor,
      required String contextInfoText,
      required String timeLineTimeInfo,
      required String notificationDuration,
      required int index}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 18,bottom: 18,left: 10,right: 10),
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
                  style: _titleTextStyle(),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: contextInfoText,
                          style:_contentTextStyle()),
                      TextSpan(
                        text: timeLineTimeInfo,
                        style: _dateTextStyle(),
                      ),
                    ],
                  ),
                ),
                Text(
                  notificationDuration,
                  style:_minTextStyle(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ///added as approver

  _addedAsApproverNotification(
      {required String changerName,
      required bool isForLeaveApprover,
      required String contextInfoText,
      required String approverContext,
      required String notificationDuration,
      required int index}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 18,bottom: 18,left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        color: index.isOdd ? Colors.blueAccent.withOpacity(0.05) : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customIconShapeStyle(
              image: isForLeaveApprover == true
                  ? Images.leave_notification
                  : Images.time_log_notification,
              color: AppColor.primaryColor),
          customSpacerWidth(width: 20),
          SizedBox(
            width: Get.width / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  changerName,
                  style: _titleTextStyle(),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: contextInfoText,
                          style: _contentTextStyle()),
                      TextSpan(
                        text: approverContext,
                        style: _dateTextStyle(),
                      ),
                    ],
                  ),
                ),
                Text(
                  notificationDuration,
                  style: _minTextStyle(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _newUserNotification(
      {required String contextInfoText,
      required String notificationDuration,
      required int index}) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 18,bottom: 18,left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        color: index.isOdd ? Colors.blueAccent.withOpacity(0.05) : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customIconShapeStyle(
              image: Images.announment_notification,
              color: AppColor.primaryColor),
          customSpacerWidth(width: 20),
          SizedBox(
            width: Get.width / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: contextInfoText,
                          style: _contentTextStyle()),
                    ],
                  ),
                ),
                Text(
                  notificationDuration,
                  style: _minTextStyle(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String _getNotificationDuration({required String notificationCreatedDate}) {
    if (notificationCreatedDate.isEmpty) return "";

    DateTime startTime = DateTime.parse(notificationCreatedDate);
    DateTime endTime = DateTime.now();

    // Calculate the duration between the two times
    Duration duration = endTime.difference(startTime);

    if (duration.inDays < 1 && !duration.isNegative) {
      //hr, mins
      int diffHr = duration.inHours;
      int diffMin = duration.inMinutes.remainder(60);
      if (diffHr < 1) {
        return diffMin < 2 ? "$diffMin min" : "$diffMin mins";
      } else {
        return "$diffHr ${diffHr > 1 ? "hrs" : "hr"} $diffMin ${diffMin > 1 ? "mins" : "min"}";
      }
    } else if (duration.inDays == 1) {
      return AppString.text_yesterday.tr;
    } else {
      return DateFormat("d MMM y")
          .format(DateTime.parse(notificationCreatedDate));
    }
  }

  _getCreationDate({required String creationDate}) {
    if (creationDate.isEmpty) return "";
    return DateFormat("d MMM y").format(DateTime.parse(creationDate));
  }
  _titleTextStyle(){
    return AppStyle.normal_text_grey.copyWith(
        color: AppColor.secondaryColor.withOpacity(0.9),
        fontSize: Dimensions.fontSizeDefault);
  }

  _minTextStyle() {
    return  AppStyle.mid_large_text.copyWith(
        color: AppColor.normalTextColor.withOpacity(0.5),
        fontSize: Dimensions.fontSizeDefault-2);
  }

  _contentTextStyle() {
    return AppStyle.normal_text.copyWith(
        color: AppColor.normalTextColor.withOpacity(0.7),
        fontWeight: FontWeight.w400,
        fontSize: Dimensions.fontSizeDefault);
  }

  _dateTextStyle() {
    return AppStyle.normal_text.copyWith(
        color: AppColor.normalTextColor.withOpacity(0.8),
        fontWeight: FontWeight.w600,
        fontSize: Dimensions.fontSizeDefault-1);
  }
}

_emptyNotificationLayout() {
  return SizedBox(
    height: MediaQuery.of(Get.context!).size.height / 1.8,
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: AppLayout.getWidth(200),
            child: Image.asset(Images.emptyNotification)),
        Text(
          "${AppString.text_you_have_seen_all_notification.tr}.",
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor,
              fontSize: Dimensions.fontSizeDefault - 2),
        ),
      ],
    )),
  );
}



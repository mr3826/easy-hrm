import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/modules/notification/controller/notification_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/images.dart';

import '../../../../common/widget/custom_icon_shape_style.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';

class NotificationViewLayout extends StatelessWidget {
  final int index;

  NotificationViewLayout({super.key, required this.index});

  final _controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: SizedBox(
            child:
                index == 0 ? _newNotificationView() : _seenNotificationView(),
          ),
        ));
  }

  _newNotificationView() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              controller: Get.find<NotificationController>()
                  .newNotificationScrollController,
              itemCount: _controller.newNotification?.length ?? 0,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                final notification =
                    _controller.newNotification?[index].notification;
                return Column(
                  children: [
                    _getNotificationByContext(
                        notificationCreatedDate: notification?.createdAt ?? "",
                        index: index,
                        timeLineTimeInfo:
                            notification?.timeline?.startDate ?? "",
                        changerName:
                            "${notification?.changer?.profile?.firstName ?? ""} ${notification?.changer?.profile?.lastName ?? ""}",
                        notificationContext: notification?.context ?? "",
                        leaveTimeInfo: notification?.leave?.startDate ?? '',
                        departmentInfo: notification?.department?.name ?? "",
                        isDepartmentHead:
                            (notification?.department?.managerId ==
                                notification?.affectee?.id),
                        jobTitleInfo: notification?.job?.title ?? ""),
                    if (index == _controller.newNotification!.length - 1)
                      customSpacerHeight(height: 100)
                  ],
                );
              }),
        ),
        customSpacerHeight(height: 20),
        Get.find<NotificationController>().isMoreNewNotificationLoading.isTrue
            ? const Center(
                child: CupertinoActivityIndicator(
                    radius: 18, color: Colors.blueAccent))
            : Container()
      ],
    );
  }

  _seenNotificationView() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              controller: _controller.seenNotificationScrollController,
              itemCount: _controller.seenNotification?.length ?? 0,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                final notification =
                    _controller.seenNotification?[index].notification;
                return Column(
                  children: [
                    _getNotificationByContext(
                        notificationCreatedDate: notification?.createdAt ?? "",
                        index: index,
                        timeLineTimeInfo:
                            notification?.timeline?.startDate ?? "",
                        changerName:
                            "${notification?.changer?.profile?.firstName ?? ""} ${notification?.changer?.profile?.lastName ?? ""}",
                        notificationContext: notification?.context ?? "",
                        leaveTimeInfo: notification?.leave?.startDate ?? '',
                        departmentInfo: notification?.department?.name ?? "",
                        isDepartmentHead:
                            (notification?.department?.managerId ==
                                notification?.affectee?.id),
                        jobTitleInfo: notification?.job?.title ?? ""),
                    if (index == _controller.seenNotification!.length - 1)
                      customSpacerHeight(height: 100)
                  ],
                );
              }),
        ),
        customSpacerHeight(height: 20),
        _controller.isMoreSeenNotificationLoading.isTrue
            ? const Center(
                child: CupertinoActivityIndicator(
                    radius: 18, color: Colors.blueAccent))
            : Container()
      ],
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
          contextInfoText:
              _getContextInfoText(contextName: notificationContext),
          notificationDuration: _getNotificationDuration(
              notificationCreatedDate: notificationCreatedDate),
          approverContext: "Timelog approver",
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
          contextInfoText:
              _getContextInfoText(contextName: notificationContext),
          notificationDuration: _getNotificationDuration(
              notificationCreatedDate: notificationCreatedDate),
          approverContext: "Leave approver",
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
                departmentRoleInfo: "Department Head",
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
        return "has reject your time log on ";
      case "pending_a_timeline":
        return "has marked your time log as pending on ";
      case "added_new_timeline":
        return "has added your time log on ";
      case "approved_a_timeline":
        return "has approved your time log on ";

      ///timeline
      ///leave
      case "pending_a_leave":
        return "has marked your leave as pending on ";
      case "approved_a_leave":
        return "has approved a leave on ";
      case "rejected_a_leave":
        return "has rejected a leave on ";
      case "cancelled_a_leave":
        return "has cancelled a leave on ";
      case "added_leave":
        return "has added a leave on ";
      case "updated_leave":
        return "has updated a leave on ";

      ///leave
      ///department

      case "added_to_department":
        return isDepartHead != null && isDepartHead == true
            ? "has added you as a "
            : "has added you on ";

      case "removed_from_department":
        return "has removed you from ";

      case "added_to_hiring_team":
        return "has added you as a ";

      case "new_user_joined":
        return "A new user has joined";

      default:
        return 'has added you as a ';
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        text: departmentRoleInfo,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.fontSizeDefault,
                            color: AppColor.secondaryColor),
                      ),
                      TextSpan(
                          text: " on ",
                          style: TextStyle(
                            color: AppColor.normalTextColor,
                            fontSize: Dimensions.fontSizeDefault,
                          )),
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

  /// hiring manager
  _hiringManager(
      {required String changerName,
      required Color iconColor,
      required String contextInfoText,
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
                        text: "Hiring Manager",
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        text: "Hiring team",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.fontSizeDefault,
                            color: AppColor.secondaryColor),
                      ),
                      TextSpan(
                          text: " on ",
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        text: leaveTimeInfo,
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

  ///added as approver

  _addedAsApproverNotification(
      {required String changerName,
      required String contextInfoText,
      required String approverContext,
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
              image: Images.announment_notification,
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
                        text: approverContext,
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

  _newUserNotification(
      {required String contextInfoText,
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
                          style: TextStyle(
                            color: AppColor.normalTextColor,
                            fontSize: Dimensions.fontSizeDefault,
                          )),
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
      return "Yesterday";
    } else {
      return DateFormat("d MMM y")
          .format(DateTime.parse(notificationCreatedDate));
    }
  }

  _getCreationDate({required String creationDate}) {
    if (creationDate.isEmpty) return "";
    return DateFormat("d MMM y").format(DateTime.parse("2024-01-21T16:40:00"));
  }
}

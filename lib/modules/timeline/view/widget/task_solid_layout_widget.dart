import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payrun_mobile/common/controller/convart_color_code_controller.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../enum.dart';
import '../../../../utils/utils.dart';
import '../../controller/time_formate_controller.dart';

class TaskSolidLayout extends StatelessWidget {
  final String taskName;
  final String startDateTime;
  final String endDateTime;
  final String status;
  final String duration;
  final String projectName;
  final String projectColors;
  final bool? isForLeave;

  const TaskSolidLayout(
      {required this.taskName,
      required this.startDateTime,
      required this.endDateTime,
      required this.status,
      required this.duration,
      required this.projectName,
      required this.projectColors,
      this.isForLeave,
      super.key});

  @override
  Widget build(BuildContext context) {
    print("""
  taskName:$taskName
  startDateTime:$startDateTime
  endDateTime:$endDateTime
  status:$status
  duration:$duration
  isForLeave:$isForLeave
  colors:$projectColors
    """);

    return isForLeave == true ? _leaveTaskLayout() : _taskCard();
  }

  _endTimeLayout(statusColor, statusIcon, iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          endDateTime.isNotEmpty
              ? timeFormatTo24h(DateTime.parse(endDateTime))
              : timeFormatTo24h(DateTime.now()),
          style: AppStyle.mid_large_text.copyWith(
              color: statusColor,
              fontSize: Dimensions.fontSizeDefault - 2,
              overflow: TextOverflow.ellipsis),
        ),
        Icon(
          statusIcon,
          color: iconColor,
          size: 20,
        )
      ],
    );
  }

  _style(statusColor) {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        side: BorderSide(width: .6, color: statusColor));
  }

  _startTimeLayout(statusColor) {
    return Text(
      timeFormatTo24h(DateTime.parse(startDateTime)),
      style: AppStyle.mid_large_text.copyWith(
          color: statusColor,
          fontSize: Dimensions.fontSizeDefault - 2,
          overflow: TextOverflow.ellipsis),
    );
  }

  Color _updateColorAccordingToApiResponseForTimelog() =>
      HexColor(projectColors.isNotEmpty ? projectColors : "#2C67FF");

  Color _colorForIconAccordingToApiResponseTimelog() =>
      HexColor(projectColors.isNotEmpty ? projectColors : "#2C67FF");

  IconData _updateIconAccordingToApiResponse() {
    switch (status) {
      case "approved":
        return Icons.done;
      case "pending":
        return Icons.timeline_outlined;
      case "reject":
        return Icons.block_flipped;
      default:
        return Icons.cached;
    }
  }

  int _getTimeDifference({required String startTime, required String endTime}) {
    if (startTime.isEmpty) {
      startTime = DateTime.now().toString();
    }
    if (endDateTime.isEmpty) {
      endTime = DateTime.now().toString();
    }
    return DateTime.parse(endTime)
        .difference(DateTime.parse(startTime))
        .inMinutes;
  }

  Widget _taskCard() {
    _updateColorAccordingToApiResponseForTimelog();
    _updateIconAccordingToApiResponse();
    switch (
        _getTimeDifference(startTime: startDateTime, endTime: endDateTime)) {
      case < 15:
        return Card(
          elevation: 0,
          color:
              _updateColorAccordingToApiResponseForTimelog().withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponseForTimelog()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(),
          ),
        );
      case > 15 && < 30:
        return Card(
          elevation: 0,
          color:
              _updateColorAccordingToApiResponseForTimelog().withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponseForTimelog()),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _startTimeLayout(
                    _updateColorAccordingToApiResponseForTimelog()),
              ],
            ),
          ),
        );
      case > 30 && < 55:
        return Card(
          elevation: 0,
          color:
              _updateColorAccordingToApiResponseForTimelog().withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponseForTimelog()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _startTimeLayout(
                    _updateColorAccordingToApiResponseForTimelog()),
                Text(
                  projectName.isNotEmpty ? projectName : taskName,
                  maxLines: 1,
                  style: AppStyle.mid_large_text.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: _updateColorAccordingToApiResponseForTimelog(),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        );
      default:
        return Card(
          elevation: 0,
          color:
              _updateColorAccordingToApiResponseForTimelog().withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponseForTimelog()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _startTimeLayout(
                    _updateColorAccordingToApiResponseForTimelog()),
                customSpacerHeight(height: 6),
                Text(
                  projectName.isNotEmpty ? projectName : taskName,
                  maxLines: 1,
                  style: AppStyle.mid_large_text.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: _updateColorAccordingToApiResponseForTimelog(),
                      overflow: TextOverflow.ellipsis),
                ),
                customSpacerHeight(height: 6),
                Text(
                  duration.isNotEmpty
                      ? convertMiniToHour(
                          Duration(minutes: int.parse(duration)))
                      : convertMiniToHour(Duration(
                          minutes: DateTime.now()
                              .difference(DateTime.parse(startDateTime))
                              .inMinutes)),
                  style: AppStyle.mid_large_text.copyWith(
                      fontSize: Dimensions.fontSizeDefault - 2,
                      color: _updateColorAccordingToApiResponseForTimelog(),
                      overflow: TextOverflow.ellipsis),
                ),
                const Spacer(),
                _endTimeLayout(
                    _updateColorAccordingToApiResponseForTimelog(),
                    _updateIconAccordingToApiResponse(),
                    _colorForIconAccordingToApiResponseTimelog())
              ],
            ),
          ),
        );
    }
  }

  Color _updateColorAccordingToApiResponse({required String status}) {
    switch (status) {
      case "pending":
        return AppColor.pendingColor;
      case "approved":
        return AppColor.successColor;
      case "taken":
        return AppColor.takenColor;
      case "reject":
        return AppColor.errorColorLight;
      case "cancelled":
        return AppColor.errorColor;
      case "rejected":
        return AppColor.errorColor;
      default:
        return AppColor.hintColor;
    }
  }

  Color _colorForIconAccordingToApiResponse({required String status}) {
    switch (status) {
      case "pending":
        return AppColor.pendingColor;
      case "approved":
        return AppColor.successColor;
      case "taken":
        return AppColor.noColor;
      case "reject":
        return AppColor.errorColorLight;
      case "cancelled":
        return AppColor.noColor;
      case "rejected":
        return AppColor.noColor;
      default:
        return AppColor.hintColor;
    }
  }

  Widget _leaveTaskLayout() {
    switch (
        _getTimeDifference(startTime: startDateTime, endTime: endDateTime)) {
      case < 15:
        return Card(
          elevation: 0,
          color: _updateColorAccordingToApiResponse(status: status)
              .withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponse(status: status)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(),
          ),
        );
      case > 15 && < 30:
        return Card(
          elevation: 0,
          color: _updateColorAccordingToApiResponse(status: status)
              .withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponse(status: status)),
          child: Stack(
            children: [
              _backgroundLayout(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _startTimeLayout(
                        _updateColorAccordingToApiResponse(status: status)),
                  ],
                ),
              ),
            ],
          ),
        );
      case > 30 && < 55:
        return Card(
          elevation: 0,
          color: _updateColorAccordingToApiResponse(status: status)
              .withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponse(status: status)),
          child: Stack(
            children: [
              _backgroundLayout(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _startTimeLayout(
                        _updateColorAccordingToApiResponse(status: status)),
                    Text(
                      taskName,
                      maxLines: 1,
                      style: AppStyle.mid_large_text.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: _updateColorAccordingToApiResponse(
                              status: status),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      default:
        return Card(
          elevation: 0,
          color: _updateColorAccordingToApiResponse(status: status)
              .withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponse(status: status)),
          child: Stack(
            children: [
              _backgroundLayout(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _startTimeLayout(
                        _updateColorAccordingToApiResponse(status: status)),
                    customSpacerHeight(height: 6),
                    Text(
                      taskName,
                      maxLines: 1,
                      style: AppStyle.mid_large_text.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: _updateColorAccordingToApiResponse(
                              status: status),
                          overflow: TextOverflow.ellipsis),
                    ),
                    customSpacerHeight(height: 6),
                    Text(
                      duration.isNotEmpty
                          ? convertMiniToHour(
                              Duration(minutes: int.parse(duration)))
                          : convertMiniToHour(Duration(
                              minutes: DateTime.now()
                                  .difference(DateTime.parse(startDateTime))
                                  .inMinutes)),
                      style: AppStyle.mid_large_text.copyWith(
                          fontSize: Dimensions.fontSizeDefault - 2,
                          color: _updateColorAccordingToApiResponse(
                              status: status),
                          overflow: TextOverflow.ellipsis),
                    ),
                    const Spacer(),
                    _endTimeLayout(
                        _updateColorAccordingToApiResponse(status: status),
                        _updateIconAccordingToApiResponse(),
                        _colorForIconAccordingToApiResponse(status: status))
                  ],
                ),
              ),
            ],
          ),
        );
    }
  }

  _backgroundLayout() {
    return SvgPicture.asset(
      _getStatusViewLayout(status),
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fill,
    );
  }
}

Widget nullContainer(
    {required bgColor,
    required taskText,
    required int totalTime,
    required startTime,
    endTime}) {
  return Card(
    elevation: 0,
    color: bgColor.withOpacity(0.09),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        side: BorderSide(width: .5, color: bgColor)),
    child: 1 > totalTime
        ? Padding(
            padding:
                const EdgeInsets.only(left: 6.0, top: 2, right: 2, bottom: 2),
            child: Text(
              taskText = "$startTime",
              maxLines: 1,
              style: AppStyle.mid_large_text.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: bgColor,
                  overflow: TextOverflow.ellipsis),
            ),
          )
        : Container(
            color: bgColor.withOpacity(0.09),
          ),
  );
}

_getStatusViewLayout(String leaveStatus) {
  if (leaveStatus.toLowerCase() == LeaveStatus.approved.name) {
    return Images.LEAVE_APPROVED;
  } else if (leaveStatus.toLowerCase() == LeaveStatus.rejected.name) {
    return Images.LEAVE_REJECTED;
  } else if (leaveStatus.toLowerCase() == LeaveStatus.pending.name) {
    return Images.LEAVE_PENDDING;
  } else if (leaveStatus.toLowerCase() == LeaveStatus.taken.name) {
    return Images.LEAVE_TAKAN;
  } else if (leaveStatus.toLowerCase() == LeaveStatus.cancelled.name) {
    return Images.LEAVE_REJECTED;
  } else {
    return Images.LEAVE_APPROVED;
  }
}

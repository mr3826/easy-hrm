import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../utils/utils.dart';
import '../../controller/time_formate_controller.dart';

class TaskSolidLayout extends StatelessWidget {
  final String taskName;
  final String startDateTime;
  final String endDateTime;
  final String status;
  final String duration;
  final bool? isForLeave;

  const TaskSolidLayout(
      {required this.taskName,
      required this.startDateTime,
      required this.endDateTime,
      required this.status,
      required this.duration,
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
    """);

    _updateColorAccordingToApiResponse();
    _updateIconAccordingToApiResponse();
    return _taskCard();
  }

  _endTimeLayout(statusColor, statusIcon, iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          timeFormatTo24h(DateTime.tryParse(endDateTime) ?? DateTime.now()),
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

  Color _updateColorAccordingToApiResponse() {
    switch (status) {
      case "pending":
        return AppColor.pendingColor;
      case "approved":
        return AppColor.primaryColor;
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

  Color _colorForIconAccordingToApiResponse() {
    switch (status) {
      case "pending":
        return AppColor.pendingColor;
      case "approved":
        return AppColor.primaryColor;
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
    switch (
        _getTimeDifference(startTime: startDateTime, endTime: endDateTime)) {
      case < 5:
        return Card(
          elevation: 0,
          color: _updateColorAccordingToApiResponse().withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponse()),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(),
          ),
        );
      case < 15:
        return Card(
          elevation: 0,
          color: _updateColorAccordingToApiResponse().withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponse()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(),
          ),
        );
      case < 30:
        return Card(
          elevation: 0,
          color: _updateColorAccordingToApiResponse().withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponse()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _startTimeLayout(_updateColorAccordingToApiResponse()),
              ],
            ),
          ),
        );
      case < 45:
        return Card(
          elevation: 0,
          color: _updateColorAccordingToApiResponse().withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponse()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _startTimeLayout(_updateColorAccordingToApiResponse()),
                Text(
                  taskName,
                  maxLines: 1,
                  style: AppStyle.mid_large_text.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: _updateColorAccordingToApiResponse(),
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        );
      default:
        return Card(
          elevation: 0,
          color: _updateColorAccordingToApiResponse().withOpacity(0.09),
          shape: _style(_updateColorAccordingToApiResponse()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _startTimeLayout(_updateColorAccordingToApiResponse()),
                customSpacerHeight(height: 6),
                Text(
                  taskName,
                  maxLines: 1,
                  style: AppStyle.mid_large_text.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: _updateColorAccordingToApiResponse(),
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
                      color: _updateColorAccordingToApiResponse(),
                      overflow: TextOverflow.ellipsis),
                ),
                const Spacer(),
                _endTimeLayout(
                    _updateColorAccordingToApiResponse(),
                    _updateIconAccordingToApiResponse(),
                    _colorForIconAccordingToApiResponse())
              ],
            ),
          ),
        );
    }
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

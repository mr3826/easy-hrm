import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';

class TaskSolidLayout extends StatelessWidget {
  final String title;
  final String startTime;
  final String endTime;
  final String status;
  final String totalMin;

  const TaskSolidLayout(
      {required this.title,
      required this.startTime,
      required this.endTime,
      required this.status,
        required this.totalMin,
      super.key});

  @override
  Widget build(BuildContext context) {
    Color color = AppColor.primaryColor;
    IconData iconData = Icons.done;

    String formatDuration = totalMin.substring(1, totalMin.length - 1);

    // Using int.parse() to convert the string to an integer
    int intValue = int.parse(formatDuration);
    // Create a Duration object from the total minutes
    Duration duration = Duration(minutes: intValue);
    // Format the Duration to the desired format
    String durationTime = convertMiniToHour(duration);
    String projectName = title.substring(1, title.length - 1);

    statusColor() {
      switch (status) {
        case "(approved)":
          return color = AppColor.primaryColor;
        case "(pending)":
          return color = AppColor.primaryOrange;
        case "(rejected)":
          return color = AppColor.errorColorLight;
        default:
          return color = AppColor.primaryColor;
      }
    }

    statusIcon() {
      switch (status) {
        case "(approved)":
          return iconData = Icons.done;
        case "(pending)":
          return iconData = Icons.timeline_outlined;
        case "(rejected)":
          return iconData = Icons.block_flipped;
        default:
          return iconData = Icons.done;
      }
    }

    return intValue>46?   Card(
      elevation: 0,
      color: statusColor().withOpacity(0.09),
      shape: _style(statusColor()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _startTimeLayout(statusColor()),
            customSpacerHeight(height: 6),
            Text(
              projectName,
              maxLines: 2,
              style: AppStyle.mid_large_text.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: statusColor(),
                  overflow: TextOverflow.ellipsis),
            ),
            customSpacerHeight(height: 6),
            Text(
              durationTime,
              style: AppStyle.mid_large_text.copyWith(
                  fontSize: Dimensions.fontSizeDefault - 2,
                  color: statusColor(),
                  overflow: TextOverflow.ellipsis),
            ),
            const Spacer(),
            _endTimeLayout(statusColor(), statusIcon())
          ],
        ),
      ),
    ):nullContainer(bgColor: statusColor(), taskText: projectName);
  }

  _endTimeLayout(statusColor, statusIcon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          endTime,
          style: AppStyle.mid_large_text.copyWith(
              color: statusColor,
              fontSize: Dimensions.fontSizeDefault - 2,
              overflow: TextOverflow.ellipsis),
        ),
        Icon(
          statusIcon,
          color: statusColor,
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
      startTime,
      style: AppStyle.mid_large_text.copyWith(
          color: statusColor,
          fontSize: Dimensions.fontSizeDefault - 2,
          overflow: TextOverflow.ellipsis),
    );
  }
}

Widget nullContainer({required bgColor, required taskText}) {
  return Card(
    elevation: 0,
    color: bgColor.withOpacity(0.09),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        side:  BorderSide(width: .5, color: bgColor)),
    child: Padding(
      padding: const EdgeInsets.only(left: 6.0,top: 2,right: 2,bottom: 2),
      child: Text(
        taskText="Not Added Yet",
        maxLines: 1,
        style: AppStyle.mid_large_text.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: bgColor,
            overflow: TextOverflow.ellipsis),
      ),
    ),
  );
}

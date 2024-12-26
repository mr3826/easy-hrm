import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../enum.dart';
import '../../utils/images.dart';
import '../../utils/utils.dart';

Widget customButtonSheetAppbar(
    {double? height,
    String? text,
    Widget? titleWidget,
    String? subtext,
    bool isLeave = false,
    String? status,
    String? duration,
    TextStyle? subTextStyle}) {
  if (isLeave) {
    return _leaveBtnAppbarLayout(
      text: text ?? "No title",
      subtext: subtext,
      status: status,
      duration: duration,
    );
  } else {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.leaveRecordCardColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18),
          topLeft: Radius.circular(18),
        ),
      ),
      height: height ?? 100,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titleWidget ??
              Text(
                text ?? "No title",
                style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.secondaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimensions.fontSizeDefault + 3,
                ),
              ),
          if (subtext != null) ...[
            Text(
              subtext,
              style: subTextStyle ??
                  AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    fontSize: Dimensions.fontSizeDefault,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

Widget _leaveBtnAppbarLayout({
  required String text,
  String? subtext,
  String? status,
  String? duration,
}) {
  return Stack(
    children: [
      _transformDashLayout(status),
      Positioned(
        top: 30,
        left: 30,
        bottom: 30,
        right: 30,
        child: Column(
          children: [
            if (subtext?.isNotEmpty ?? false)
              Center(
                child: Text(
                  subtext!,
                  style: AppStyle.normal_text_black.copyWith(
                    color: AppColor.normalTextColor,
                  ),
                ),
              )
            else
              Center(
                child: Text(
                  formatLeaveDate(text),
                  style: AppStyle.normal_text_black.copyWith(
                    color: AppColor.normalTextColor,
                  ),
                ),
              ),
            customSpacerHeight(height: 12),
            Text(
              AppString.text_duration.tr,
              style: AppStyle.normal_text_black.copyWith(fontSize: 12),
            ),
            Center(
              child: Text(
                _getDuration(duration),
                style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 8,
        left: 9,
        right: 9,
        child: Center(
          child: Container(
            height: 4,
            width: 140,
            decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
            ),
          ),
        ),
      ),
    ],
  );
}

String _getDuration(String? duration) {
  if (duration == null || duration.isEmpty) {
    return "No duration";
  }
  return duration == "1 day" ? "Full day" : duration;
}

_transformDashLayout(status) {
  return SizedBox(
    height: 135,
    width: double.infinity,
    child: SvgPicture.asset(
      _getStatusButton(status),
      fit: BoxFit.fill,
    ),
  );
}

Future customButtonSheet(
    {context,
    double height = 0.9,
    required Widget child,
    int duration = 500,
    bool? isDismissible,
    int reverseDuration = 400}) {
  final AnimationController controller = AnimationController(
    duration: Duration(milliseconds: duration),
    reverseDuration: Duration(milliseconds: reverseDuration),
    vsync: Navigator.of(context),
  );
  return showModalBottomSheet(
    context: context,
    transitionAnimationController: controller,
    isScrollControlled: true,
    enableDrag: isDismissible ?? true,
    backgroundColor: AppColor.cardColor,
    isDismissible: isDismissible ?? true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              Dimensions.radiusMid + 4,
            ),
            topLeft: Radius.circular(Dimensions.fontSizeMid + 4))),
    builder: (
      context,
    ) {
      return FractionallySizedBox(
        heightFactor: AppLayout.getHeight(height),
        child: child,
      );
    },
  );
}

_getStatusButton(String leaveStatus) {
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

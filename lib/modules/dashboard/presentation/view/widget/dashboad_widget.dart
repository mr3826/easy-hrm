import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../enum.dart';
import '../../../../../utils/app_color.dart';
import '../../../../leave/presentation/view/widget/status_btn_widget.dart';

Widget getStatusButton(String leaveStatus) {
  if (leaveStatus.toLowerCase() == LeaveStatus.approved.name) {
    return approvedStatusBtn();
  } else if (leaveStatus.toLowerCase() == LeaveStatus.rejected.name) {
    return rejectedStatusBtn();
  } else if (leaveStatus.toLowerCase() == LeaveStatus.pending.name) {
    return pendingStatusBtn();
  } else if (leaveStatus.toLowerCase() == LeaveStatus.taken.name) {
    return tokenStatusBtn();
  } else if (leaveStatus.toLowerCase() == LeaveStatus.cancelled.name) {
    return canceledStatusBtn();
  } else {
    return Container();
  }
}

Widget dotsDecorator({required currentIndex}) {
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

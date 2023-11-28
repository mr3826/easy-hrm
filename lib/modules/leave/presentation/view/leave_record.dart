import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/presentation/widget/leave_record_details_view.dart';
import 'package:payrun_mobile/modules/leave/presentation/widget/status_btn_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class LeaveRecordScreen extends StatelessWidget {
  const LeaveRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: AppString.text_leave_records),
      body: Column(
        children: [_leaveRecordViewLayout()],
      ),
    );
  }

  _leaveRecordViewLayout() {
    return Expanded(
        child: ListView.builder(
      padding: marginLayout,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [_dateTextLayout(date: "April,2022"), _infoLayoutView(context: context)],
        );
      },
    ));
  }

  _dateTextLayout({required date}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customSpacerHeight(height: 50),
        Container(
          height: 1,
          width: AppLayout.getWidth(120),
          color: AppColor.disableColor,
        ),
        Padding(
          padding: marginLayout,
          child: Text(
            date,
            style: AppStyle.normal_text_black.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault),
          ),
        ),
        Container(
          height: 1,
          width: AppLayout.getWidth(120),
          color: AppColor.disableColor,
        ),
      ],
    );
  }

  _infoLayoutView({required BuildContext context}) {
    return GestureDetector(
      onTap: ()=>customButtonSheet(context: context,child: const LeaveRecordDetails(status: "rejected",) ,height: 0.5),
      child: SizedBox(
        height: AppLayout.getHeight(110),
        child: Card(
          elevation: 0,
          shape: roundedRectangleBorder.copyWith(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
          color: AppColor.primaryColor.withOpacity(0.05),
          child: Padding(
            padding:
                marginLayout.copyWith(top: 10, bottom: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sick leave",
                      style: AppStyle.mid_large_text.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeDefault + 1,
                          fontWeight: FontWeight.w600),
                    ),
                    customSpacerHeight(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "22Apr -24 Apr",
                          style: AppStyle.mid_large_text.copyWith(
                              color: AppColor.secondaryColor.withOpacity(0.7),
                              fontSize: Dimensions.fontSizeDefault - 2,
                              fontWeight: FontWeight.w600),
                        ),
                        customSpacerWidth(width: 8),
                        Container(
                          height: 12,
                          width: 1,
                          color: AppColor.hintColor.withOpacity(0.8),
                        ),
                        customSpacerWidth(width: 8),
                        Text(
                          "2 days",
                          style: AppStyle.normal_text_black.copyWith(
                              color: AppColor.hintColor,
                              fontSize: Dimensions.fontSizeDefault - 1),
                        )
                      ],
                    ),
                    customSpacerHeight(height: 6),
                    Text(
                      "Paid",
                      style: AppStyle.normal_text_black.copyWith(
                          color: AppColor.hintColor,
                          fontSize: Dimensions.fontSizeDefault - 1),
                    )
                  ],
                ),
               approvedStatusBtn(),

                // rejectedStatusBtn(),
                // pendingStatusBtn(),
                // tokenStatusBtn(),



              ],
            ),
          ),
        ),
      ),
    );
  }

}

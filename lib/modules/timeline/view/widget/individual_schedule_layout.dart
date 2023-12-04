import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/horizontal_dotted_style.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

import 'horizontal_divider_layout.dart';

class IndividualTimeLayout extends StatelessWidget {
  IndividualTimeLayout({super.key});

  final List weekIndex = ["First week", "Second week", "Third week"];


  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemCount: weekIndex.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            weekTextLayout(date: weekIndex[index]),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: weekIndex.length,
              itemBuilder: (context, index) {
                return _infoTextLayout(index);
              },
            ),
          ],
        );
      },
    ));
  }

  Widget _infoTextLayout(index) {
    Color itemColor = index % 2 == 0 ? AppColor.primaryColor.withOpacity(0.03) : Colors.transparent;
    return Padding(
      padding: marginLayout,
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder,
        color:itemColor,
        child: Padding(
          padding: marginLayout.copyWith(top: 10,bottom: 10,left: 10,right: 10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("01",style: AppStyle.small_text_grey.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeMid)),
                  Text("Wed",style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-1),),
                ],
              ),
              const Spacer(),
              _divider(),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("8h",style: AppStyle.small_text_grey.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault)),
                  Text(AppString.text_schedule.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-3),),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("7.5h",style: AppStyle.small_text_grey.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault)),
                  Text(AppString.text_logged.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-3),),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("0.30h",style: AppStyle.small_text_grey.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault)),
                  Text(AppString.text_paid_leave.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-3),),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("0.30h",style: AppStyle.small_text_grey.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault)),
                  Text(AppString.text_balance.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-3),),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
  _divider() {
    return Container(
      width: 0.8,
      height: AppLayout.getHeight(30),
      color: AppColor.hintColor.withOpacity(0.6),
    );
  }
}

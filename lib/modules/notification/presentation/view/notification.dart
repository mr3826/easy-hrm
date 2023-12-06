import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/notification/presentation/widget/notification_custom_tabbar.dart';
import 'package:payrun_mobile/modules/notification/presentation/widget/notification_appbar_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';



class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: notificationAppbar(),
      body:  NotificationTabBar(),
      floatingActionButton:markAllBtn,
    );
  }
}
GestureDetector get markAllBtn{
  return GestureDetector(
    onTap: (){},
    child: Padding(
      padding:  const EdgeInsets.only(left: 38.0,bottom: 22),
      child: Container(
        height: AppLayout.getHeight(46),
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),color: AppColor.cardColor,
        border: Border.all(color: AppColor.disableColor)
        ),
        child: Center(child: Text(AppString.text_mark_all_as_seen.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault+1),)),
      ),
    ),
  );

}

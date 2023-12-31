import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import 'notification_view_layout.dart';

class NotificationTabBar extends StatelessWidget {
   NotificationTabBar({super.key});
 final currentIndex=0.obs;

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppLayout.getHeight(66),child: ListView.builder(
          itemCount: notificationTabBarIndex.length,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return Obx(() => GestureDetector(
              onTap: (){
                currentIndex.value=index;
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0,right: 12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                        border:  Border(
                          bottom: BorderSide(
                            color: currentIndex.value==index?AppColor.primaryColor:Colors.transparent,
                            width: 1.5,
                          ),)
                    ),
                    child: Row(
                      children: [
                        Text(notificationTabBarIndex[index],style: AppStyle.mid_large_text.copyWith(color:currentIndex.value==index?AppColor.primaryColor: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault+1,
                            fontWeight: currentIndex.value==index?FontWeight.w600:FontWeight.w500
                        ),),
                        customSpacerWidth(width: 4),
                        Card(
                          elevation: 0,
                          color: currentIndex.value==index?AppColor.primaryColor.withOpacity(0.2):AppColor.secondaryColor.withOpacity(0.2),
                          shape: roundedRectangleBorder.copyWith(borderRadius: BorderRadius.circular(6)),
                          child:  Padding(
                            padding: const EdgeInsets.only(left: 6.0,right: 6,top: 2,bottom: 2),
                            child:  Text("0.0",style: AppStyle.mid_large_text.copyWith(color:currentIndex.value==index?AppColor.primaryColor: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault-3,
                                fontWeight: currentIndex.value==index?FontWeight.w600:FontWeight.w500
                            ),),
                          ),
                        )
                      ],
                    )),
              ),
            ));
          },)),
        customSpacerHeight(height: 14),
        Obx(() => NotificationViewLayout(index: currentIndex.value)),
      ],
    );
  }
}

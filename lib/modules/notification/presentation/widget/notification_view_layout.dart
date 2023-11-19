import 'package:flutter/material.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/notification/presentation/widget/notification_info_sytle_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/images.dart';


class NotificationViewLayout extends StatelessWidget {
  final int index;
  const NotificationViewLayout({super.key,required this.index});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: index==0?_newNotificationView():_seenNotificationView(),
      ),
    );
  }

  _newNotificationView() {
    return ListView.builder(
        itemCount: 12,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
      return Padding(
        padding: marginLayout.copyWith(top: 1),
        child: notificationInfoLayout(context: context,titleText: "Agnes Neslihan",subtext:"has added you as a Department head on Laravel department", min: "2 mins",iconColor: AppColor.primaryColor,iconUrl: Images.department_notification,
            onAction: (){},
            unselectedColor: AppColor.backgroundColor,
            dateText: "2 Dec 2023"
        ),
      );
    }
    );
  }

  _seenNotificationView() {
    return ListView.builder(
        itemCount: 2,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: marginLayout.copyWith(top: 1),
            child: notificationInfoLayout(context: context,titleText: "Agnes Neslihan",subtext:"has added you as a Department head on Laravel department", min: "2 mins",iconColor: AppColor.successColor,iconUrl: Images.leave_notification,onAction: (){},
                unselectedColor: AppColor.backgroundColor,
              dateText: "2 Dec 2023"
            ),
          );
        }
    );
  }
}


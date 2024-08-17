import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../controller/notification_controller.dart';
import 'notification_view_layout.dart';

class NotificationTabBar extends StatelessWidget {
  const NotificationTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotificationController controller =
        Get.find<NotificationController>();
    final RxInt currentIndex = controller.notificationTabBarIndex;

    return RefreshIndicator(
      backgroundColor: AppColor.cardColor,
      onRefresh: _reloadPage,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabBar(currentIndex, controller),
          customSpacerHeight(height: 14),
          Obx(() => NotificationViewLayout(index: currentIndex.value)),
        ],
      ),
    );
  }

  Widget _buildTabBar(RxInt currentIndex, NotificationController controller) {
    return SizedBox(
      height: AppLayout.getHeight(66),
      child: ListView.builder(
        itemCount: notificationTabBarIndex.length,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Obx(() => _buildTabBarItem(index, currentIndex, controller));
        },
      ),
    );
  }

  Widget _buildTabBarItem(
      int index, RxInt currentIndex, NotificationController controller) {
    final isSelected = currentIndex.value == index;
    final notificationCount = index == 0
        ? controller.newNotificationLength
        : controller.seenNotificationLength;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: () {
          currentIndex.value = index;
          controller.notificationTabBarIndex.value = index;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColor.primaryColor : Colors.transparent,
                width: 1.5,
              ),
            ),
          ),
          child: Row(
            children: [
              Text(
                notificationTabBarIndex[index],
                style: AppStyle.mid_large_text.copyWith(
                  color:
                      isSelected ? AppColor.primaryColor : AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault + 1,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              customSpacerWidth(width: 4),
              Card(
                elevation: 0,
                color: isSelected
                    ? AppColor.primaryColor.withOpacity(0.2)
                    : AppColor.secondaryColor.withOpacity(0.2),
                shape: roundedRectangleBorder.copyWith(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
                  child: Text(
                    notificationCount.toString(),
                    style: AppStyle.mid_large_text.copyWith(
                      color: isSelected
                          ? AppColor.primaryColor
                          : AppColor.normalTextColor,
                      fontSize: Dimensions.fontSizeDefault - 3,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _reloadPage() async {
    Get.find<NotificationController>()
      ..notificationTabBarIndex.value = 0
      ..seenNotificationOffset.value = 0
      ..getNewNotifications()
      ..getSeenNotification();
  }
}

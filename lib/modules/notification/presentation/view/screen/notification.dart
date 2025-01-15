import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../controller/notification_controller.dart';
import '../widget/notification_appbar_widget.dart';
import '../widget/notification_custom_tabbar.dart';


class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notificationAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  /// Builds the body of the screen, which includes the notification tab bar.
  /// Shows a loading indicator while data is being fetched.
  Widget _buildBody() {
    return controller.obx(
          (state) => const NotificationTabBar(),
      onLoading: const LoadingIndicator(),
    );
  }

  /// Builds the floating action button. The button is only visible
  /// when the tab bar index is 0 and there are new notifications.
  /// Otherwise, it returns a SizedBox.shrink() to show nothing.
  Widget _buildFloatingActionButton() {
    return Obx(() {
      // Check if the current tab is not the first one or if there are no new notifications
      if (controller.notificationTabBarIndex.value != 0 ||
          controller.newNotification == null ||
          controller.newNotification!.isEmpty) {
        return const SizedBox.shrink(); // No button to show
      }

      // Return the mark all as seen button
      return _markAllBtn;
    });
  }

  /// Returns the widgets for the "Mark All As Seen" button.
  /// This button marks all notifications as seen when tapped.
  Widget get _markAllBtn {
    return GestureDetector(
      onTap: () => controller.markNotificationAsSeen(),
      child: Padding(
        padding: const EdgeInsets.only(left: 38.0, bottom: 22),
        child: Container(
          height: AppLayout.getHeight(46),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
            color: AppColor.cardColor,
            border: Border.all(color: AppColor.disableColor),
          ),
          child: Center(
            child: Text(
              AppString.text_mark_all_as_seen.tr,
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault + 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

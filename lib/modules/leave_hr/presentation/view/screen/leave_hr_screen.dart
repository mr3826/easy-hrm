import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import '../../../../../common/widget/custom_appbar.dart';
import '../../../../../common/widget/custom_svg_image.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';

// Create a controller to manage tab state
class LeaveController extends GetxController {
  var selectedTabIndex = 0.obs; // Observed variable for tab index

  // Method to update the tab index
  void updateTabIndex(int index) {
    selectedTabIndex.value = index;
  }
}

// Stateless widget for LeaveHrScreen
class LeaveHrScreen extends StatelessWidget {
  LeaveHrScreen({super.key});

  // Initialize the LeaveController
  final LeaveController leaveController = Get.put(LeaveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabBar(), // No need to pass the TabController
          Expanded(
            child: Obx(() {
              // Update the view based on the selected tab index
              return _buildTabContent(leaveController.selectedTabIndex.value);
            }),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return customAppbar(
      leadingIcon: Text(
        AppString.text_leave.tr,
        style: AppStyle.normal_text_black.copyWith(
          fontSize: Dimensions.fontSizeMid,
        ),
      ),
      leadingWidth: MediaQuery.of(Get.context!).size.width / 4.5,
      centerTitle: false,
      actions: [
        customSvgImage(
          imageUrl: Images.notificationIconNavOutLine,
          height: 26,
          width: 26,
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildTabBar() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTabBarTextWithBackground(AppString.textCalendar.tr, 0),
        _buildTabBarTextWithBackground(AppString.textLeaveRecord.tr, 1),
      ],
    ));
  }

  Widget _buildTabBarTextWithBackground(String text, int index) {
    bool isSelected = leaveController.selectedTabIndex.value == index;

    return GestureDetector(
      onTap: () {
        leaveController.updateTabIndex(index); // Update the tab index on tap
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : AppColor.hintColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: AppStyle.normal_text.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.fontSizeDefault,
            color: isSelected ? AppColor.cardColor : AppColor.normalTextColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return Center(child: Text('Calendar View'));
      case 1:
        return Center(child: Text('Leave Record View'));
      default:
        return Center(child: Text('Unknown Tab'));
    }
  }
}

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
    // Create TabController
    final TabController tabController = TabController(length: 2, vsync: Scaffold.of(context));

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabBar(tabController), // Pass the TabController
          Expanded(child: _buildTabBarView()), // Use Expanded here
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

  Widget _buildTabBarView() {
    return const TabBarView(
      children: [
        Center(child: Text('Calendar View')),
        Center(child: Text('Leave Record View')),
      ],
    );
  }

  Widget _buildTabBar(TabController tabController) {
    return Obx(() => TabBar(
      controller: tabController,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.zero,
      indicatorColor: Colors.transparent,
      labelColor: AppColor.primaryColor,
      unselectedLabelColor: AppColor.hintColor,
      dividerColor: Colors.transparent,
      labelStyle: AppStyle.normal_text_grey.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: Dimensions.fontSizeDefault,
      ),
      onTap: (index) {
        leaveController.updateTabIndex(index); // Update the tab index in the controller
        tabController.animateTo(index); // Move to the selected tab
      },
      tabs: [
        AppString.textCalendar.tr,
        AppString.textLeaveRecord.tr,
      ].asMap().entries.map((entry) {
        int index = entry.key;
        String text = entry.value;
        return _buildTabBarTextWithBackground(text, index);
      }).toList(),
    ));
  }

  Widget _buildTabBarTextWithBackground(String text, int index) {
    bool isSelected = leaveController.selectedTabIndex.value == index;

    return Tab(
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
}

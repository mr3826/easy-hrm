import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/hr_dashboard/views/widgets/job_details/tabbar/tabbar_body/tabbar_body.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../controllers/hr_deshboard_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';

class TabBarWidget extends StatelessWidget {
  final HrDashBoardController controller = Get.put(HrDashBoardController());

  final tabs = [
    {"text": "New", "value": "03", "id": "1"},
    {"text": "Rejected", "value": "04", "id": "2"},
    {"text": "Interview", "value": "07", "id": "3"},
    {"text": "Task assigned", "value": "08", "id": "4"},
    {"text": "Hired", "value": "09", "id": "5"},
    {"text": "Offer", "value": "01", "id": "6"},
    {"text": "Completed", "value": "02", "id": "7"},
    {"text": "Pending", "value": "06", "id": "8"},
    {"text": "On Hold", "value": "05", "id": "9"},
    {"text": "On Hold", "value": "05", "id": "9"},
    {"text": "On Hold", "value": "05", "id": "9"},
  ];

  // Create ScrollController to control tabBar scrolling
  final ScrollController tabsScrollController = ScrollController();

  TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _buildTabBar(),
        Expanded(
          child: PageView.builder(
            controller: controller.pageController,
            itemCount: tabs.length,
            onPageChanged: (index) {
              // Update the selected tab index
              controller.jobDetailsSelectedIndex.value = index;

              // Access HrDashBoardController once and use it
              final hrController = Get.find<HrDashBoardController>();

              if (hrController.isCandidateSelected.value) {
                _updateCandidateSelectionState(index, hrController);
              }

              // Check if we need to auto-scroll based on index
              _autoScrollTabs(index, context);
            },
            itemBuilder: (context, index) {
              return BuildTabBarBody(tabId: tabs[index]["id"] ?? "");
            },
          ),
        ),



    ],
      ),
    );
  }
// Helper method to update the candidate selection state
  void _updateCandidateSelectionState(int index, HrDashBoardController hrController) {
    final selectedTabId = tabs[index]["id"].toString();
    final selectedCandidateId = hrController.selectedCandidateId.value;
    // Check if the selected candidate matches the current tab's id
    hrController.isPasteButtonActive.value = selectedTabId != selectedCandidateId;
  }
  // Function to handle the auto-scroll logic
  void _autoScrollTabs(int index, context) {
    double tabWidth = 150; // Adjust this according to your tab width
    double position;

    // Auto-scroll when index crosses a multiple of 4 (either direction)
    if (index >= 2) {
      position = (index - 2) * tabWidth; // Scroll to the next set of 4 items
    } else {
      position = 0.0; // If index is below 4, scroll back to the start
    }

    // Animate the scroll
    tabsScrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  double _getTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: "   $text    "),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  _buildTabBar() {
    return Obx(() {
      return Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: tabsScrollController, // Attach the controller
            child: Row(
              children: List.generate(tabs.length, (index) {
                final isSelected = controller.jobDetailsSelectedIndex.value == index;
                final textColor = isSelected
                    ? AppColor.primaryColor
                    : AppColor.normalTextColor.withOpacity(0.5);

                return GestureDetector(
                  onTap: () {
                    controller.jobDetailsSelectedIndex.value = index;
                    controller.pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              tabs[index]["text"]!,
                              style: AppStyle.normal_text_black.copyWith(
                                color: textColor,
                                fontSize: Dimensions.fontSizeExtraDefault - .5,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.primaryColor.withOpacity(0.1)
                                    : Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                tabs[index]["value"]!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? AppColor.primaryColor
                                      : AppColor.normalTextColor
                                          .withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 50),
                          height: 2,
                          width: isSelected
                              ? _getTextWidth(
                                  "${tabs[index]["text"] ?? ""} ${tabs[index]["value"] ?? ""}")
                              : 0, // Smooth width transition
                          color: AppColor.primaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      );
    });
  }
}

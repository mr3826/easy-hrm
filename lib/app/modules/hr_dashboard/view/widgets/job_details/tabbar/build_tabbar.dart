import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/models/job_applocation_board.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/view/widgets/job_details/tabbar/tabbar_body.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import '../../../../controllers/hr_deshboard_controller.dart';

class TabBarWidget extends GetView<HrDashBoardController> {
  // Create ScrollController to control tabBar scrolling
  final ScrollController tabsScrollController = ScrollController();

  TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _buildTabBar(context),
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: controller.jobApplicationBoard?.getJobApplicationBoard
                  ?.hiringStages?.length,
              onPageChanged: (index) {
                // Update the selected tab index
                controller.jobDetailsSelectedIndex.value = index;


                ///Add hiring stage Id according selected stage
               controller.selectedCandidateId.value = controller.jobApplicationBoard?.getJobApplicationBoard?.hiringStages?[index].id??"";


                // Access HrDashBoardController once and use it
                final hrController = Get.find<HrDashBoardController>();
                if (hrController.isCandidateSelected.value) {
                  _updateCandidateSelectionState(index, hrController);
                }

                // Check if we need to auto-scroll based on index
                _autoScrollTabs(index, context);
              },
              itemBuilder: (context, index) {
                HiringStages? data = controller.jobApplicationBoard?.getJobApplicationBoard?.hiringStages?[index];
                return BuildTabBarBody(tabId: data?.id ?? "");
              },
            ),
          ),
        ],
      ),
    );
  }

// Helper method to update the candidate selection state
  void _updateCandidateSelectionState(int index, HrDashBoardController hrController) {
    final selectedTabId = controller.jobApplicationBoard?.getJobApplicationBoard?.hiringStages?[index].id;

    final selectedCandidateId = hrController.selectedCandidateId.value;

    // Check if the selected candidate matches the current tab's id
    hrController.isPasteButtonActive.value =
        selectedTabId != selectedCandidateId;
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

  _buildTabBar(BuildContext context) {
    List<HiringStages>? data = controller.jobApplicationBoard?.getJobApplicationBoard?.hiringStages ?? [];
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
              children: List.generate(data.length, (index) {
                final isSelected =
                    controller.jobDetailsSelectedIndex.value == index;
                final textColor = isSelected
                    ? AppColor.primaryColor
                    : AppColor.normalTextColor.withOpacity(0.5);
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              data[index].title ?? "",
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
                                data[index].noOfApplicant.toString() ?? "",
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
                                  "${data[index].title ?? ""} ${data[index].noOfApplicant ?? ""}")
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

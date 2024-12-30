import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import '../../../../controllers/hr_deshboard_controller.dart';
import 'build_tab_activities.dart';
import 'build_tab_details.dart';

class CandidateDetailsTabbar extends StatelessWidget {
  CandidateDetailsTabbar({super.key});
  final controller = Get.find<HrDashBoardController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _buildTabBar(),
          Obx(() {
            if (controller.jobTabCurrentIndex.value == 0) {
              return const Expanded(child: BuildTabDetails());
            } else if (controller.jobTabCurrentIndex.value == 1) {
              return const Expanded(child: BuildTabActivities());
            } else {
              return  Container();
            }
          }),
        ],
      ),
    );
  }

  double _calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  _buildTabBar() {
    final tabBarList = [
      {"text": "Details"},
      {"text": "Activities"},
      {"text": "Reviews"},
    ];
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
      child: ListView.builder(
        itemCount: tabBarList.length,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Obx(() {
            final isSelected = controller.jobTabCurrentIndex.value == index;
            final textColor = isSelected
                ? AppColor.primaryColor
                : AppColor.normalTextColor.withOpacity(0.5);
            return Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 4),
              child: GestureDetector(
                onTap: () {
                  controller.jobTabCurrentIndex.value = index;
                },
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        // Tab Text
                        Text(
                          tabBarList[index]["text"]!,
                          style: AppStyle.normal_text_black.copyWith(
                            color: textColor,
                            fontSize: Dimensions.fontSizeExtraDefault - .5,
                          ),
                        ),
                        // Value Badge
                      ],
                    ),
                    const Spacer(),

                    // Show underline for active tab with dynamic width
                    if (isSelected)
                      Container(
                        width: _calculateTextWidth(
                            tabBarList[index]["text"]!,
                            const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        height: 2.4,
                        color: AppColor.primaryColor, // Underline color
                      ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}

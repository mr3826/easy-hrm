import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../controllers/hr_deshboard_controller.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tabBarList = [
      {"text": "New", "value": "03"},
      {"text": "Rejected", "value": "04"},
      {"text": "Interview", "value": "07"},
      {"text": "Task assigned", "value": "08"},
      {"text": "Hired", "value": "09"},
      {"text": "Offer", "value": "01"},
    ];

    final controller = Get.find<HrDashBoardController>();

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
      child: Center(
        child: ListView.builder(
          itemCount: tabBarList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Obx(() {
              final isSelected = controller.jobTabCurrentIndex.value == index;
              final textColor = isSelected
                  ? AppColor.primaryColor
                  : AppColor.normalTextColor.withOpacity(0.5);
              final badgeColor = isSelected
                  ? AppColor.primaryColor.withOpacity(0.1)
                  : AppColor.disableColor.withOpacity(0.5);

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
                              fontSize: Dimensions.fontSizeExtraDefault-.5,
                            ),
                          ),
                          const SizedBox(width: 6),
                          // Value Badge
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            elevation: 0,
                            color: badgeColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 2.0),
                              child: Text(
                                tabBarList[index]["value"]!,
                                style: AppStyle.normal_text.copyWith(
                                  color: isSelected
                                      ? AppColor.primaryColor
                                      : AppColor.hintColor,
                                  fontSize: Dimensions.fontSizeSmall - 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),


                      // Show underline for active tab with dynamic width
                      if (isSelected)
                        Container(
                          width: _calculateTextWidth(
                              "${tabBarList[index]["text"]!} ${tabBarList[index]["value"]!}",
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
      ),
    );
  }

  double _calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: " $text    ", style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../common/widget/custom_dotted_border.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/input_note.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../controllers/hr_deshboard_controller.dart';

class CandidateRatingSection extends StatefulWidget {
  const CandidateRatingSection({super.key});

  @override
  State<CandidateRatingSection> createState() => _CandidateRatingSectionState();
}

class _CandidateRatingSectionState extends State<CandidateRatingSection> {
  final controller = Get.find<HrDashBoardController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customSpacerHeight(height: 8),
          Text(
            "Rate this candidate",
            style: AppStyle.normal_text_grey.copyWith(
              color: AppColor.normalTextColor.withOpacity(0.6),
            ),
          ),
          customSpacerHeight(height: 8),
          Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => _updateRating(index),
                child: Icon(
                  controller.activeStarIndex >= index
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 40,
                ),
              );
            }),
          ),
          customSpacerHeight(height: 8),
          _buildFeedbackInput(),
          customSpacerHeight(height: 20),
          Obx(() {
            if (controller.reviewerInputValue.value.isNotEmpty ||
                !controller.activeStarIndex.isNegative) {
              return CustomDoubleAppButton(
                onAction: () {},
                cancelAction: () {
                  controller.createReviewMessage.clear();
                  controller.reviewerInputValue.value = "";
                },
                buttonText: AppString.text_submit.tr,
              );
            } else {
              return const SizedBox.shrink();
            }
          })
        ],
      ),
    );
  }

  void _updateRating(int index) {
    setState(() {
      // Toggle the first star, or set the active index.
      controller.activeStarIndex =
          (index == 0 && controller.activeStarIndex == 0) ? -1 : index;
    });
  }

  Widget _buildFeedbackInput() {
    return SizedBox(
      height: 80,
      child: InputNote(
        controller: controller.createReviewMessage,
        hintText: "Write your opinion",
        borderColor: AppColor.disableColor,
        borderRadius: BorderRadius.circular(4),
        onChanged: (value) {
          Get.find<HrDashBoardController>().reviewerInputValue.value = value!;
        },
      ),
    );
  }
}

class DividerWithDashedLine extends StatelessWidget {
  const DividerWithDashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 5,
      child: CustomPaint(
        painter: DashedLinePainter(color: AppColor.disableColor),
      ),
    );
  }
}

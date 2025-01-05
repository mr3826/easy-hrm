import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/hr_dashboard/views/widgets/job_details/tabbar/build_tabbar.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../common/widget/custom_appbar.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';
import '../controllers/hr_deshboard_controller.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: AppString.text_job_details.tr),
      floatingActionButton: _buildPasteButton(),
      body: Column(
        children: [
          customSpacerHeight(height: 18),
          _buildJobTitleWithDescription(),
          customSpacerHeight(height: 12),
          _buildTimeAddressWithDate(),
          customSpacerHeight(height: 4),
          TabBarWidget(),
        ],
      ),
    );
  }

  _buildJobTitleWithDescription() {
    return Column(
      children: [
        Center(
          child: Text(
            "Node.js Developer",
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.fontSizeDefault + 3),
          ),
        ),
        Center(
          child: Text(
            "Laravel department",
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor,
                fontWeight: FontWeight.w500,
                fontSize: Dimensions.fontSizeDefault),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeAddressWithDate() {
    // Define a list of objects that include the text and corresponding icons
    final List<Map<String, dynamic>> list = [
      {
        'icon': Icons.access_time_rounded,
        'text': "Full time",
      },
      {
        'icon': Icons.location_on_outlined,
        'text': "Dhaka, Bangladesh",
      },
      {
        'icon': Icons.date_range,
        'text': "24 June, 2022",
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: list.map((item) {
          return Padding(
            padding: const EdgeInsets.only(right: 6.0), // Space between items
            child: Row(
              children: [
                Icon(
                  item['icon'], // Use the dynamic icon
                  size: 16,
                  color: AppColor.normalTextColor.withOpacity(0.4),
                ),
                const SizedBox(width: 3), // Spacer between icon and text
                Text(
                  item['text'], // Use the dynamic text
                  style: AppStyle.normal_text_black.copyWith(
                      color: AppColor.normalTextColor.withOpacity(0.5),
                      fontSize: Dimensions.fontSizeSmall,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  _buildPasteButton() {
    return Obx(() {
      bool isCandidateSelected =
          Get.find<HrDashBoardController>().isPasteButtonActive.isTrue;

      return AnimatedOpacity(
        opacity: isCandidateSelected
            ? 1.0
            : 0.0, // Fully visible when selected, hidden otherwise
        duration:
            const Duration(milliseconds: 400), // Duration of the fade in/out
        child: isCandidateSelected
            ? Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: CustomAppButton(
                  buttonText: Text(
                    "Paste here",
                    style: AppStyle.normal_text_grey
                        .copyWith(color: AppColor.cardColor, fontSize: 15),
                  ),
                  onPressed: () {},
                  buttonColor: AppColor.primaryColor,
                  borderRadius: 35,
                ),
              )
            : const SizedBox.shrink(), // Empty widget when not selected
      );
    });
  }
}

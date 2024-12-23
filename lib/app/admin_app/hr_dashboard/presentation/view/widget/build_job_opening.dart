import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/custom_network_img.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../../modules/leave/presentation/view/widget/custom_title_text_widget.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';
import '../../controller/hr_deshboard_controller.dart';

class BuildJobOpening extends StatelessWidget {
  const BuildJobOpening({super.key});

  @override
  Widget build(BuildContext context) {
    final HrDashBoardController controller = Get.put(HrDashBoardController());

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.jobIndex.length,
            controller: controller.scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 340,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1.5, color: AppColor.hintColor.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImage(""),
                      _buildJobDescription(jobName: controller.jobIndex[index])
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        _buildDottedBorderLayout(controller)
      ],
    );
  }

  _buildImage(String url) {
    return const SizedBox(
      width: 340,
      height: 100,
      child: CustomNetworkImage(
          imageRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          imageUrl:
              "https://media.istockphoto.com/id/964216874/photo/worried-programmer-having-problems-while-working-on-new-computer-program-in-the-office.jpg?s=612x612&w=0&k=20&c=evobpENGDXI4uijYb7JOlrmxfl3l1wSdDzKZDZaioZg="),
    );
  }

  _buildJobDescription({required String jobName}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 6, right: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSpacerHeight(height: 8),
                customTitleText(
                    text: jobName, fontSize: Dimensions.fontSizeMid),
                customSpacerHeight(height: 8),
                _buildInnerDescriptionText(
                    "${"Full time"} • ${"Dhaka, Bangladesh"}"),
                customSpacerHeight(height: 2),
                _buildInnerDescriptionText("24 June,2022"),
              ],
            ),
          ),
          SizedBox(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16, top: 8, bottom: 8),
                child: Column(
                  children: [
                    Text(
                      "23",
                      style: AppStyle.mid_large_text
                          .copyWith(color: AppColor.primaryColor),
                    ),
                    Text(
                      "New",
                      style: AppStyle.normal_text
                          .copyWith(color: AppColor.normalTextColor),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildInnerDescriptionText(label) {
    return Text(
      label,
      style: AppStyle.mid_large_text.copyWith(
        color: AppColor.hintColor,
        fontSize: Dimensions.fontSizeSmall + 1,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 1, // Ensures ellipsis is applied for overflow
    );
  }

  Widget _buildDottedBorder({required bool isActive}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isActive ? 12 : 9, // Change size when active
        width: isActive ? 12 : 9,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColor.primaryColor : AppColor.disableColor,
        ),
      ),
    );
  }

  _buildDottedBorderLayout(HrDashBoardController controller) {
    return Center(
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.jobIndex.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Center(
              child: Obx(() => _buildDottedBorder(
                    isActive: controller.currentIndex.value == index,
                  )),
            );
          },
        ),
      ),
    );
  }
}

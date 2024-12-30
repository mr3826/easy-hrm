import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/custom_network_img.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../../common/widget/custom_title_text_widget.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../controllers/hr_deshboard_controller.dart';

class BuildJobOpening extends StatelessWidget {
  const BuildJobOpening({super.key});

  @override
  Widget build(BuildContext context) {
    final HrDashBoardController controller = Get.find<HrDashBoardController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = constraints.maxWidth * 0.85;
        double imageHeight = constraints.maxWidth * 0.25;

        return Column(
          children: [
            SizedBox(
              height: imageHeight + 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.jobIndex.length,
                controller: controller.scrollController,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: ()=>Get.toNamed(Routes.JOB_DETAILS),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: containerWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.5,
                            color: AppColor.hintColor.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildImage(imageHeight),
                            _buildJobDescription(
                              jobName: controller.jobIndex[index],
                              containerWidth: containerWidth,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            _buildDottedBorderLayout(controller),
          ],
        );
      },
    );
  }

  Widget _buildImage(double height) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child:  CustomNetworkImage(
        imageRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        imageUrl:Images.demoImage
      ),
    );
  }

  Widget _buildJobDescription({required String jobName, required double containerWidth}) {
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
                    text: jobName,
                    textStyle: AppStyle.mid_large_text.copyWith(
                        color: AppColor.secondaryColor,
                        fontSize: Dimensions.fontSizeMid)),
                customSpacerHeight(height: 8),
                _buildInnerDescriptionText(
                  "${"Full time"} • ${"Dhaka, Bangladesh"}",
                ),
                customSpacerHeight(height: 2),
                _buildInnerDescriptionText("24 June,2022"),
              ],
            ),
          ),
          SizedBox(
            width: containerWidth * 0.19,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.timeLogRequestColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                child: Column(
                  children: [
                    Text(
                      "23",
                      style: AppStyle.mid_large_text.copyWith(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: Dimensions.fontSizeMid + 3),
                    ),
                    Text(
                      "New",
                      style: AppStyle.normal_text.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInnerDescriptionText(String label) {
    return Text(
      label,
      style: AppStyle.mid_large_text.copyWith(
        color: AppColor.hintColor,
        fontSize: Dimensions.fontSizeSmall + 1,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: 1,
    );
  }

  Widget _buildDottedBorder({required bool isActive}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isActive ? 12 : 9,
        width: isActive ? 12 : 9,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColor.primaryColor : AppColor.disableColor,
        ),
      ),
    );
  }

  Widget _buildDottedBorderLayout(HrDashBoardController controller) {
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

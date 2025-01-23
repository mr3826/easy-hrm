import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/bindings/candidates_bindings.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/models/job_opening.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/custom_network_img.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../common/widget/custom_title_text_widget.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/utils.dart';
import '../../controllers/hr_deshboard_controller.dart';


class BuildJobOpening extends GetView<HrDashBoardController> {
  const BuildJobOpening({super.key});

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.sizeOf(context).width * 0.85;
    double imageHeight = MediaQuery.sizeOf(context).height * 0.15;

    return Column(
      children: [
        SizedBox(
          height: imageHeight + 92,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.jobOpening?.getJobs?.data?.length ?? 0,
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.currentIndex.value = index;
            },
            itemBuilder: (context, index) {
              Data? data = controller.jobOpening?.getJobs?.data?[index];

              return GestureDetector(
                onTap: () {
                  _updateDataWithRoute(data?.id ?? "");
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    width: AppLayout.getHeight(1000),
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
                        _buildImage(imageHeight, url: data?.thumbnail ?? ""),
                        _buildJobDescription(
                          date: data ?? Data(),
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
  }

  Widget _buildImage(double height, {required String url}) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: CustomNetworkImage(
        imageRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        imageUrl: buildImgIxUrl(imgKey: url),
        error: _buildImageError(),
      ),
    );
  }

  Widget _buildJobDescription({required Data date, required double containerWidth}) {
    int? values = date.hiringStages
        ?.firstWhere((e) => e.title == "New").noOfApplicant;

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 8, right: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTitleText(
                    text: date.title ?? "",
                    textStyle: AppStyle.mid_large_text.copyWith(
                        color: AppColor.secondaryColor,
                        fontSize: Dimensions.fontSizeMid)),
                customSpacerHeight(height: 6),
                _buildInnerDescriptionText(_typeWithLocation(date)),
                customSpacerHeight(height: 2),
                _buildInnerDescriptionText(formatDate(
                    date: date.lastDateOfApply ?? "", format: "dd MMM, yyy")),
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
                      values.toString(),
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
          itemCount: controller.jobOpening?.getJobs?.data?.length ?? 0,
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

  String _typeWithLocation(Data date) {
    final type = date.type?.trim() ?? "";
    final location = date.location?.trim() ?? "";
    if (type.isNotEmpty && location.isEmpty) {
      return capitalizeWords(type);
    } else if (type.isEmpty && location.isNotEmpty) {
      return capitalizeWords(location);
    } else if (type.isNotEmpty && location.isNotEmpty) {
      return "${capitalizeWords(type)} • $location";
    } else {
      return "";
    }
  }

  void _updateDataWithRoute(String id) {
    CandidatesBindings().dependencies();
    controller.selectedHiringStageId.value = "";
    controller.selectedCandidateId.value = "";
    controller.selectedJobApplicationId.value = "";
    controller.isPasteButtonActive(false);
    controller.jobDetailsSelectedIndex(0);
    controller.isCandidateSelected(false);
    controller.currentIndex(0);
    controller.getJobApplicationBoard(entityId: id);
    Get.toNamed(Routes.JOB_DETAILS);
  }
}

Widget _buildImageError() {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8), topLeft: Radius.circular(8)),
        image: DecorationImage(
            image: AssetImage(Images.PLACEHOLDER), fit: BoxFit.cover)),
  );
}

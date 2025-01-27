import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/candidates_details_controller.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/hr_deshboard_controller.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/models/candidate_details.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/models/job_applocation_board.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/custom_network_img.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../common/widget/custom_appbar.dart';
import '../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../common/widget/hr_deshboard/more_info_text_divider.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/utils.dart';
import '../widgets/candidates/candidate_details_tab_bar/candidate_details_tabbar.dart';

class CandidateDetailsScreen extends GetView<CandidateDetailsController> {
  const CandidateDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(
            title:
                "${AppString.text_candidate.tr} ${AppString.text_details.tr}"),
        body: controller.obx(
            (state) => Column(
                  children: [
                    Expanded(child: _buildCandidateInfoSection(context)),
                  ],
                ),
            onLoading: const LoadingIndicator()));
  }

  Widget _buildCandidateInfoSection(BuildContext context) {
    GetCandidateDetails? getCandidateDetails =
        controller.candidateDetails?.getCandidateDetails;
    return Column(
      children: [
        Center(
          child: CustomNetworkImage(
            imageUrl: buildImgIxUrl(
                imgKey: getCandidateDetails?.candidate?.avatarKey ?? ""),
            errorText: getInitials(
                "${getCandidateDetails?.candidate?.firstName ?? ""} ${getCandidateDetails?.candidate?.lastName ?? ""}"),
            isCircleImage: true,
            radius: 32,
          ),
        ),
        customSpacerHeight(height: 12),
        _buildCandidateName("${getCandidateDetails?.candidate?.firstName ?? ""} ${getCandidateDetails?.candidate?.lastName ?? ""}"),
        customSpacerHeight(height: 2),
        _buildAppliedJobInfo(getCandidateDetails?.job?.title ?? ""),
        customSpacerHeight(height: 6),
        _buildReviewRow(getCandidateDetails?.totalReview ?? 0, getCandidateDetails?.avgRating ?? 0),
        customSpacerHeight(height: 12),
        _buildCandidateStatusButton(context),
        customSpacerHeight(height: 14),
        const CandidateDetailsTabBar(),
      ],
    );
  }

  Widget _buildCandidateName(String name) {
    return Text(
      name,
      style: AppStyle.large_text.copyWith(
        color: AppColor.normalTextColor,
        fontWeight: FontWeight.w600,
        fontSize: Dimensions.fontSizeMid - 2,
      ),
    );
  }

  Widget _buildAppliedJobInfo(String jobName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${AppString.text_applied.tr} ",
          style: AppStyle.large_text.copyWith(
            color: AppColor.hintColor,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.fontSizeDefault,
          ),
        ),
        Text(
          jobName,
          style: AppStyle.large_text.copyWith(
            color: AppColor.secondaryColor,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.fontSizeDefault,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewRow(int rating, int avgRating) {
    if (rating > 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.star,
            size: 22,
            color: AppColor.pendingColor,
          ),
          Text(
            " $avgRating ($rating)",
            style: AppStyle.normal_text_black.copyWith(
              color: AppColor.pendingColor,
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildCandidateStatusButton(BuildContext context) {
    GetCandidateDetails? getCandidateDetails = controller.candidateDetails?.getCandidateDetails;

    return GestureDetector(
      onTap: () {
        Get.find<HrDashBoardController>().getJobApplicationBoard(entityId: getCandidateDetails?.job?.id??"");
        customButtonSheet(
          height: 0.8,
          context: context,
          child: Obx(()=>_buildStatusBottomSheet()),
        );
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.secondaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  getCandidateDetails?.hiringStage?.title ?? "",
                  style: AppStyle.normal_text_black
                      .copyWith(color: AppColor.cardColor),
                ),
                customSpacerWidth(width: 8),
                const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: AppColor.cardColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBottomSheet() {
    RxInt selectedIndex = 0.obs;
    HrDashBoardController controller = Get.find<HrDashBoardController>();
    List<HiringStages>? hiringStages = controller.jobApplicationBoard?.getJobApplicationBoard?.hiringStages;

    if(controller.isJobApplicationBoardLoading.isTrue){
      return const LoadingIndicator();
    }else{
      return SingleChildScrollView(
        child: Column(
          children: [
            _buildBottomSheetHeader(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hiringStages?.length ?? 0,
              itemBuilder: (context, index) {
                return _buildBottomSheetOptionItem(
                  onTap: () {
                    selectedIndex.value = index;
                    controller
                        .updateJobApplication(
                        hiringStageId: hiringStages?[index].id ?? "",
                        jobApplicationId:
                        controller.selectedJobApplicationId.value,
                        entryId: controller.jobApplicationBoard
                            ?.getJobApplicationBoard?.id ??
                            "")
                        .then((v) {
                      Get.back(canPop: false);
                      Get.back(canPop: false);
                    });
                  },
                  textWidget: Obx(
                        () => controller.isJobApplicationUpdateLoading.isTrue &&
                        selectedIndex.value == index
                        ? const CupertinoActivityIndicator()
                        : Text(
                      hiringStages?[index].title ?? "",
                      style: AppStyle.normal_text_black.copyWith(
                        color: AppColor.normalTextColor.withOpacity(0.8),
                        fontSize: Dimensions.fontSizeDefault + 1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
 
  }

  Widget _buildBottomSheetHeader() {
    GetCandidateDetails? getCandidateDetails =
        controller.candidateDetails?.getCandidateDetails;

    return customButtonSheetAppbar(
      height: AppLayout.getHeight(200),
      titleWidget: Column(
        children: [
          customSpacerHeight(height: 12),
          Center(
            child: CustomNetworkImage(
              imageUrl: buildImgIxUrl(
                  imgKey: getCandidateDetails?.candidate?.avatarKey ?? ""),
              errorText: getInitials(
                  "${getCandidateDetails?.candidate?.firstName ?? ""} ${getCandidateDetails?.candidate?.lastName ?? ""}"),
              isCircleImage: true,
              radius: 30,
              borderColor: AppColor.primaryColor,
            ),
          ),
          customSpacerHeight(height: 8),
          _buildBottomSheetTitle(),
        ],
      ),
      subtextWidget: _buildBottomSheetRating(),
    );
  }

  Widget _buildBottomSheetTitle() {
    GetCandidateDetails? getCandidateDetails =
        controller.candidateDetails?.getCandidateDetails;

    return Column(
      children: [
        Text(
          "${getCandidateDetails?.candidate?.firstName ?? ""} ${getCandidateDetails?.candidate?.lastName ?? ""}",
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.secondaryColor,
            fontWeight: FontWeight.w700,
            fontSize: Dimensions.fontSizeDefault + 3,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Applied for: ",
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
            Text(
              getCandidateDetails?.job?.title ?? "",
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.secondaryColor,
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomSheetOptionItem(
      {required VoidCallback onTap, required textWidget}) {
    return customMoreInfoTextWithDiver(onTap: onTap, textWidget: textWidget);
  }

  Widget _buildBottomSheetRating() {
    GetCandidateDetails? getCandidateDetails =
        controller.candidateDetails?.getCandidateDetails;

    int currentRating = getCandidateDetails?.totalReview ?? 0;
    const int totalStars = 5;

    if (currentRating > 0) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            getCandidateDetails?.totalReview.toString() ?? "",
            style: AppStyle.normal_text_black.copyWith(
              color: AppColor.pendingColor,
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: List.generate(totalStars, (index) {
              return Icon(
                index < currentRating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 16,
              );
            }),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

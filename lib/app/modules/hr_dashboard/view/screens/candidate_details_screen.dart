import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/candidates_details_controller.dart';
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
import '../../../../../utils/images.dart';
import '../widgets/candidates/candidate_details_tab_bar/candidate_details_tabbar.dart';

class CandidateDetailsScreen extends GetView<CandidateDetailsController> {
  const CandidateDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: "${AppString.text_candidate.tr} ${AppString.text_details.tr}"),
      body: controller.obx((state)=> Column(
        children: [
          Expanded(child: _buildCandidateInfoSection(context)),
        ],
      ),
        onLoading: const LoadingIndicator()
    )
    );

  }

  Widget _buildCandidateInfoSection(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: CustomNetworkImage(
            imageUrl:
                "https://thumbs.dreamstime.com/b/stylish-cat-sunglasses-poses-confidently-rocky-beach-capturing-unique-blend-humor-charm-warm-glow-sunset-349482060.jpg",
            isCircleImage: true,
            radius: 32,
          ),
        ),
        customSpacerHeight(height: 12),
        _buildCandidateName(),
        customSpacerHeight(height: 2),
        _buildAppliedJobInfo(),
        customSpacerHeight(height: 6),
        _buildReviewRow(),
        customSpacerHeight(height: 12),
        _buildCandidateStatusButton(context),
        customSpacerHeight(height: 14),
        CandidateDetailsTabBar(),
      ],
    );
  }

  Widget _buildCandidateName() {
    return Text(
      "Katarina Neilson",
      style: AppStyle.large_text.copyWith(
        color: AppColor.normalTextColor,
        fontWeight: FontWeight.w600,
        fontSize: Dimensions.fontSizeMid - 2,
      ),
    );
  }

  Widget _buildAppliedJobInfo() {
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
          "Node.js Developer",
          style: AppStyle.large_text.copyWith(
            color: AppColor.secondaryColor,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.fontSizeDefault,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.star,
          size: 22,
          color: AppColor.pendingColor,
        ),
        Text(
          " 4.5 (3)",
          style: AppStyle.normal_text_black.copyWith(
            color: AppColor.pendingColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCandidateStatusButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customButtonSheet(
          height: 0.8,
          context: context,
          child: _buildStatusBottomSheet(),
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
                  "Interview",
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
    final List<Map<String, String>> statusOptions = [
      {"text": "New", "value": "03"},
      {"text": "Rejected", "value": "04"},
      {"text": "Interview", "value": "07"},
      {"text": "Task assigned", "value": "08"},
      {"text": "Hired", "value": "09"},
      {"text": "Offer", "value": "01"},
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildBottomSheetHeader(),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: statusOptions.length,
            itemBuilder: (context, index) {
              return _buildBottomSheetOptionItem(
                text: statusOptions[index]["text"]!,
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetHeader() {
    return customButtonSheetAppbar(
      height: AppLayout.getHeight(200),
      titleWidget: Column(
        children: [
          customSpacerHeight(height: 12),
          const Center(
            child: CustomNetworkImage(
              isCircleImage: true,
              radius: 30,
              borderColor: AppColor.primaryColor,
              imageUrl:
                  "https://media.istockphoto.com/id/964216874/photo/worried-programmer-having-problems-while-working-on-new-computer-program-in-the-office.jpg?s=612x612&w=0&k=20&c=evobpENGDXI4uijYb7JOlrmxfl3l1wSdDzKZDZaioZg=",
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
    return Column(
      children: [
        Text(
          "Agens Nelson",
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
              "Node.js Developer",
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

  Widget _buildBottomSheetOptionItem({
    required String text,
    required VoidCallback onTap,
  }) {
    return customMoreInfoTextWithDiver(
      text: text,
      onTap: onTap,
    );
  }

  Widget _buildBottomSheetRating() {
    const int currentRating = 3;
    const int totalStars = 5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "4.0",
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
  }
}

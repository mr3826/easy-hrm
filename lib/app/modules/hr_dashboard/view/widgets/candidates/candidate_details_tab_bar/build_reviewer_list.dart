import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/models/candidate_review.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../../common/widget/hr_deshboard/custom_network_img.dart';
import '../../../../../../../common/widget/hr_deshboard/more_info_text_divider.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../../utils/images.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../controllers/candidates_details_controller.dart';
import '../../../../controllers/hr_deshboard_controller.dart';
import 'build_rating_section.dart';

class BuildReviewerList extends GetView<CandidateDetailsController> {
  const BuildReviewerList({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.candidateReviewModel?.getTeamNotes?.data?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Data? data = controller.candidateReviewModel?.getTeamNotes?.data?[index] ?? Data();
        return Padding(
          padding: const EdgeInsets.only(bottom: 28.0, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildReviewerProfileImage(data),
                  customSpacerWidth(width: 8),
                  _buildReviewerDetails(context, data),
                ],
              ),
              customSpacerHeight(height: 12),
              _buildRatingRow(data),
              customSpacerHeight(height: 5),
              _buildReviewDescription(index, data),
              _buildReviewDateText(data),
              customSpacerHeight(height: 30),
              const DividerWithDashedLine(),
            ],
          ),
        );
      },
    );
  }

  // Builds the reviewer's profile image widget
  Widget _buildReviewerProfileImage(Data data) {
    return CustomNetworkImage(
        isCircleImage: true,
        radius: 16,
        errorText: getInitials(
          "${data.createdBy?.profile?.firstName ?? ""} ${data.createdBy?.profile?.lastName ?? ""}",
        ),
        borderColor: AppColor.primaryColor,
        imageUrl: buildImgIxUrl(
          imgKey: data.createdBy?.profile?.image ?? "",
        ));
  }

  // Builds the reviewer's details section
  Widget _buildReviewerDetails(BuildContext context, Data data) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReviewerNameText(
                    "${data.createdBy?.profile?.firstName ?? ""} ${data.createdBy?.profile?.lastName ?? ""}"),
                const SizedBox(height: 2),
                _buildReviewerEmailText("Reviewed the candidate"),
              ],
            ),
          ),
          customSpacerWidth(width: 4),
          if (data.immutable == false)
            GestureDetector(
              onTap: () {
                controller.selectedNoteId(data.id ?? "");
                customButtonSheet(
                    height: .5,
                    context: context,
                    child: _buildMoreOptionsSheet(context, data));
              },
              child: Icon(
                Icons.more_horiz,
                color: AppColor.normalTextColor.withOpacity(0.5),
              ),
            ),
          customSpacerWidth(width: 8),
        ],
      ),
    );
  }

  // Builds the review rating row
  Widget _buildRatingRow(Data date) {
    int currentRating = date.candidateReview?.rate ?? 0;
    if (date.candidateReview?.rate == 0 || date.candidateReview?.rate == null) {
      return const SizedBox.shrink();
    }
    const int totalStars = 5;

    return Row(
      children: [
        Text(
          date.candidateReview?.rate.toString() ?? "",
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

  // Builds the review text description
  Widget _buildReviewDescription(int index, Data date) {
    if (date.note?.isEmpty ?? false || date.note == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        date.note ?? "",
        style: AppStyle.normal_text_black.copyWith(
          color: AppColor.normalTextColor.withOpacity(0.7),
        ),
      ),
    );
  }

  // Builds the review date text
  Widget _buildReviewDateText(Data date) {
    return Text(
      formatDate(date: date.createdAt ?? "", format: "dd MMMM, yyy"),
      style: AppStyle.normal_text.copyWith(
        color: AppColor.normalTextColor.withOpacity(0.5),
        fontSize: Dimensions.fontSizeSmall + 1,
      ),
    );
  }

  // Builds the More Options bottom sheet
  Widget _buildMoreOptionsSheet(BuildContext context, Data data) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildBottomSheetHeader(data),
          _buildOptionItem(
            text: AppString.text_edit_this_review.tr,
            onTap: () {
              controller.createReviewMessage.text = data.note.toString();
              controller.isEditNote(true);
              Get.back(canPop: false);
            },
            trailing: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(Images.EDIT_ICON),
            ),
          ),
          _buildOptionItem(
            text: AppString.text_remove_this_review.tr,
            onTap: () {
              _showRemoveReviewDialog(context, data);
            },
            trailing: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.delete_outline,
                color: AppColor.normalTextColor.withOpacity(0.4),
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the reviewer's name text
  Widget _buildReviewerNameText(String name) {
    return Text(
      name,
      maxLines: 2,
      style: AppStyle.mid_large_text.copyWith(
        color: AppColor.secondaryColor,
        overflow: TextOverflow.ellipsis,
        fontSize: Dimensions.fontSizeMid - 1,
      ),
    );
  }

  // Builds the reviewer's email text
  Widget _buildReviewerEmailText(String email) {
    return Text(
      email,
      maxLines: 2,
      style: AppStyle.normal_text.copyWith(
        color: AppColor.hintColor,
        overflow: TextOverflow.ellipsis,
        fontSize: Dimensions.fontSizeSmall + 1,
      ),
    );
  }

  // Builds the bottom sheet header with profile image and name
  Widget _buildBottomSheetHeader(Data data) {
    return customButtonSheetAppbar(
        height: 150,
        titleWidget: Column(
          children: [
            Center(
              child: CustomNetworkImage(
                isCircleImage: true,
                radius: 30,
                borderColor: Colors.transparent,
                imageUrl:
                    buildImgIxUrl(imgKey: data.createdBy?.profile?.image ?? ""),
                errorText: getInitials(
                    "${data.createdBy?.profile?.firstName ?? ""} ${data.createdBy?.profile?.lastName ?? ""}"),
              ),
            ),
            customSpacerHeight(height: 4),
            Text(
              "${data.createdBy?.profile?.firstName ?? ""} ${data.createdBy?.profile?.lastName ?? ""}",
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.secondaryColor,
                fontWeight: FontWeight.w700,
                fontSize: Dimensions.fontSizeDefault + 3,
              ),
            ),
          ],
        ),
        subtextWidget:
            _buildBottomSheetRating(data.candidateReview?.rate ?? 0));
  }

  // Builds an option item for the bottom sheet
  Widget _buildOptionItem({
    String? text,
    Widget? textWidget,
    required VoidCallback onTap,
    required Widget trailing,
  }) {
    return customMoreInfoTextWithDiver(
        text: text, onTap: onTap, trailing: trailing, textWidget: textWidget);
  }

  // Builds the rating row for the bottom sheet
  Widget _buildBottomSheetRating(int rating) {
    if (rating <= 0) {
      return const SizedBox.shrink();
    }
    int currentRating = rating;
    const int totalStars = 5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          rating.toString(),
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

  void _showRemoveReviewDialog(BuildContext context, Data data) {
    showCustomAlertDialog(
      context: context,
      titleText:
          "You are about to delete a ${data.createdBy?.profile?.firstName ?? ""} ${data.createdBy?.profile?.lastName ?? ""}",
      onConfirm: () {},
      iconWidget:
          customSvgImage(imageUrl: Images.rejectLeave, height: 60, width: 60),
      descriptionText:
          "This action will permanently delete this candidate. Do you still want to delete this candidate?",
      iconBackgroundColor: AppColor.cardColor,
      confirmButtonColor: AppColor.errorColor,
      actionButtonWidget: Obx(() => controller.isDeletedTeamNoteLoading.isTrue
          ? const Center(child: CupertinoActivityIndicator())
          : CustomDoubleAppButton(
              btnColor: AppColor.errorColorLight,
              buttonText: "Delete",
              onAction: () {
                controller
                    .deleteCandidateNoteReview(entityId: data.id ?? "")
                    .then((v) {
                  controller.getCandidateReview(
                      Get.find<HrDashBoardController>()
                          .selectedJobApplicationId
                          .value);
                  controller.getCandidateDetails(
                      Get.find<HrDashBoardController>()
                          .selectedJobApplicationId
                          .value);
                  Get.back(canPop: false);
                  Get.back(canPop: false);
                });
              },
              cancelAction: () => Get.back(canPop: false),
            )),
    );
  }
}

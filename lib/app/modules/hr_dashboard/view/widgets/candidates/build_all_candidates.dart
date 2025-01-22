import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/models/candidate_list.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/view/widgets/deshboard_widget.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/custom_network_img.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/more_info_text_divider.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../../common/widget/custom_dialog.dart';
import '../../../../../../../common/widget/custom_title_text_widget.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../common/widget/loading_indicator.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../global/view/widget/app_margin.dart';
import '../../../controllers/hr_deshboard_controller.dart';

class BuildAllCandidates extends GetView<HrDashBoardController> {
  const BuildAllCandidates({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Obx(() {
      if (controller.isCandidateBySearchLoading.isTrue) {
        return const LoadingIndicator();
      } else if (controller.candidateList?.getCandidates?.data?.isEmpty ??
          false) {
        return Center(
          child: Text(
            "No candidate found!",
            style: AppStyle.normal_text_grey,
          ),
        );
      } else {
        return ListView.builder(
          itemCount: controller.candidateList?.getCandidates?.data?.length ?? 0,
          itemBuilder: (context, index) {
            Data? data = controller.candidateList?.getCandidates?.data?[index];
            return Padding(
              padding: _getPadding(), // Use a dedicated method for padding
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileImage(data ?? Data()),
                  const SizedBox(width: 16), // Padding size can be static here
                  _buildCandidateInfo(data ?? Data(), context),
                ],
              ),
            );
          },
        );
      }
    }));
  }

  EdgeInsets _getPadding() {
    return marginLayout.copyWith(bottom: 18, top: 15);
  }

  Widget _buildProfileImage(Data data) {
    double imageSize = 60.0; // Static value for image size
    return CustomNetworkImage(
        isCircleImage: true,
        radius: imageSize / 2,
        errorText: getInitials(
            "${data.candidate?.firstName ?? ""} ${data.candidate?.lastName ?? ""}"),
        imageUrl: buildImgIxUrl(imgKey: data.candidate?.avatarKey ?? ""));
  }

  Widget _buildCandidateInfo(Data data, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText(
              "${data.candidate?.firstName ?? ""} ${data.candidate?.lastName ?? ""}"),
          const SizedBox(height: 2),
          _buildJobAppliedRow(data, context),
          _buildInterviewTag(
            data.hiringStage?.title ?? "",
          ),
        ],
      ),
    );
  }

  // Method to build candidate title text
  Widget _buildTitleText(String name) {
    return customTitleText(
      text: name,
      textStyle: AppStyle.mid_large_text.copyWith(
        color: AppColor.secondaryColor,
        fontSize: Dimensions.fontSizeMid - 1,
      ),
    );
  }

  // Method to build the "Applied for" job info with more icon
  Widget _buildJobAppliedRow(Data data, BuildContext context) {
    return Row(
      children: [
        Text(
          "Applied for: ",
          style: AppStyle.normal_text.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeSmall + 1,
          ),
        ),
        Expanded(
          child: Text(
            data.job?.title ?? "",
            maxLines: 2,
            style: AppStyle.normal_text.copyWith(
              color: AppColor.normalTextColor,
              overflow: TextOverflow.ellipsis,
              fontSize: Dimensions.fontSizeSmall + 1,
            ),
          ),
        ),
        customSpacerWidth(width: 4),
        GestureDetector(
          onTap: () {
            controller.selectedCandidateId(data.candidate?.id ?? "");
            controller.selectedJobId(data.job?.id ?? "");

            customButtonSheet(
                height: .5, context: context, child: _buildMoreView(data));
          },
          child: Icon(
            Icons.more_horiz,
            color: AppColor.normalTextColor.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  // Method to build the interview tag
  Widget _buildInterviewTag(String status) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.interViewCandidatesColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
        child: Text(
          status,
          style: AppStyle.normal_text.copyWith(
            color: AppColor.interViewCandidatesColor,
          ),
        ),
      ),
    );
  }

  Widget _buildMoreView(Data data) {
    return Column(
      children: [
        customButtonSheetAppbar(
            text:
                "${data.candidate?.firstName ?? ""} ${data.candidate?.lastName ?? ""}",
            subtext: data.candidate?.email ?? ""),
        customMoreInfoTextWithDiver(
            text: AppString.text_edit.tr,
            onTap: () => _updateDate(data),
            trailing: Image.asset(Images.EDIT_ICON)),
        customMoreInfoTextWithDiver(
            text: AppString.text_share.tr,
            onTap: () {
              showShareDialog(
                  titleText: AppString.text_candidate.replaceAll("s", ""),
                  description: AppString.text_only_admin_and_etc.tr,
                  linkDinAction: () {},
                  messengerAction: () {},
                  slackAction: () {},
                  whatAppAction: () {},
                  copyAction: () {});
            },
            trailing: Icon(
              Icons.share,
              color: AppColor.normalTextColor.withOpacity(0.4),
              size: 24,
            )),
        customMoreInfoTextWithDiver(
            text: AppString.text_remove.tr,
            onTap: () {
              _showRemoveDialog();
            },
            trailing: Icon(
              Icons.delete_outline,
              color: AppColor.normalTextColor.withOpacity(0.4),
              size: 30,
            )),
      ],
    );
  }

  void _showRemoveDialog() {
    HrDashBoardController controller = Get.find<HrDashBoardController>();
    return displayCustomDialog(
        context: Get.context!,
        customIconWidget: SizedBox(
            height: 65,
            width: 65,
            child: customSvgImage(imageUrl: Images.REMOVE_ICON)),
        titleText: AppString.text_remove_candidate.tr,
        descriptionText: AppString.text_are_you_sure_deleted_candidate.tr,
        customActionButtons:
            Obx(() => controller.isRemoveCandidateLoading.isTrue
                ? const Center(child: CupertinoActivityIndicator())
                : CustomDoubleAppButton(
                    onAction: () {
                      controller
                          .removeCandidate(
                              candidateId: controller.selectedCandidateId.value,
                              jobId: controller.selectedJobId.value)
                          .then((v) {
                        Get.back(canPop: false);
                        Get.back(canPop: false);
                        controller.getCandidateBySearch();
                      });
                    },
                    cancelAction: () => Get.back(canPop: false),
                    btnColor: AppColor.errorColorLight,
                    buttonText: AppString.text_remove.tr,
                  )));
  }

  void _updateDate(Data data) {
    Get.toNamed(Routes.EDIT_CANDIDATES);
    controller.candidateFirstName.text = data.candidate?.firstName ?? "";
    controller.candidateLastName.text = data.candidate?.lastName ?? "";
    controller.candidateEmail.text = data.candidate?.email ?? "";
  }
}

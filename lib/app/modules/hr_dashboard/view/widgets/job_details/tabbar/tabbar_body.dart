import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/candidates_details_controller.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import '../../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/hr_deshboard/custom_network_img.dart';
import '../../../../../../../common/widget/hr_deshboard/more_info_text_divider.dart';
import '../../../../../../../routes/app_pages.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../../utils/images.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../../global/view/widget/app_margin.dart';
import '../../../../controllers/hr_deshboard_controller.dart';
import '../../../../models/job_applocation_board.dart';

class BuildTabBarBody extends GetView<HrDashBoardController> {
  final String tabId;

  const BuildTabBarBody({super.key, required this.tabId});

  @override
  Widget build(BuildContext context) {
    // Example data for the list
    final RxList<HiringStages> hiringStages = controller.jobApplicationBoard?.getJobApplicationBoard?.hiringStages?.obs ?? <HiringStages>[].obs;
    RxList<JobApplications> userList = <JobApplications>[].obs;

    return Obx(() {
      // Filter the list based on the tabId
      final hiringStagesFilter =
          hiringStages.where((user) => user.id == tabId).toList();

      List<HiringStages> candidateInfoList = hiringStagesFilter
          .where((user) => user.jobApplications?.isNotEmpty ?? false)
          .toList();

      for (var stage in hiringStagesFilter) {
        stage.jobApplications?.forEach((jobApplication) {
          userList.add(jobApplication);
        });
      }

      if (candidateInfoList.isEmpty) {
        return _buildNoCandidate();
      }

      return ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.find<CandidateDetailsController>().getCandidateDetails(userList[index].id ?? "");
              Get.find<CandidateDetailsController>().getJobApplicationPreview( controller.jobApplicationBoard?.getJobApplicationBoard?.id ??"",userList[index].candidate?.id ?? "");
              controller.selectedJobApplicationId(userList[index].id ?? "");
              controller.selectedJobId(controller.jobApplicationBoard?.getJobApplicationBoard?.id ?? "");
              Get.toNamed(Routes.CANDIDATES_DETAILS);
            },
            child: LayoutBuilder(builder: (context, constraints) {
              double imageSize = constraints.maxWidth * 0.15;
              double paddingSize = constraints.maxWidth * 0.03;
              final user = userList[index];
              return Obx(() {
                bool hasAnyWhereSelected = Get.find<HrDashBoardController>()
                            .selectedJobApplicationId
                            .value ==
                        user.id &&
                    Get.find<HrDashBoardController>()
                        .isCandidateSelected
                        .isTrue;

                return Padding(
                  padding: _getPadding(), // Use a dedicated method for padding
                  child: Container(
                      decoration: _containerStyle(hasAnyWhereSelected),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            _buildProfileImage(
                                imageSize,
                                user.candidate?.avatarKey ?? "",
                                "${user.candidate?.firstName ?? "_"} ${user.candidate?.lastName ?? ""}"),
                            SizedBox(width: paddingSize),
                            _buildCandidateInfo(
                                context: context,
                                imgKey: user.candidate?.avatarKey ?? "",
                                email: user.candidate?.email ?? "",
                                name:
                                    "${user.candidate?.firstName ?? "_"} ${user.candidate?.lastName ?? ""}",
                                jobApplicationId: user.id.toString(),
                                index: index,
                                hiringStages: hiringStages,
                                candidateId:
                                    user.candidate?.id.toString() ?? ""),
                          ],
                        ),
                      )),
                );
              });
            }),
          );
        },
      );
    });
  }

  EdgeInsets _getPadding() {
    return marginLayout.copyWith(top: 15, left: 12, right: 12);
  }

  Widget _buildProfileImage(double size, String imgUrl, String errorText) {
    return CustomNetworkImage(
      isCircleImage: true,
      radius: size / 2.7,
      errorText: getInitials(errorText),
      borderColor: Colors.transparent,
      imageUrl: buildImgIxUrl(imgKey: imgUrl),
    );
  }

  Widget _buildCandidateInfo(
      {required String name,
      required String email,
      required String imgKey,
      required BuildContext context,
      required String candidateId,
      required int index,
      required RxList<HiringStages> hiringStages,
      required String jobApplicationId}) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleText(name),
                const SizedBox(height: 2),
                _buildEmailText(email),
              ],
            ),
          ),
          customSpacerWidth(width: 4),
          GestureDetector(
            onTap: () {
              controller.selectedJobApplicationId.value = jobApplicationId;
              controller.selectedCandidateId.value = candidateId;
              customButtonSheet(
                  height: .5,
                  context: context,
                  child: _buildMoreView(context, name, email, imgKey));
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

  // Method to build candidate title text
  Widget _buildTitleText(String name) {
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

  Widget _buildEmailText(String email) {
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

  _containerStyle([bool? isSelected]) {
    return BoxDecoration(
        border: Border.all(
            width: 1,
            color: isSelected == true
                ? AppColor.primaryColor
                : AppColor.disableColor),
        color: isSelected == true
            ? AppColor.primaryColor.withOpacity(0.1)
            : AppColor.cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault));
  }

  Widget _buildMoreView(
      BuildContext context, String name, String email, String imageKey) {
    String jobApplicationId = controller.selectedJobApplicationId.value;

    String candidateId = controller.selectedCandidateId.value;
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeaderSection(name, email, imageKey),
          if (controller.nextHiringStagesId.value.isNotEmpty)
            Obx(() => _moveToNext(jobApplicationId)),
          _moveAnyWhere(jobApplicationId),
          Obx(
            () => _removeCandidate(context, candidateId),
          ),
        ],
      ),
    );
  }

// A method to build the header section with profile image and name.
  Widget _buildHeaderSection(String name, String email, String imageKey) {
    return customButtonSheetAppbar(
      height: 150,
      titleWidget: Column(
        children: [
          Center(
            child: CustomNetworkImage(
                isCircleImage: true,
                radius: 30,
                borderColor: Colors.transparent,
                errorText: getInitials(name),
                imageUrl: buildImgIxUrl(imgKey: imageKey)),
          ),
          customSpacerHeight(height: 4),
          Text(
            name,
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.secondaryColor,
              fontWeight: FontWeight.w700,
              fontSize: Dimensions.fontSizeDefault + 3,
            ),
          ),
        ],
      ),
      subtext: email,
    );
  }

// A method to build individual more info items with divider.
  Widget _buildMoreInfoSection({
    required String text,
    required VoidCallback onTap,
    required Widget trailing,
  }) {
    return customMoreInfoTextWithDiver(
      text: text,
      onTap: onTap,
      trailing: trailing,
    );
  }

  Widget _buildNoCandidate() {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // Aligns the children in the center
      children: [
        customSvgImage(
          imageUrl: Images.NOT_ADDED_YET,
          width: 80,
          height: 80,
        ),
        Text(
          AppString.text_no_one_addded_yet.tr,
          style: AppStyle.normal_text.copyWith(color: AppColor.hintColor),
        ),
        const SizedBox(
          height: 150,
        )
      ],
    );
  }

  _moveToNext(String jobApplicationId) {
    if (controller.isJobApplicationUpdateLoading.isTrue) {
      return const CupertinoActivityIndicator();
    } else {
      return _buildMoreInfoSection(
        text: AppString.text_move_to_the_next.tr,
        onTap: () {
          controller
              .updateJobApplication(
                  hiringStageId: controller.nextHiringStagesId.value,
                  jobApplicationId: jobApplicationId,
                  entryId: controller
                          .jobApplicationBoard?.getJobApplicationBoard?.id ??
                      "")
              .then((v) {
            Get.back(canPop: false);
          });
        },
        trailing: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            CupertinoIcons.arrow_turn_right_down,
            color: AppColor.normalTextColor.withOpacity(0.4),
            size: 24,
          ),
        ),
      );
    }
  }

  _moveAnyWhere(String jobApplicationId) {
    return _buildMoreInfoSection(
      text: AppString.text_move_anywhere.tr,
      onTap: () {
        // Get.find<HrDashBoardController>().selectedHiringStageId.value = jobApplicationId;
        Get.find<HrDashBoardController>().selectedJobApplicationId.value =
            jobApplicationId;
        Get.find<HrDashBoardController>().isCandidateSelected.value = true;
        Get.back(canPop: false);
      },
      trailing: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Image.asset(Images.MOVE_ANY_WHERE_ICON),
      ),
    );
  }

  _removeCandidate(BuildContext context, String candidateId) {
    if (controller.isJobApplicationRemoveLoading.isTrue) {
      return const CupertinoActivityIndicator();
    } else {
      return _buildMoreInfoSection(
        text: AppString.text_remove_candidate.tr,
        onTap: () {
          showCustomAlertDialog(
            context: context,
            onConfirm: () {
              controller.removeJobApplication(
                  candidateId: candidateId,
                  jobId: controller
                          .jobApplicationBoard?.getJobApplicationBoard?.id ??
                      "");
              Get.back(canPop: false);
            },
            iconData: Icons.delete_outline_outlined,
            titleText: AppString.text_remove_candidate.tr,
            descriptionText:
                AppString.text_sure_you_want_t0_details_candidate_etc.tr,
            iconBackgroundColor: AppColor.errorColorLight,
            confirmButtonColor: AppColor.errorColorLight,
            confirmButtonText: AppString.text_remove.tr,
            extraInfoText: "",
          );
        },
        trailing: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.delete_outline,
            color: AppColor.normalTextColor.withOpacity(0.4),
            size: 30,
          ),
        ),
      );
    }
  }
}

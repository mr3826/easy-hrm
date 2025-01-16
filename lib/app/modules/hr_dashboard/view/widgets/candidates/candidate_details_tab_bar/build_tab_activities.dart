import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/models/candidate_activities_logs.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/custom_network_img.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../enum.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../controllers/candidates_details_controller.dart';

class BuildTabActivities extends GetView<CandidateDetailsController> {
  const BuildTabActivities({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: controller.candidateActivitiesLogs?.getLogs?.length ?? 0,
      itemBuilder: (context, index) {
        return _buildContext(index);
      },
    );
  }

  Widget _buildContext(int index) {
    GetLogs? getLogs = controller.candidateActivitiesLogs?.getLogs?[index];
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double textFontSize = width * 0.04; // Dynamic font size
        double smallTextFontSize = width * 0.03; // Smaller text font size
        double spacerWidth = width * 0.03; // Spacer width
        return Padding(
          padding: EdgeInsets.only(
            top: width * 0.05, // Dynamic top padding
            bottom: width * 0.03, // Dynamic bottom padding
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileImage(getLogs),
              SizedBox(width: spacerWidth),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleText(getLogs, textFontSize),
                    const SizedBox(height: 3),
                    _buildContent(smallTextFontSize, getLogs ?? GetLogs()),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileImage(GetLogs? getLogs) {
    if (getLogs == null) return const SizedBox.shrink();

    String imageUrl = buildImgIxUrl(imgKey: getLogs.createdByUser?.profile?.image ?? "");
    String errorText = getLogs.action == CandidateActivitiesLogsEnum.applied_to_job.name
        ? "${getLogs.candidate?.firstName ?? ""} ${getLogs.candidate?.lastName ?? ""}"
        : "${getLogs.createdByUser?.profile?.firstName ?? ""} ${getLogs.createdByUser?.profile?.lastName ?? ""}";

    return CustomNetworkImage(
      imageUrl: imageUrl,
      isCircleImage: true,
      radius: 18,
      errorText: getInitials(errorText),
      borderColor: AppColor.primaryColor,
    );
  }

  Widget _buildTitleText(GetLogs? getLogs, double fontSize) {
    String titleText = getLogs?.action == CandidateActivitiesLogsEnum.applied_to_job.name
        ? "${getLogs?.candidate?.firstName ?? ""} ${getLogs?.candidate?.lastName ?? ""}"
        : "${getLogs?.createdByUser?.profile?.firstName ?? ""} ${getLogs?.createdByUser?.profile?.lastName ?? ""}";
    return Text(
      titleText,
      style: AppStyle.normal_text_grey.copyWith(
        color: AppColor.normalTextColor,
        fontSize: fontSize,
      ),
    );
  }



    _buildContent(double fontSize, GetLogs getLogs) {
    String? context = getLogs.action;

    if (context == CandidateActivitiesLogsEnum.added_candidate_rating.name) {
      return _candidateReview(getLogs, fontSize);

    } else if (context == CandidateActivitiesLogsEnum.changed_hiring_stage.name) {
      return _hiringStage(getLogs, fontSize);
    } else if (context ==
        CandidateActivitiesLogsEnum.changed_candidate_name.name) {
      return _changedCandidateName(getLogs, fontSize);
    } else if (context == CandidateActivitiesLogsEnum.applied_to_job.name) {
      return _appliedToJob(getLogs, fontSize);
    } else {
      return const SizedBox.shrink();
    }
  }

  _candidateReview(GetLogs getLogs, fontSize) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Reviewed  ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: getLogs.newNumber.toString(),
                style: AppStyle.normal_text_grey.copyWith(
                  color: AppColor.pendingColor,
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: " ★ ",
                style: AppStyle.normal_text.copyWith(
                    color: AppColor.pendingColor, fontSize: fontSize + 5),
              ),
              TextSpan(
                text: "to ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text:
                "${getLogs.candidate?.firstName ?? ""} ${getLogs.candidate?.lastName ?? ""}",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        _createDate(getLogs.createdAt.toString(), fontSize),
        if (getLogs.files?.isNotEmpty ?? false) ...[
          const SizedBox(height: 8),
          _buildAttachFile(getLogs)
        ]
      ],
    );
  }

  _changedCandidateName(GetLogs getLogs, fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Edited ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: "Name ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: "of ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text:
                "${getLogs.candidate?.firstName ?? ""} ${getLogs.candidate?.lastName ?? ""}",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        _createDate(getLogs.createdAt.toString(), fontSize),
        if (getLogs.files?.isNotEmpty ?? false) ...[
          const SizedBox(height: 8),
          _buildAttachFile(getLogs),
        ]
      ],
    );
  }


  _appliedToJob(GetLogs getLogs, double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Applied for ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: getLogs.job?.title ?? "",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        _createDate(getLogs.createdAt.toString(), fontSize),
        if (getLogs.files?.isNotEmpty ?? false) ...[
          const SizedBox(height: 8),
          _buildAttachFile(getLogs),

        ]
      ],
    );
  }

  _hiringStage(GetLogs getLogs, double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Moved ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text:
                "${getLogs.candidate?.firstName ?? ""} ${getLogs.candidate?.lastName ?? ""} to ",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
              TextSpan(
                text: getLogs.newHiringStage?.title??"",
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: fontSize + 1,
                ),
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        _createDate(getLogs.createdAt.toString(), fontSize),
        if (getLogs.files?.isNotEmpty ?? false) ...[
          const SizedBox(height: 8),
          _buildAttachFile(getLogs)
        ]
      ],
    );
  }


  Widget _buildAttachFile(GetLogs getLogs) {
    RxInt currentIndex=0.obs;
    return SizedBox(
      height: 140,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:  getLogs.files?.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            currentIndex.value =index;
            Get.find<CandidateDetailsController>().getFileSignUrl(getLogs.files?[index].key??"");
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 80,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.hintColor.withOpacity(0.1),
                    ),
                    child:Obx(()=>currentIndex.value ==index &&
                    Get.find<CandidateDetailsController>().isFileSignUrlLoading.isTrue?const CupertinoActivityIndicator():
                    Icon(
                      CupertinoIcons.doc_text,
                      size: 50,
                      color: AppColor.normalTextColor.withOpacity(0.5),
                    )),

                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  getLogs.files?[index].name??"",
                  style: AppStyle.normal_text.copyWith(
                    color: AppColor.normalTextColor.withOpacity(0.8),
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
              ],
            ),
          ),
        );
      },),
    );

  }

  Widget _createDate(String date, double fontSize) {
    return Text(
      "on ${formatDate(date: date, format: "dd MMMM, yyyy")} at ${formatDate(date: date, format: "hh:mm")}",
      style: AppStyle.normal_text.copyWith(
        color: AppColor.normalTextColor.withOpacity(0.6),
        fontSize: fontSize + 1,
      ),
    );
  }
}

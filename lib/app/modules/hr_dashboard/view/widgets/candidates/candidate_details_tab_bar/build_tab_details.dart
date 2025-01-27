import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/candidates_details_controller.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/models/job_application_preview.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../../../global/view/widget/app_margin.dart';

class BuildTabDetails extends GetView<CandidateDetailsController> {
  const BuildTabDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state)=>Padding(
      padding: marginLayout.copyWith(top: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.jobApplicationPreview?.getJobApplicationPreview
            ?.data?.length ??
            0,
        itemBuilder: (context, index) {
          Data? data = controller
              .jobApplicationPreview?.getJobApplicationPreview?.data?[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleText(data?.name ?? ""),
              _buildBasicInfo(data)
            ],
          );
        },
      ),
    ),onLoading: const LoadingIndicator());

  }

  _buildBasicInfo(Data? data) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 13),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data?.formFields?.length ?? 0,
        itemBuilder: (context, index) {
          FormFields? formFields = data?.formFields?[index];

          if (data?.formFields?[index].type == "file") {
            return _buildDetailsRow(
                label: data?.formFields?[index].name ?? "",
                file: data?.formFields?[index].formFieldValues?[0].file ??
                    File());
          } else if (data?.formFields?[index].type == "url") {
            return _buildDetailsRow(
                label: data?.formFields?[index].name ?? "",
                link: data?.formFields?[index].formFieldValues?[0].value ?? "");
          } else if (data?.formFields?[index].type == "date") {
            return _buildDetailsRow(
                label: data?.formFields?[index].name ?? "",
                value: formatDate(
                    date: data?.formFields?[index].formFieldValues?[0].value ??
                        "",
                    format: "dd MMMM, yyy"));
          } else if (data?.formFields?[index].type == "group") {
            return _buildEducationAndExperience(formFields ?? FormFields());
          } else if (data?.formFields?[index].type == "multi_line_text" &&
              data?.isQuestionable == true) {
            return _multilineText(formFields ?? FormFields());
          } else if (data?.formFields?[index].type == "single_line_text") {
            return _buildDetailsRow(
                label: data?.formFields?[index].name ?? "",
                value:
                    data?.formFields?[index].formFieldValues?[0].value ?? "");
          } else if (data?.formFields?[index].type == "checkbox") {
           return _buildSkillAndExperts(data?.formFields?[index]);
          } else {
            return _buildDetailsRow(
                label: data?.formFields?[index].name ?? "",
                value:
                    data?.formFields?[index].formFieldValues?[0].value ?? "");
          }
        },
      ),
    );
  }

  _buildEducationAndExperience(FormFields formFields) {
    return ListView.builder(
      itemCount: formFields.formFields?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // Get the name of the current form field
        String fieldName = formFields.formFields?[index].name ?? "";
        // Map over the filtered values and build rows for each name-value pair
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...?formFields.formFields?[index].formFieldValues
                ?.map((e) => _buildDetailsRow(
                      label: fieldName, // Pass the form field name
                      value: formFields.formFields?[index].type == "date"
                          ? formatDate(
                              date: e.value.toString(), format: "dd MMMM, yyy")
                          : e.value, // Pass the value for the form field
                    )),
          ],
        );
      },
    );
  }




  _buildTitleText(String text) {
    return Text(
      text,
      style: AppStyle.mid_large_text.copyWith(
          color: AppColor.normalTextColor.withOpacity(0.8),
          fontSize: Dimensions.fontSizeDefault,
          fontWeight: FontWeight.w600),
    );
  }

  Widget _buildDetailsRow(
      {required String label, String? value, String? link, File? file}) {
    final hasValue = value?.isNotEmpty ?? false;
    final hasLink = link?.isNotEmpty ?? false;
    final hasFile = file?.name?.isNotEmpty ?? false;
    return Padding(
      padding:
          EdgeInsets.only(bottom: (hasValue || hasLink || hasFile) ? 9.0 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasValue || hasLink || hasFile)
            Expanded(
              flex: 1,
              child: Text(
                label,
                style: AppStyle.normal_text.copyWith(color: AppColor.hintColor),
              ),
            ),
          if (hasValue || hasLink || hasFile) const SizedBox(width: 16),
          if (hasValue)
            Expanded(
              flex: 2,
              child: Text(
                value ?? "",
                maxLines: 20,
                style: AppStyle.normal_text
                    .copyWith(color: AppColor.normalTextColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (hasLink)
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  // TODO: Add open browser URL functionality here
                },
                child: Text(
                  link!,
                  maxLines: 3,
                  style: AppStyle.normal_text.copyWith(
                    color: AppColor.secondaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          if (hasFile)
            _buildAttachFile(
              file,
            ),
        ],
      ),
    );
  }

  _buildAttachFile(File? file) {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: () {
          Get.find<CandidateDetailsController>()
              .getFileSignUrl(file?.key ?? "");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppLayout.getHeight(160),
              width: AppLayout.getHeight(140),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.hintColor.withOpacity(0.1)),
                  child: Icon(
                    CupertinoIcons.doc_text,
                    size: 85,
                    color: AppColor.normalTextColor.withOpacity(0.5),
                  )),
            ),
            const SizedBox(height: 8),
            Text(
              file?.name ?? "",
              style: AppStyle.normal_text.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.8),
                  fontSize: Dimensions.fontSizeSmall),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSkillAndExperts(FormFields? formFields) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            formFields?.name??"",
            style: AppStyle.normal_text.copyWith(color: AppColor.hintColor),
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 4,
            ),
            itemCount:  formFields?.formFieldValues?.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  const Icon(
                    Icons.check_box,
                    color: AppColor.primaryColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    formFields?.formFieldValues?[index].value??"t",
                    style: AppStyle.normal_text.copyWith(
                      color: AppColor.normalTextColor,
                      fontSize: Dimensions.fontSizeDefault + 1,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  _multilineText(FormFields formFields) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formFields.name ?? "",
            maxLines: 20,
            style:
                AppStyle.normal_text.copyWith(color: AppColor.normalTextColor),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            formFields.formFieldValues?[0].value ?? "",
            maxLines: 20,
            style: AppStyle.normal_text
                .copyWith(color: AppColor.normalTextColor.withOpacity(0.6)),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

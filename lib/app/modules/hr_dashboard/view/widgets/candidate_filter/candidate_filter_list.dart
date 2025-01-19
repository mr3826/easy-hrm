import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import '../../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../employee/presentation/view/widget/filter/section_expansion_tile.dart';
import '../../../controllers/hr_deshboard_controller.dart';
import 'check_box.dart';

class CandidateFilterSection extends StatefulWidget {
  const CandidateFilterSection({super.key});

  @override
  State<CandidateFilterSection> createState() => _CandidateFilterSectionState();
}

class _CandidateFilterSectionState extends State<CandidateFilterSection> {
  HrDashBoardController controller = Get.find<HrDashBoardController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isCandidateFilterLoading.isTrue
        ? const Center(child: LoadingIndicator())
        : Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [..._buildSectionList()],
                  ),
                ),
              ),
            ],
          ));
  }

  List<Widget> _buildSectionList() {
    final sectionTitles = [
      AppString.text_job_post.tr,
      AppString.text_stage.tr,
      AppString.text_rating.tr
    ];

    return sectionTitles.map((title) {
      return Column(
        children: [
          SectionExpansionTile(
            title: title,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _statusCheckBox(title),
              ),
            ],
          ),
          _divider(),
        ],
      );
    }).toList();
  }

  Widget _buildHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return buildBottomSheetHeader(
          height: constraints.constrainHeight(76),
          customWidget: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(flex: 2),
              Center(
                child: Text(
                  AppString.textFilters.tr,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.fontSizeMid,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              const Spacer(),
              _buildResetButton(),
              const SizedBox(width: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResetButton() {
    return InkWell(
      onTap: () {},
      child: Text(
        AppString.textReset.tr,
        style: AppStyle.normal_text_black.copyWith(
          color: AppColor.secondaryColor,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.fontSizeDefault - 1,
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 0.5,
      width: double.infinity,
      color: AppColor.hintColor.withOpacity(0.3),
    );
  }

  Widget _statusCheckBox(String title) {
    List<CheckBoxModel> list = [];
    final RxList<String> selectedStageIds = <String>[].obs; // Holds stage IDs
    final RxList<String> selectedJobIds = <String>[].obs; // Holds job IDs

    final hiringStages =controller.filterHiringStages?.getHiringStagesForDropDown?.data;
    final jobDropdowns = controller.filterJobsDropdown?.getJobsDropdown;

    if (title == AppString.text_rating.tr) {
      list = [
        CheckBoxModel(checkBoxName: 'No rating', checkBoxNameValue: 'No rating'),
        CheckBoxModel(checkBoxName: '1 star', checkBoxNameValue: '1 star'),
        CheckBoxModel(checkBoxName: '2 stars', checkBoxNameValue: '2 stars'),
        CheckBoxModel(checkBoxName: '3 stars', checkBoxNameValue: '3 stars'),
        CheckBoxModel(checkBoxName: '4 stars', checkBoxNameValue: '4 stars'),
        CheckBoxModel(checkBoxName: '5 stars', checkBoxNameValue: '5 stars'),
      ];
    } else if (title == AppString.text_stage.tr && hiringStages != null) {
      list = hiringStages
          .map((stage) => CheckBoxModel(
                checkBoxName: stage.title ?? "-",
                checkBoxNameValue: stage.stageIds.toString(),
              ))
          .toList();
    } else if (title == AppString.text_job_post.tr && jobDropdowns != null) {
      list = jobDropdowns
          .map((job) => CheckBoxModel(
                checkBoxName: job.title ?? "-",
                checkBoxNameValue: job.id.toString(),
              ))
          .toList();
    }

    return GSMultiCheckbox(
      textStyle: AppStyle.normal_text_black.copyWith(
        fontSize: Dimensions.fontSizeDefault + 1,
        color: AppColor.normalTextColor.withOpacity(0.9),
      ),
      itemsList: list,
      onSelectionChanged: (List<CheckBoxModel> selectedList) {
        if (title == AppString.text_stage.tr) {

          selectedStageIds.value = selectedList.map((e) => e.checkBoxNameValue).toList();

        } else if (title == AppString.text_job_post.tr) {

          selectedJobIds.value = selectedList.map((e) => e.checkBoxNameValue).toList();

        }

        // Debugging prints
        print('Selected Stage IDs: $selectedStageIds');
        print('Selected Job IDs: $selectedJobIds');
      },
    );
  }
}

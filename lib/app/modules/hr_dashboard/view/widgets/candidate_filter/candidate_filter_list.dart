import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import '../../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../global/view/multi_check_box.dart';
import '../../../../employee/view/widget/filter/section_expansion_tile.dart';
import '../../../controllers/hr_deshboard_controller.dart';

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
    return buildBottomSheetHeader(
      height: AppLayout.getHeight(89),
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
  }

  Widget _buildResetButton() {
    return InkWell(
      onTap: () {
        var controller = Get.find<HrDashBoardController>();
        controller.resetCheckBoxList(controller.jobPost??[]);
        controller.resetCheckBoxList(controller.hiringStage??[]);
        controller.resetCheckBoxList(controller.rating??[]);
        setState(() {});
        controller.getCandidateBySearch();
      },
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
    List<CheckBoxModel>? list = [];

    if (title == AppString.text_job_post.tr) {

      list = Get.find<HrDashBoardController>().jobPost;

    } else if (title == AppString.text_stage.tr) {

      list = Get.find<HrDashBoardController>().hiringStage;

    } else {

      list = Get.find<HrDashBoardController>().rating;

    }

    return MultiCheckbox(
      textStyle: AppStyle.normal_text_black.copyWith(
        fontSize: Dimensions.fontSizeDefault + 1,
        color: AppColor.normalTextColor.withOpacity(0.9),
      ),
      itemsList: list ?? [],
      onSelectionChanged: (List<CheckBoxModel> selectedList) {
        controller.getCandidateBySearch();
      },
    );
  }
}

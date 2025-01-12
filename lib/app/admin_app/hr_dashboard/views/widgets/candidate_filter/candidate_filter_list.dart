import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../modules/employee/presentation/view/widget/filter/section_expansion_tile.dart';
import 'check_box.dart';

class CandidateFilterSection extends StatefulWidget {
  const CandidateFilterSection({super.key});

  @override
  State<CandidateFilterSection> createState() => _CandidateFilterSectionState();
}

class _CandidateFilterSectionState extends State<CandidateFilterSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }

  List<Widget> _buildSectionList() {
    final sectionTitles = [
      AppString.text_job_post.tr,
      AppString.text_stage.tr,
      AppString.text_department.tr,
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

    if (title == AppString.text_rating.tr) {
      list = [
        CheckBoxModel(checkBoxName: 'No rating', checkBoxNameValue: 'No rating'),
        CheckBoxModel(checkBoxName: '1 start', checkBoxNameValue: '1 start'),
        CheckBoxModel(checkBoxName: '2 start', checkBoxNameValue: '2 start'),
        CheckBoxModel(checkBoxName: '3 start', checkBoxNameValue: '3 start'),
        CheckBoxModel(checkBoxName: '4 start', checkBoxNameValue: '4 start'),
        CheckBoxModel(checkBoxName: '5 start', checkBoxNameValue: '5 start'),
      ];
    } else {
      list = [
        CheckBoxModel(
            checkBoxName: 'Laravel developer', checkBoxNameValue: '1'),
        CheckBoxModel(checkBoxName: 'UI/UX developer', checkBoxNameValue: '1'),
      ];
    }

    return GSMultiCheckbox(
      textStyle: AppStyle.normal_text_black.copyWith(
        fontSize: Dimensions.fontSizeDefault + 1,
        color: AppColor.normalTextColor.withOpacity(0.9),
      ),
      itemsList: list,
      onSelectionChanged: (List<CheckBoxModel> list) async {
        print(list);
      },
    );
  }
}

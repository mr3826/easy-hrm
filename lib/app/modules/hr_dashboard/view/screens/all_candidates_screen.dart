import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/controllers/hr_deshboard_controller.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/view/widgets/candidate_filter/candidate_filter_list.dart';
import 'package:payrun_mobile/app/modules/hr_dashboard/view/widgets/candidates/build_all_candidates.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import '../../../../../common/widget/custom_appbar.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/images.dart';
import '../../../employee/presentation/view/widget/employee_list/search_with_filter.dart';
import '../widgets/candidates/search_candidate_list.dart';

class AllCandidatesScreen extends GetView<HrDashBoardController> {
  const AllCandidatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: AppString.text_candidate.tr),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customSpacerHeight(height: 8),
          _buildSearchWithFilters(),

          const BuildAllCandidates()
        ],
      ),
    );
  }

  Widget _buildSearchWithFilters() {
    return Row(
      children: [
        customSpacerWidth(width: 20),
        CustomButtonWithIconAndLabel(
          icon: CupertinoIcons.search,
          labelText: AppString.textSearch.tr,
          onTap: () {
            controller.candidateList?.getCandidates?.data?.clear();
            _showEmployeeSelectionSheet();
          },
        ),
        customSpacerWidth(width: 8),
        CustomButtonWithIconAndLabel(
          customIconWidget: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Image.asset(Images.filterIcon),
          ),
          labelText: AppString.textFilters.tr,
          onTap: () {
            if(controller.isFilterInfoApiCalledLoading.isFalse){
              controller.getHiringStages();
              controller.getJobsDropdown();
            }
            _showFilterSelectionSheet();
          },
        ),
        customSpacerWidth(width: 20),
      ],
    );
  }

  void _showFilterSelectionSheet() {
    customButtonSheet(
      context: Get.context!,
      child: const CandidateFilterSection(),
      height: 0.8,
    );
  }

  void _showEmployeeSelectionSheet() {
    customButtonSheet(
      context: Get.context!,
      child: SearchCandidateList(
        onRouteAction: () => Get.back(canPop: false),
        onUserSelected: (info) {
          info.name ?? "";
          Get.find<HrDashBoardController>()
              .getCandidateBySearch(searchKey: info.name ?? "");
          Get.find<HrDashBoardController>().candidateSearchController.clear();
        },
      ),
      height: 0.8,
    );
  }
}

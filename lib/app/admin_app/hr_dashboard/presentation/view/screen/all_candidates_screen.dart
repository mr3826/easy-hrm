import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/images.dart';
import '../../../../employee/presentation/view/screen/employee_screen.dart';
import '../../../../employee/presentation/view/widget/employee_list/search_with_filter.dart';
import '../widget/candidates/build_all_candidates.dart';


class AllCandidatesScreen extends StatelessWidget {
  const AllCandidatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customSpacerHeight(height: 8),
          _buildSearchWithFilters(),

          const BuildAllCandidates()




        ],
      ),
    );
  }

  _buildAppbar() {
    return AppBar(
      title: Text(
        "Candidates",
        style: AppStyle.large_text.copyWith(
            color: AppColor.normalTextColor,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.fontSizeMid + 1),
      ),
      centerTitle: true,
      leading: IconButton(
          onPressed: ()=>Get.back(canPop: false),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.hintColor,
            size: 19,
          )),
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
            showEmployeeSelectionSheet();
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
            // showFilterSelectionSheet();
          },
        ),
        customSpacerWidth(width: 20),
      ],
    );
  }

}

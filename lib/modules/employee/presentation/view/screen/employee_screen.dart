import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../common/widget/custom_appbar.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';
import '../widget/contact_list/contact_list.dart';
import '../widget/contact_list/search_with_filter.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildEmployeeAppBar(),
      body: Column(
        children: [
          customSpacerHeight(height: 16),
          _buildSearchWithFilters(),
         customSpacerHeight(height: 4),

          _buildContactList(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildEmployeeAppBar() {
    return customAppbar(
      leadingIcon: Text(
        AppString.textEmployees.tr,
        style: AppStyle.normal_text_black.copyWith(
          fontSize: Dimensions.fontSizeMid,
        ),
      ),
      leadingWidth: MediaQuery.of(Get.context!).size.width / 3,
      centerTitle: false,
      actions: [
        customSvgImage(
          imageUrl: Images.notificationIconNavOutLine,
          height: 26,
          width: 26,
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _buildSearchWithFilters() {
    return Row(
      children: [
        const SizedBox(width: 20),
        SearchAndFilterButton(
          icon: CupertinoIcons.search,
          labelText: "Search",
          onTap: () {},
        ),
        const SizedBox(width: 8),
        SearchAndFilterButton(
          widget: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Image.asset(Images.filterIcon),
          ),
          labelText: "Filters",
          onTap: () {},
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildContactList() {

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 8,right: 8),
        itemBuilder: (context, index) {
          return buildContactListInfo(
            name: "Jonus Kahnwald",
            departmentName: "Laravel department",
            imgUrlKey: "",
            statusText: "Permanent",
            statusColor: AppColor.successColor,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/model/employee_work_history.dart';
import 'package:payrun_mobile/modules/profile/view/widget/dotted_style_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../app/global/view/widget/app_margin.dart';
import '../../../../common/widget/custom_network_image.dart';
import '../../../../common/widget/loading_indicator.dart';


class DepartmentHistory extends GetView<UserProfileController> {
  const DepartmentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isEmployeeInfoLoading.isTrue) {
        return const Center(child: LoadingIndicator());
      }

      final deptHistories = controller.employeeWorkHistory?.getOrganizationUserHistory?.deptHistories;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customButtonSheetAppbar(
            text: AppString.text_deparmtnet.tr,
            subtext: AppString.text_history.tr,
          ),
          if (deptHistories == null || deptHistories.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "No department history!",
                  style: AppStyle.normal_text_black.copyWith(
                    color: AppColor.hintColor,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: deptHistories.length,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final deptHistory = deptHistories[index];
                  final isLastItem = index == deptHistories.length - 1;
                  return _buildDepartmentInfo(
                    isLastIndex: isLastItem,
                    deptHistory: deptHistory,
                  );
                },
              ),
            ),
        ],
      );
    });
  }

  Widget _buildDepartmentInfo({
    required bool isLastIndex,
    required DeptHistories deptHistory,
  }) {
    return Padding(
      padding: marginLayout.copyWith(bottom: 14, left: 0, right: 0, top: 16),
      child: Stack(
        children: [
          Padding(
            padding: marginLayout,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSvgImage(
                  imageUrl: Images.departmentNotification,
                  color: AppColor.normalTextColor,
                  height: 18,
                  width: 18,
                ),
                customSpacerWidth(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deptHistory.department?.name ?? "",
                      style: AppStyle.normal_text_grey.copyWith(
                        color: AppColor.normalTextColor,
                        fontSize: Dimensions.fontSizeMid - 3,
                      ),
                    ),
                    _buildEmploymentDetails(deptHistory),
                    customSpacerHeight(height: 14),
                    SizedBox(
                      child: Stack(
                        children: [
                          _buildDivider(),
                          Stack(
                            children: [
                              _buildManagerDetails(deptHistory),
                              _buildCircleAvatar(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (!isLastIndex)
            Positioned(
              top: 26,
              left: 1,
              bottom: 0,
              child: dottedStyleLayout(height: 99),
            ),
        ],
      ),
    );
  }

  Widget _buildCircleAvatar() {
    return Positioned(
      left: 40,
      bottom: 0,
      child: CircleAvatar(
        radius: 8,
        backgroundColor: AppColor.pureOrange,
        child: customSvgImage(
          imageUrl: Images.departmentNotification,
          color: AppColor.cardColor,
          height: 10,
        ),
      ),
    );
  }

  Widget _buildEmploymentDetails(DeptHistories deptHistory) {
    final startDate = _formatDate(deptHistory.startDate);
    final endDate = _formatDate(deptHistory.endDate) ?? AppString.textPresent.tr;
    final parentDeptName = _getParentDepartmentName(deptHistory);

    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width / 1.5,
      child: Text.rich(
        TextSpan(
          children: [
            if (parentDeptName.isNotEmpty)
              TextSpan(
                text: parentDeptName,
                style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.secondaryColor,
                  fontSize: Dimensions.fontSizeDefault - 3,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (parentDeptName.isNotEmpty)
              const TextSpan(
                text: '  | ',
                style: TextStyle(color: AppColor.hintColor, fontSize: 10),
              ),
            TextSpan(
              text: "${AppString.text_from.tr} $startDate",
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault - 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const TextSpan(
              text: ' - ',
              style: TextStyle(color: AppColor.hintColor, fontSize: 10),
            ),
            TextSpan(
              text: endDate,
              style: AppStyle.mid_large_text.copyWith(
                color: endDate == AppString.textPresent.tr
                    ? AppColor.primaryColor
                    : AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault - 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManagerDetails(DeptHistories deptHistory) {
    final managerName = _getManagerFullName(deptHistory);
    final initials = _getManagerInitials(deptHistory);

    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColor.pendingColor,
            radius: 20,
            child: CircleAvatar(
              backgroundColor: AppColor.cardColor,
              radius: 19.4,
              child: CustomNetworkImage(
                errorText: initials, //Error text
                height: 18,
                imgUrlKey: deptHistory.department?.manager?.profile?.image ?? "",
                borderColor: Colors.transparent,
              ),
            ),
          ),
          customSpacerWidth(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                managerName,
                style: AppStyle.normal_text_grey.copyWith(
                  color: AppColor.secondaryColor,
                  fontSize: Dimensions.fontSizeDefault - 1,
                ),
              ),
              Text(
                AppString.departmentHeaDText.tr,
                style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeDefault - 3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Positioned(
      child: Container(
        height: AppLayout.getHeight(20),
        width: AppLayout.getWidth(18),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: .9,
              color: AppColor.hintColor.withOpacity(0.6),
            ),
            bottom: BorderSide(
              width: .9,
              color: AppColor.hintColor.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }

  String? _formatDate(String? date) {
    return date != null
        ? DateFormat('dd MMM, yyyy').format(DateTime.parse(date))
        : null;
  }

  String _getParentDepartmentName(DeptHistories deptHistory) {
    return deptHistory.department?.parent?.name != null
        ? "${AppString.text_child_of_deparmtnet.tr} ${deptHistory.department!.parent!.name!}"
        : "";
  }

  String _getManagerFullName(DeptHistories deptHistory) {
    final profile = deptHistory.department?.manager?.profile;
    return "${profile?.firstName ?? ""} ${profile?.lastName ?? ""}".trim();
  }

  String _getManagerInitials(DeptHistories deptHistory) {
    final profile = deptHistory.department?.manager?.profile;
    final firstInitial = profile?.firstName?.substring(0, 1).toUpperCase() ?? "";
    final lastInitial = profile?.lastName?.substring(0, 1).toUpperCase() ?? "";
    return "$firstInitial$lastInitial";
  }
}


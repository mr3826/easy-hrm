import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/view/widgets/custom_network_image.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/app/modules/profile/models/employee_work_history.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/dotted_style_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../global/utils/date_format_helper.dart';
import '../../../../global/view/widget/app_margin.dart';
import '../../controller/global_profile_controller.dart';

class DepartmentHistoryView extends GetView<ProfileGlobalController> {
  final String orgUserId;

  const DepartmentHistoryView({required this.orgUserId, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customButtonSheetAppbar(
          text: AppString.text_deparmtnet.tr,
          subtext: AppString.text_history.tr,
        ),
        FutureBuilder(
          future: controller.getOrgUserDeptHistory(ordUserId: orgUserId),
          builder: (BuildContext context,
              AsyncSnapshot<List<DeptHistories>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: AppColor.primaryColor,
                  radius: 14,
                ),
              );
            }
            if (snapshot.hasError || snapshot.data!.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "No department history!",
                    style: AppStyle.normal_text_black.copyWith(
                      color: AppColor.hintColor,
                    ),
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final deptHistory = snapshot.data?[index];
                  final isLastItem = index == snapshot.data!.length - 1;
                  return _buildDepartmentInfo(
                    isLastIndex: isLastItem,
                    deptHistory: deptHistory!,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
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
                      deptHistory.department.name,
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
    final endDate =
        _formatDate(deptHistory.endDate) ?? AppString.textPresent.tr;
    final parentDeptName = _getParentDepartmentName(deptHistory);

    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width / 1.5,
      child: Text.rich(
        TextSpan(
          children: [
            if (deptHistory.department.parent.name.isNotEmpty)
              TextSpan(
                text: '$parentDeptName  | ',
                style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.secondaryColor,
                  fontSize: Dimensions.fontSizeDefault - 3,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            TextSpan(
              text: startDate,
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
              child: CircularNetworkImage(
                errorText: initials, //Error text
                radius: 18,
                imageUrl: buildImgIxUrl(
                    isPublic: true,
                    imagePath: deptHistory.department.manager.profile.image),
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
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5)),
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
    return date != null && date.isNotEmpty
        ? DateFormatHelper.formatDate(date: date, format: "dd MMM, yyyy")
        : "";
  }

  String _getParentDepartmentName(DeptHistories deptHistory) {
    return "${AppString.text_child_of_deparmtnet.tr} ${deptHistory.department.parent.name}";
  }

  String _getManagerFullName(DeptHistories deptHistory) {
    final profile = deptHistory.department.manager.profile;
    return "${profile.firstName} ${profile.lastName}".trim();
  }

  String _getManagerInitials(DeptHistories deptHistory) {
    final profile = deptHistory.department.manager.profile;
    final firstInitial = profile.firstName.substring(0, 1).toUpperCase();
    final lastInitial = profile.lastName.substring(0, 1).toUpperCase();
    return "$firstInitial$lastInitial";
  }
}

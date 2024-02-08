import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/view/widget/dotted_style_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

import '../../../../common/widget/custom_network_image.dart';
import '../../../../utils/utils.dart';

class DepartmentHistory extends StatelessWidget {
  const DepartmentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customButtonSheetAppbar(
            text: AppString.text_deparmtnet.tr,
            subtext: AppString.text_history.tr),
        Expanded(
            child: ListView.builder(
          itemCount: Get.find<UserProfileController>()
              .employeeWorkHistory
              ?.getOrganizationUserHistory
              ?.deptHistories
              ?.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return _departmentSectionInfoLayout(
              imageUrl: Get.find<UserProfileController>()
                      .employeeWorkHistory
                      ?.getOrganizationUserHistory
                      ?.deptHistories?[index]
                      .department
                      ?.manager
                      ?.profile
                      ?.image ??
                  "",
              index: index,
              startDate: _getEmploymentDate(Get.find<UserProfileController>()
                  .employeeWorkHistory
                  ?.getOrganizationUserHistory
                  ?.deptHistories?[index]
                  .startDate),
              endDate: _getEmploymentDate(Get.find<UserProfileController>()
                  .employeeWorkHistory
                  ?.getOrganizationUserHistory
                  ?.deptHistories?[index]
                  .endDate),
              departmentName: Get.find<UserProfileController>()
                      .employeeWorkHistory
                      ?.getOrganizationUserHistory
                      ?.deptHistories?[index]
                      .department
                      ?.name ??
                  "",
              parentDepartment: _getParentDepartmentName(index),
              managerName: _getManagerName(index),
            );
          },
        ))
      ],
    );
  }

  _departmentSectionInfoLayout({
    required String departmentName,
    required String parentDepartment,
    String? startDate,
    String? endDate,
    required int index,
    required String managerName,
    required String imageUrl,
  }) {
    return Padding(
      padding: marginLayout.copyWith(bottom: 18, left: 0, right: 0, top: 16),
      child: Stack(
        children: [
          Padding(
            padding: marginLayout,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSvgImage(
                    imageUrl: Images.department_notification,
                    color: AppColor.normalTextColor,
                    height: 24,
                    width: 24),
                customSpacerWidth(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      departmentName,
                      style: AppStyle.normal_text_grey.copyWith(
                          color: AppColor.normalTextColor,
                          fontSize: Dimensions.fontSizeMid - 3),
                    ),
                    _employmentDate(
                        startDate: startDate,
                        endDate: endDate,
                        parentDepartment: parentDepartment),
                    customSpacerHeight(height: 14),
                    SizedBox(
                      child: Stack(
                        children: [
                          _verticalAndHorizontalDivider(),
                          Stack(
                            children: [
                              _managerInfoLayout(
                                  index: index,
                                  imageUrl: imageUrl,
                                  managerName: managerName),
                              _departmentCircleLayout()
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
              top: 26,
              left: 1,
              bottom: 0,
              child: dottedStyleLayout(height: 88)),
        ],
      ),
    );
  }

  _departmentCircleLayout() {
    return Positioned(
        left: 40,
        bottom: 0,
        child: CircleAvatar(
          radius: 8,
          backgroundColor: AppColor.pureOrange,
          child: customSvgImage(
              imageUrl: Images.department_notification,
              color: AppColor.cardColor,
              height: 10),
        ));
  }

  String? _getEmploymentDate(String? date) {
    if (date != null) {
      return dateMonthYearFormatFromDatetime(date);
    } else {
      return null;
    }
  }

  _employmentDate({String? startDate, String? endDate, parentDepartment}) {
    return SizedBox(
      width: MediaQuery.of(Get.context!).size.width / 1.5,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: parentDepartment,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.secondaryColor,
                  fontSize: Dimensions.fontSizeDefault - 3,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis),
            ),
            if (parentDepartment.isNotEmpty)
              const TextSpan(
                text: '  | ',
                style: TextStyle(color: AppColor.hintColor, fontSize: 10),
              ),
            TextSpan(
                text: "${AppString.text_from.tr} $startDate",
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    fontSize: Dimensions.fontSizeDefault - 4,
                    overflow: TextOverflow.ellipsis)),
            const TextSpan(
              text: ' - ',
              style: TextStyle(color: AppColor.hintColor, fontSize: 10),
            ),
            TextSpan(
                text: endDate ?? AppString.textPresent.tr,
                style: endDate == null
                    ? AppStyle.mid_large_text.copyWith(
                        color: AppColor.primaryColor,
                        fontSize: Dimensions.fontSizeDefault - 3)
                    : AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault - 3,
                        overflow: TextOverflow.ellipsis,
                      )),
          ],
        ),
      ),
    );
  }

  _getParentDepartmentName(int index) {
    if (Get.find<UserProfileController>()
            .employeeWorkHistory
            ?.getOrganizationUserHistory
            ?.deptHistories?[index]
            .department
            ?.parent !=
        null) {
      return "${AppString.text_child_of_deparmtnet.tr} ${Get.find<UserProfileController>().employeeWorkHistory?.getOrganizationUserHistory?.deptHistories?[index].department?.parent?.name ?? ""}";
    } else {
      return "";
    }
  }

  String _getManagerName(int index) {
    return "${Get.find<UserProfileController>().employeeWorkHistory?.getOrganizationUserHistory?.deptHistories?[index].department?.manager?.profile?.firstName ?? ""} ${Get.find<UserProfileController>().employeeWorkHistory?.getOrganizationUserHistory?.deptHistories?[index].department?.manager?.profile?.lastName ?? ""}";
  }

  _managerImageLayout(imageUrl, int index) {
    return CircleAvatar(
      backgroundColor: AppColor.pendingColor,
      radius: 20,
      child: CircleAvatar(
        backgroundColor: AppColor.cardColor,
        radius: 19.4,
        child: CustomNetworkImage(
          errorText: _getFirstCharOfName(index),
          height: 18,
          imgUrlKey: imageUrl,
          borderColor: Colors.transparent,
        ),
      ),
    );
  }

  _managerInfoLayout({imageUrl, managerName, required int index}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: [
          _managerImageLayout(imageUrl, index),
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
                AppString.textManager.tr,
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeDefault - 3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _verticalAndHorizontalDivider() {
    return Positioned(
      child: Container(
        height: AppLayout.getHeight(20),
        width: AppLayout.getWidth(18),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
                width: .9, color: AppColor.hintColor.withOpacity(0.6)),
            bottom: BorderSide(
                width: .9, color: AppColor.hintColor.withOpacity(0.6)),
          ),
        ),
      ),
    );
  }

  String _getFirstCharOfName(int index) {
    String firstCharOfFirstName = Get.find<UserProfileController>()
                    .employeeWorkHistory
                    ?.getOrganizationUserHistory
                    ?.deptHistories?[index]
                    .department
                    ?.manager
                    ?.profile !=
                null &&
            Get.find<UserProfileController>()
                .employeeWorkHistory!
                .getOrganizationUserHistory!
                .deptHistories![index]
                .department!
                .manager!
                .profile!
                .firstName!
                .isNotEmpty
        ? Get.find<UserProfileController>()
            .employeeWorkHistory!
            .getOrganizationUserHistory!
            .deptHistories![index]
            .department!
            .manager!
            .profile!
            .firstName![0]
            .toUpperCase()
        : "";

    String lastCharOfFirstName = Get.find<UserProfileController>()
                    .employeeWorkHistory
                    ?.getOrganizationUserHistory
                    ?.deptHistories?[index]
                    .department
                    ?.manager
                    ?.profile !=
                null &&
            Get.find<UserProfileController>()
                .employeeWorkHistory!
                .getOrganizationUserHistory!
                .deptHistories![index]
                .department!
                .manager!
                .profile!
                .lastName!
                .isNotEmpty
        ? Get.find<UserProfileController>()
            .employeeWorkHistory!
            .getOrganizationUserHistory!
            .deptHistories![index]
            .department!
            .manager!
            .profile!
            .lastName![0]
            .toUpperCase()
        : "";

    return "$firstCharOfFirstName$lastCharOfFirstName";
  }
}

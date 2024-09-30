import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/view/widget/dotted_style_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../auth/presentation/view/otp_screen.dart';
import '../../model/employee_work_history.dart';

class DesignationLayout extends StatelessWidget {
  const DesignationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileController = Get.find<UserProfileController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customButtonSheetAppbar(
            text: AppString.text_designation.tr,
            subtext: AppString.text_history.tr),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: userProfileController
                    .employeeWorkHistory
                    ?.getOrganizationUserHistory
                    ?.designationHistories
                    ?.length ??
                0,
            itemBuilder: (context, index) {
              final designationHistory = userProfileController
                  .employeeWorkHistory
                  ?.getOrganizationUserHistory
                  ?.designationHistories?[index];

              final designationHistories = Get.find<UserProfileController>()
                  .employeeWorkHistory
                  ?.getOrganizationUserHistory;

              bool isLastItem = (designationHistories != null &&
                      designationHistories.designationHistories != null &&
                      designationHistories.designationHistories!.isNotEmpty)
                  ? index ==
                      designationHistories.designationHistories!.length - 1
                  : false;

              return _employeeStatusInfoLayout(designationHistory, isLastItem);
            },
          ),
        ),
      ],
    );
  }

  Widget _employeeStatusInfoLayout(DesignationHistories ?designationHistory, bool isLastItem) {
    final baseTextStyle = AppStyle.mid_large_text.copyWith(
      fontSize: Dimensions.fontSizeDefault - 2,
      overflow: TextOverflow.ellipsis,
    );

    final developerStatus = designationHistory?.designation?.name ?? "";
    final date = _formatDate(designationHistory?.startDate);
    final durationText =
        "${AppString.text_form_last.tr} ${workingTimeSinceFormString(designationHistory?.startDate ?? "",designationHistory?.endDate ?? "")}";
    final employeeCurrentStatus = designationHistory?.endDate == null
        ? AppString.textPresent.tr
        : dateMonthYearFormatFromDatetime(designationHistory?.endDate ?? "");

    return Stack(
      children: [
        Padding(
          padding: marginLayout.copyWith(top: 26, bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: customSvgImage(
                  imageUrl: Images.EMPLOYEE_STATUS,
                  color: AppColor.normalTextColor,
                  height: 18,
                  width: 18,
                ),

              ),
              customSpacerWidth(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      developerStatus,
                      style: AppStyle.normal_text_grey.copyWith(
                        color: AppColor.normalTextColor,
                        fontSize: Dimensions.fontSizeMid - 2,
                      ),
                    ),
                    customSpacerHeight(height: 4),
                    Wrap(
                      children: [
                        Text(
                          "$date - ",
                          style: baseTextStyle.copyWith(
                            color: AppColor.hintColor,
                          ),
                        ),
                        Text(
                          employeeCurrentStatus,
                          style: baseTextStyle.copyWith(
                            color: AppColor.primaryColor,
                          ),
                        ),
                        _divider(),
                        Text(
                          durationText,
                          style: baseTextStyle.copyWith(
                            color: AppColor.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        isLastItem == true ? const SizedBox.shrink() : _dottedLayout(),
      ],
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6),
      child: Container(
        width: 1,
        color: AppColor.hintColor,
        height: 16,
      ),
    );
  }

  Widget _dottedLayout() {
    return Positioned(
      top: 55,
      left: 1,
      bottom: 0,
      child: dottedStyleLayout(height: 46),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return "";
    final dateTime = DateTime.parse(dateString);
    return DateFormat('dd MMM, yyyy').format(dateTime);
  }
}

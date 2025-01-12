import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import '../../../../app/global/view/widget/app_margin.dart';
import '../../../../common/controller/convart_color_code_controller.dart';
import '../../../../utils/utils.dart';
import 'department_layout_widget.dart';

class EmploymentLayout extends StatelessWidget {
  const EmploymentLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customButtonSheetAppbar(
            text: AppString.text_employment.tr,
            subtext: AppString.text_history.tr),
        Expanded(
            child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          itemCount: Get.find<UserProfileController>()
                  .employeeWorkHistory
                  ?.getOrganizationUserHistory
                  ?.employmentHistories
                  ?.length ??
              0,
          itemBuilder: (context, index) {
            final employmentHistories = Get.find<UserProfileController>()
                .employeeWorkHistory
                ?.getOrganizationUserHistory
                ?.employmentHistories;

            bool isLastItem =
                (employmentHistories != null && employmentHistories.isNotEmpty)
                    ? index == employmentHistories.length - 1
                    : false;

            return EmployeeStatusInfoLayout(
              isLastItem: isLastItem,
              developerStatus:
                  employmentHistories?[index].employmentStatus?.name ?? '',
              date: getDateTimeFormat(
                  employmentHistories?[index].startDate ?? ""),
              durationText:
                  "${employmentHistories?[index].endDate != null ? "" : AppString.text_form_last.tr} ${workingTimeSinceFormString(employmentHistories?[index].startDate ?? "", employmentHistories?[index].endDate ?? "")}",
              employeeCurrentStatus: employmentHistories?[index].endDate == null
                  ? AppString.textPresent.tr
                  : dateMonthYearFormatFromDatetime(
                      employmentHistories?[index].endDate ?? ""),
              statusColor: HexColor(
                  employmentHistories?[index].employmentStatus?.color ??
                      "#8F99AD"),
            );
          },
        ))
      ],
    );
  }
}

class EmployeeStatusInfoLayout extends StatelessWidget {
  final String developerStatus;
  final String date;
  final String durationText;
  final Color statusColor;
  final bool isLastItem;
  final String employeeCurrentStatus;

  const EmployeeStatusInfoLayout({
    super.key,
    required this.developerStatus,
    required this.date,
    required this.isLastItem,
    required this.durationText,
    required this.statusColor,
    required this.employeeCurrentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = AppStyle.mid_large_text.copyWith(
      fontSize: Dimensions.fontSizeDefault - 2,
      overflow: TextOverflow.ellipsis,
    );

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
                  imageUrl: Images.FLAG,
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
                    Row(
                      children: [
                        Text(
                          developerStatus,
                          style: AppStyle.normal_text_grey.copyWith(
                            color: AppColor.normalTextColor,
                            fontSize: Dimensions.fontSizeMid - 2,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        customSpacerWidth(width: 8),
                        Icon(
                          Icons.circle,
                          color: statusColor,
                          size: 12,
                        ),
                      ],
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
                            color: employeeCurrentStatus ==
                                    AppString.textPresent.tr
                                ? AppColor.primaryColor
                                : AppColor.hintColor,
                          ),
                        ),
                        const Divider(),
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
        isLastItem == true
            ? const SizedBox.shrink()
            : Positioned(
                top: 55,
                left: 1,
                bottom: 0,
                child: dottedStyleLayout(height: 46),
              ),
      ],
    );
  }
}

class Divider extends StatelessWidget {
  const Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        width: 1,
        color: AppColor.hintColor,
        height: 16,
      ),
    );
  }
}

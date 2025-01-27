import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/dotted_style_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../../../../common/controller/convart_color_code_controller.dart';
import '../../../../../../../common/widget/employee/department_info_widget.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../auth/view/screens/otp_screen.dart';
import '../../../../controller/global_profile_controller.dart';
import '../../../../models/employee_work_history.dart';

class EmploymentLayout extends GetView<ProfileGlobalController> {
  const EmploymentLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isEmployeeInfoLoading.isTrue) {
        return const LoadingIndicator();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customButtonSheetAppbar(
            text: AppString.text_employment.tr,
            subtext: AppString.text_history.tr,
          ),
          if (controller.employeeWorkHistory?.getOrganizationUserHistory?.employmentHistories == null)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "No employee status!",
                  style: AppStyle.normal_text_black
                      .copyWith(color: AppColor.hintColor),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: controller
                        .employeeWorkHistory
                        ?.getOrganizationUserHistory
                        ?.employmentHistories
                        ?.length ??
                    0,
                itemBuilder: (context, index) {
                  final employmentHistory = controller.employeeWorkHistory?.getOrganizationUserHistory?.employmentHistories?[index];

                  return EmploymentStatusItem(
                    employmentHistory: employmentHistory,
                    isLastItem: index == (controller
                                    .employeeWorkHistory
                                    ?.getOrganizationUserHistory
                                    ?.employmentHistories
                                    ?.length ??
                                1) -
                            1,
                  );
                },
              ),
            ),
        ],
      );
    });
  }
}

class EmploymentStatusItem extends StatelessWidget {
  final EmploymentHistories? employmentHistory;
  final bool isLastItem;

  const EmploymentStatusItem({
    super.key,
    required this.employmentHistory,
    required this.isLastItem,
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
                          employmentHistory?.employmentStatus?.name ?? "",
                          style: AppStyle.normal_text_black.copyWith(
                            color: AppColor.normalTextColor,
                            fontSize: Dimensions.fontSizeMid - 2,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        customSpacerWidth(width: 8),
                        Icon(
                          Icons.circle,
                          color: HexColor(
                              employmentHistory?.employmentStatus?.color ??
                                  "#8F99AD"),
                          size: 12,
                        ),
                      ],
                    ),
                    customSpacerHeight(height: 4),
                    Wrap(
                      children: [
                        Text(
                          "${getDateTimeFormat(employmentHistory?.startDate ?? "")} - ",
                          style: baseTextStyle.copyWith(
                            color: AppColor.hintColor,
                          ),
                        ),
                        _buildEmploymentStatus(employmentHistory),
                         _verticalDividerWidget(),
                        Text(
                          _calculateDuration(employmentHistory),
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
        if (!isLastItem)
          Positioned(
            top: 55,
            left: 1,
            bottom: 0,
            child: dottedStyleLayout(height: 46),
          ),
      ],
    );
  }

  String _calculateDuration(EmploymentHistories? employmentHistory) {
    if (employmentHistory == null) return "";
    final duration = workingTimeSinceFormString(
      employmentHistory.startDate ?? "",
      employmentHistory.endDate ?? "",
    );
    return duration;
  }

  Widget _buildEmploymentStatus(EmploymentHistories? employmentHistory) {
    if (employmentHistory == null) return const SizedBox.shrink();

    final status = employmentHistory.endDate == null
        ? AppString.textPresent.tr
        : dateMonthYearFormatFromDatetime(employmentHistory.endDate ?? "");

    return Text(
      status,
      style: AppStyle.normal_text_black.copyWith(
        color: status == AppString.textPresent.tr
            ? AppColor.primaryColor
            : AppColor.hintColor,
      ),
    );
  }
}

Widget _verticalDividerWidget(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6.0),
    child: Container(
      width: 1,
      color: AppColor.hintColor,
      height: 16,
    ),
  );
}



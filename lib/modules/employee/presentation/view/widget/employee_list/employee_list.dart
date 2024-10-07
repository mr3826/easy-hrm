import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/modules/employee/presentation/view/widget/employee_list/terminate_widget.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../../common/widget/custom_drawer.dart';
import '../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../common/widget/custom_status_button.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../timeline/view/widget/timeline_calendar.dart';

class EmployeeListInfo extends StatelessWidget {
  final String imgUrlKey;
  final String name;
  final String departmentName;
  final String statusText;
  final Color? statusColor;

  const EmployeeListInfo({
    Key? key,
    required this.imgUrlKey,
    required this.name,
    required this.departmentName,
    required this.statusText,
    this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          CustomNetworkImage(
            imgUrlKey: imgUrlKey,
            errorText: 'ER',
            height: 34,
          ),
          customSpacerWidth(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth / 2,
                child: Text(
                  name,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.secondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.fontSizeDefault + 2,
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth / 2,
                child: Text(
                  departmentName,
                  style: subTextFieldTitleStyle.copyWith(
                    color: AppColor.hintColor,
                  ),
                ),
              ),
              SizedBox(
                height: AppLayout.getHeight(34),
                child: CustomStatusButton(
                  textColor: statusColor ?? AppColor.primaryColor,
                  bgColor:
                      (statusColor ?? AppColor.primaryColor).withOpacity(0.2),
                  text: statusText,
                  textSize: 13,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              customAntButtonSheet(
                context: context,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildHeader(name, departmentName, imgUrlKey),
                    _buildActionItem(AppString.textViewProfile.tr, () {
                      //Get.toNamed(Routes.EMPOLYEE_VIEW_PROFILE);
                    }),
                    _divider(),
                    _buildActionItem(AppString.text_edit.tr, () {}),
                    _divider(),
                    _buildActionItem(AppString.textTerminate.tr, () {
                      _customButtonSheet(
                          child: const TerminateWidget(), context: context);
                    }),
                    _divider(),
                    customSpacerHeight(height: 5),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.more_horiz,
              color: AppColor.hintColor,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }

  void _customButtonSheet({context, child}) {
    return showCustomAtmBtnSheet(
        height: Get.height * .8,
        context: context,
        child: Material(
          color: AppColor.noColor,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radiusMid),
                  topLeft: Radius.circular(Dimensions.radiusMid)),
              color: AppColor.cardColor,
            ),
            child: child,
          ),
        ));
  }

  Widget _divider() {
    return Container(
      width: double.infinity,
      height: 1,
      color: AppColor.normalTextColor.withOpacity(0.1),
    );
  }

  Widget _buildHeader(String name, String department, String imgUrl) {
    final screenHeight = MediaQuery.of(Get.context!).size.height;

    return Container(
      height: screenHeight / 5,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.bgColorWithTimeline,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 4,
              width: 120,
              color: AppColor.backgroundColor,
            ),
          ),
          customSpacerHeight(height: 12),
          CustomNetworkImage(
            imgUrlKey: imgUrl,
            errorText: "ER",
          ),
          customSpacerHeight(height: 12),
          Text(
            name,
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.fontSizeDefault + 2,
            ),
          ),
          Text(
            department,
            style: subTextFieldTitleStyle.copyWith(
              color: AppColor.hintColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(String text, Function onAction) {
    return GestureDetector(
      onTap: () => onAction(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          text,
          style: AppStyle.normal_text_black.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.8),
            fontSize: Dimensions.fontSizeDefault + 1,
          ),
        ),
      ),
    );
  }
}

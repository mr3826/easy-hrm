import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import '../../../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../../../utils/app_color.dart';
import '../../../../../../../../utils/app_string.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import 'leave_allowance/leave_allowance.dart';

class LeaveSummaryWidget extends StatelessWidget {
  const LeaveSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: AppLayout.getHeight(175),
          width: double.infinity,
          child: Card(
            elevation: 0,
            color: AppColor.leaveRecordCardColor,
            shape: roundedRectangleBorder.copyWith(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  customSpacerHeight(height: 12),
                  _buildLeaveDetailsRow(label1: "Allowance: ",value1:  "20",label2:  "Earned: ", value2: "-", label3: "Taken: ",value3:  "6"),
                  customSpacerHeight(height: 8),
                  _buildLeaveDetailsRow(label1: "Approved: ", value1: "6", label2: "Available: ", value2: "14"),
                  customSpacerHeight(height: 8),
                  _buildPendingRequest(),
                ],
              ),
            ),
          ),
        ),
      );
    },);
  }


  // Build header with title and more button
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Self declaration",
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.secondaryColor,
                fontSize: Dimensions.fontSizeDefault,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Sick leave",
              style: AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeSmall + 1,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        IconButton(
          onPressed: () {showAddAllowance();},
          icon: Icon(
            Icons.more_horiz,
            size: 25,
            color: AppColor.normalTextColor.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  // Build a row with multiple subtexts for leave details
  Widget _buildLeaveDetailsRow(
      {required String label1,
      required String value1,
      String? label2,
      String? value2,
      String? label3,
      String? value3}) {
    return Row(
      children: [
        _buildSubText(label: label1, value: value1),
        if (label2 != null) ...[
          customSpacerWidth(width: 20),
          _buildSubText(label: label2, value: value2 ?? "-"),
        ],
        if (label3 != null) ...[
          customSpacerWidth(width: 20),
          _buildSubText(label: label3, value: value3 ?? "-"),
        ],
      ],
    );
  }

  // Build the pending request widget
  Widget _buildPendingRequest() {
    return _buildSubText(
      label: "Pending Req: ",
      widget: Card(
        elevation: 0,
        color: AppColor.pendingColor.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "2",
            style: AppStyle.normal_text.copyWith(color: AppColor.pendingColor),
          ),
        ),
      ),
    );
  }

  // Build a subtext with a label and either dynamic text or a custom widget
  Widget _buildSubText({required String label, String? value, Widget? widget}) {
    return Row(
      children: [
        Text(
          label,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeSmall + 1,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        widget ?? Text(
          value!,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor.withOpacity(0.7),
            fontSize: Dimensions.fontSizeSmall + 1,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
void showAddAllowance() {
  customButtonSheet(
    context: Get.context!,
    child: Column(
      children: [
        _buildHeader(),
        customSpacerHeight(height: 20),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () {
              customButtonSheet(
                context: Get.context!,
                child:  LeaveAllowance(),
                height: 0.7,
              );
            },
            child: Row(
              children: [
                const Icon(Icons.add),
                customSpacerWidth(width: 8),
                Text(
                  AppString.textAddAllowance.tr,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeSmall + 3,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    height: 0.7,
  );
}

Widget _buildHeader() {
  return buildBottomSheetHeader(
    customWidget: Center(
      child: Column(
        children: [
          Text(
            "Self Declaration",
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.fontSizeMid + 1,
            ),
          ),
          Text(
            "Sick Leave",
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor.withOpacity(0.5),
              fontSize: Dimensions.fontSizeSmall + 1,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}


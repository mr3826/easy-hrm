import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/modules/profile/controller/hr_profile_controller.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_layout.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../../modules/leave/domain/leave_type.dart';
import '../../../../controller/leave_allowance_controller.dart';

class LeaveTypeDropDown extends StatefulWidget {
  const LeaveTypeDropDown({super.key});

  @override
  State<LeaveTypeDropDown> createState() => _ApplyLeaveDropDownState();
}

class _ApplyLeaveDropDownState extends State<LeaveTypeDropDown> {
  String? dropDownValue;
  @override
  void initState() {
    super.initState();
    // Get the controller instance
    HrProfileController controller = Get.find<HrProfileController>();
    // Set the default value if available, with null checks
    dropDownValue = (controller.leaveTypeId.isNotEmpty) ? controller.leaveTypeId : null;
  }
HrProfileController controller=Get.find<HrProfileController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(10)),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      child: DropdownButton(
          value: dropDownValue,
          hint: Text(
            AppString.text_select_option.tr,
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault + 1),
          ),
          dropdownColor: AppColor.cardColor,
          icon: const SizedBox.shrink(),
          underline: const SizedBox.shrink(),
          isExpanded: true,
          items: controller
              .leaveTypeDropdown
              ?.getAvailableLeaveTypes!
              .map((e) {
            return DropdownMenuItem(
              value: e.leaveTypeId,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customSpacerWidth(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.name.toString(),
                              style: AppStyle.normal_text_grey
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              e.type.toString(),
                              style: AppStyle.normal_text_grey.copyWith(
                                  color: AppColor.hintColor,
                                  fontSize: Dimensions.fontSizeSmall),
                            ),
                          ],
                        ),
                      ),
                      if (e.leaveTypeId ==
                          controller.leaveTypeId)
                        const Icon(
                          Icons.done,
                          color: AppColor.secondaryColor,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (valueType) {
            setState(() {
              dropDownValue = valueType as String;
              controller.leaveTypeId = valueType;
            });

            GetAvailableLeaveTypes? getLeaveTypesDropdown =
                controller
                    .leaveTypeDropdown
                    ?.getAvailableLeaveTypes
                    ?.firstWhere((element) => element.leaveTypeId == valueType);

            controller.calculateAllowanceBy.value =
                getLeaveTypesDropdown?.calculateAllowanceBy ?? "";
            controller.availableLeave.value =
                getLeaveTypesDropdown?.availableLeave ?? "";
            Get.find<HrProfileController>().leaveStatusId = getLeaveTypesDropdown?.leaveStatusId ?? "";
            Get.find<LeaveAllowanceController>().daysCount.value = int.parse(getLeaveTypesDropdown?.availableLeave ?? "");
          }),
    );
  }
}

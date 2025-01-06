import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import '../../../../../app/admin_app/leave_hr/presentation/view/widget/assign_leave/leave_type.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';
import '../../controller/apply_leave_controller.dart';
import '../../../domain/leave_type.dart';

class ApplyLeaveDropDown extends StatefulWidget {
  const ApplyLeaveDropDown({super.key});

  @override
  State<ApplyLeaveDropDown> createState() => _ApplyLeaveDropDownState();
}

class _ApplyLeaveDropDownState extends State<ApplyLeaveDropDown> {
  String? dropDownValue;

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
            AppString.text_select_on_option.tr,
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault + 1),
          ),
          dropdownColor: AppColor.cardColor,
          underline: const SizedBox.shrink(),
          isExpanded: true,
          items: Get.find<ApplyLeaveController>()
              .leaveTypeDropdown
              ?.getAvailableLeaveTypes!
              .map((e) {
            return DropdownMenuItem(
              value: e.leaveTypeId,
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getIconAccordingToLeaveType(e.name),
                    customSpacerWidth(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.name.toString(),
                            style: AppStyle.normal_text_grey.copyWith(color: Colors.black),
                          ),
                          Text(
                            e.type.toString(),
                            style:  AppStyle.normal_text_grey.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeSmall),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (valueType) {
            setState(() {
              dropDownValue = valueType as String;
              Get.find<ApplyLeaveController>().isSelectLeaveType.value =
                  valueType;
            });
            GetAvailableLeaveTypes? getLeaveTypesDropdown =
                Get.find<ApplyLeaveController>()
                    .leaveTypeDropdown
                    ?.getAvailableLeaveTypes
                    ?.firstWhere((element) => element.leaveTypeId == valueType);
            Get.find<ApplyLeaveController>().numberOfLeaves.value =
                getLeaveTypesDropdown?.availableLeave ?? "0";
            Get.find<ApplyLeaveController>().calculateAllowanceOfLeave.value =
                getLeaveTypesDropdown?.calculateAllowanceBy ?? "";
            Get.find<ApplyLeaveController>().leaveId = valueType!;
            Get.find<ApplyLeaveController>().isDocumentRequired.value =
                getLeaveTypesDropdown?.attachDocumentRequired ?? false;
            Get.find<ApplyLeaveController>().isNoteRequired.value =
                getLeaveTypesDropdown?.addNoteRequired ?? false;
          }),
    );
  }
}



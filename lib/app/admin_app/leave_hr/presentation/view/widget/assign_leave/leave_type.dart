import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import '../../../../../../../modules/leave/domain/leave_type.dart';
import '../../../../../../../modules/leave/presentation/controller/apply_leave_controller.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_layout.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../../utils/images.dart';


class LeaveTypeDropDown extends StatefulWidget {
  const LeaveTypeDropDown({super.key});

  @override
  State<LeaveTypeDropDown> createState() => _LeaveTypeDropDownState();
}

class _LeaveTypeDropDownState extends State<LeaveTypeDropDown> {
  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    Get.put(ApplyLeaveController());
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

getIconAccordingToLeaveType(String? leaveName) {
  switch (leaveName) {
    case "Vacationing":
      return customSvgImage(imageUrl: Images.leaveImage7);
    case "Paternity":
      return customSvgImage(imageUrl: Images.leaveImage6);
    case "Maternity":
      return customSvgImage(imageUrl: Images.leaveImage5);
    case "School closed":
      return customSvgImage(imageUrl: Images.leaveImage4);
    case "Children-minder illness":
      return customSvgImage(imageUrl: Images.leaveImage3);
    case "Children illness":
      return customSvgImage(imageUrl: Images.leaveImage2);
    case "Doctor declaration":
      return customSvgImage(imageUrl: Images.leaveImage1);
    case "Self declaration":
      return customSvgImage(imageUrl: Images.leaveImage);
    default:
      return customSvgImage(imageUrl: Images.leaveImage8);
  }
}

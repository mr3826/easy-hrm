import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_layout.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../../utils/images.dart';
import '../../../controller/hr_leave_controller.dart';
import '../../../model/avaible_leave_type.dart'as type;

class LeaveTypeDropDown extends StatefulWidget {
  const LeaveTypeDropDown({super.key});

  @override
  State<LeaveTypeDropDown> createState() => _LeaveTypeDropDownState();
}

class _LeaveTypeDropDownState extends State<LeaveTypeDropDown> {
  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
   HrLeaveController controller= Get.find<HrLeaveController>();
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
          items: controller.availableLeaveType?.getAvailableLeaveTypes!
              .map((e) {
            return DropdownMenuItem(
              value: e.leaveTypeId,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "${e.name.toString()} (${e.availableLeave.toString()})",
                    style: AppStyle.normal_text_black.copyWith(color: AppColor.normalTextColor),
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (valueType) {
            setState(() {
              dropDownValue = valueType as String;
            });

          type.GetAvailableLeaveTypes? getAvailableLeaveTypes= controller.availableLeaveType?.getAvailableLeaveTypes?.firstWhere((e)=>e.leaveTypeId==valueType.toString());
             Get.find<HrLeaveController>().calculateAllowanceOfLeave.value =
                 getAvailableLeaveTypes?.availableLeave ?? "0";
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

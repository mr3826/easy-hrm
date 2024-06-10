import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/leave/model/leave_type.dart';
import 'package:payrun_mobile/modules/leave/model/leave_type_drop_down.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/images.dart';
import '../../controller/apply_leave_controller.dart';

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
              .leaveTypeDropdownModel?.getAvailableLeaveTypes!
              .map((e) {
            return DropdownMenuItem(
              value: e.leaveTypeId,
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getIconAccordingToLeaveType(e.type),
                    customSpacerWidth(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.name.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text(
                            e.type.toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColor.hintColor,
                                overflow: TextOverflow.ellipsis),
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
            });
            GetAvailableLeaveTypes? getLeaveTypesDropdown =
                Get.find<ApplyLeaveController>()
                    .leaveTypeDropdownModel
                    ?.getAvailableLeaveTypes
                    ?.firstWhere((element) => element.leaveTypeId == valueType);

            //  //set data according to leave type
          //   Get.find<ApplyLeaveController>().numberOfLeaves.value =
                 //getLeaveDaysAccordingToLeave(getLeaveTypesDropdown: getLeaveTypesDropdown) ?? "";

            Get.find<ApplyLeaveController>().numberOfLeaves.value = getLeaveTypesDropdown?.availableLeave??"0"  ;
            Get.find<ApplyLeaveController>().calculateAllowanceOfLeave.value = getLeaveTypesDropdown?.calculateAllowanceBy??""  ;



            Get.find<ApplyLeaveController>().leaveId = valueType!;
            Get.find<ApplyLeaveController>().isDocumentRequired.value =
                getLeaveTypesDropdown?.attachDocumentRequired ?? false;
            Get.find<ApplyLeaveController>().isNoteRequired.value =
                getLeaveTypesDropdown?.addNoteRequired ?? false;


          }),
    );
  }
}

getIconAccordingToLeaveType(String? type) {
  switch (type) {
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

String? getLeaveDaysAccordingToLeave(
    {required GetLeaveTypesDropdown getLeaveTypesDropdown}) {
  if (getLeaveTypesDropdown.isEarned == true) {
    return (getLeaveTypesDropdown.leaveStatuses?.first.earnedDays ?? 0)
        .toString();
  } else {
    if (getLeaveTypesDropdown.calculateAllowanceBy == "no_of_application") {
      return (getLeaveTypesDropdown
                  .leaveStatuses?.first.availableNumberOfApplications ??
              0)
          .toString();
    } else {
      return (getLeaveTypesDropdown
                  .leaveStatuses?.first.availableNumberOfDays ??
              0)
          .toString();
    }
  }
}

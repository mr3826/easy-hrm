import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/profile/controller/employment_controller.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_layout.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../../utils/images.dart';
import '../../../../../../leave/domain/leave_type.dart';


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
    UserProfileController controller = Get.find<UserProfileController>();
    // Set the default value if available, with null checks
    dropDownValue = (controller.leaveTypeId.isNotEmpty)
        ? controller.leaveTypeId
        : null;
  }


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
          underline: const SizedBox.shrink(),
          isExpanded: true,
          items: Get.find<UserProfileController>().leaveTypeDropdown?.getAvailableLeaveTypes!.map((e) {
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
              Get.find<UserProfileController>().leaveTypeId =
                  valueType;
            });


            GetAvailableLeaveTypes? getLeaveTypesDropdown =

            Get.find<UserProfileController>()
                .leaveTypeDropdown
                ?.getAvailableLeaveTypes
                ?.firstWhere((element) => element.leaveTypeId == valueType);

            Get.find<UserProfileController>().calculateAllowanceBy.value=getLeaveTypesDropdown?.calculateAllowanceBy??"";
            Get.find<UserProfileController>().availableLeave.value=getLeaveTypesDropdown?.availableLeave??"";

           // employmentController.daysCount

            Get.find<EmploymentController>().daysCount.value=int.parse(getLeaveTypesDropdown?.availableLeave??"");


            print('''
            ${getLeaveTypesDropdown?.calculateAllowanceBy??""}
            ${getLeaveTypesDropdown?.type??""}
            ${getLeaveTypesDropdown?.name??""}  
            
              ${getLeaveTypesDropdown?.availableLeave??""}
         
            
            
            
            
            
            ''');




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

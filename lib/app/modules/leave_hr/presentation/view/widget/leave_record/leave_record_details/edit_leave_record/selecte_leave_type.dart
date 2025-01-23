import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../../../../utils/app_color.dart';
import '../../../../../../../../../utils/app_layout.dart';
import '../../../../../../../../../utils/app_style.dart';
import '../../../../../../../../../utils/dimensions.dart';
import '../../../../../../../../../utils/images.dart';

class SelectedLeaveType extends StatefulWidget {
  const SelectedLeaveType({super.key});

  @override
  State<SelectedLeaveType> createState() => _SelectedLeaveTypeState();
}

class _SelectedLeaveTypeState extends State<SelectedLeaveType> {
  String? dropDownValue;

  // Static list of leave types
  final List<Map<String, String>> leaveTypes = [
    {"leaveTypeId": "1", "name": "Vacationing", "type": "Paid Leave"},
    {"leaveTypeId": "2", "name": "Paternity", "type": "Paid Leave"},
    {"leaveTypeId": "3", "name": "Maternity", "type": "Paid Leave"},
    {"leaveTypeId": "4", "name": "School closed", "type": "Unpaid Leave"},
    {
      "leaveTypeId": "5",
      "name": "Children-minder illness",
      "type": "Paid Leave"
    },
    {"leaveTypeId": "6", "name": "Children illness", "type": "Paid Leave"},
    {"leaveTypeId": "7", "name": "Doctor declaration", "type": "Sick Leave"},
    {"leaveTypeId": "8", "name": "Self declaration", "type": "Sick Leave"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: AppLayout.getWidth(10), vertical: 2),
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
          icon: const Icon(Icons.expand_more),
          items: leaveTypes.map((leaveType) {
            return DropdownMenuItem(
              value: leaveType['leaveTypeId'],
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getIconAccordingToLeaveType(leaveType['name']),
                    customSpacerWidth(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            leaveType['name'].toString(),
                            style: AppStyle.normal_text_grey
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            leaveType['type'].toString(),
                            style: AppStyle.normal_text_grey.copyWith(
                                color: AppColor.hintColor,
                                fontSize: Dimensions.fontSizeSmall),
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
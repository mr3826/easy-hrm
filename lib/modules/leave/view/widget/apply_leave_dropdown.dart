import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/leave/model/leave_type.dart';

import '../../../../common/controller/date_time_controller.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
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
          hint: Text(AppString.text_select_on_option.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault+1),),
          dropdownColor: AppColor.cardColor,
          underline: const SizedBox.shrink(),
          isExpanded: true,
          items: Get.find<ApplyLeaveController>()
              .leaveTypeDropdown!
              .getLeaveTypesDropdown!
              .map((e) {
            return DropdownMenuItem(
              value: e.id,
              child: Text(e.name.toString().toUpperCase()),
            );
          }).toList(),
          onChanged: (value) {
            print("value::: $value");
            setState(() {
              dropDownValue = value as String;
            });
            GetLeaveTypesDropdown? getLeaveTypesDropdown =
            Get.find<ApplyLeaveController>()
                .leaveTypeDropdown
                ?.getLeaveTypesDropdown
                ?.firstWhere((element) => element.id == value);

            //set data according to leave type
            Get.find<DateTimeController>().numberOfLeaves.value =
                getLeaveTypesDropdown?.leaveStatuses?[0].availableNumberOfDays
                    .toString() ??
                    "";
            Get.find<DateTimeController>().leaveId?.value == value;
            Get.find<DateTimeController>().isDocumentRequired.value =
                getLeaveTypesDropdown?.attachDocumentRequired ?? false;
            Get.find<DateTimeController>().isNoteRequired.value =
                getLeaveTypesDropdown?.addNoteRequired ?? false;
          }),
    );
  }
}

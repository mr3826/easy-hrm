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
      child: DropdownButton<String>(
        style: const TextStyle(fontWeight: FontWeight.w500),
        isExpanded: true,
        dropdownColor: AppColor.cardColor,
        underline: const SizedBox.shrink(),
        icon: const Icon(Icons.expand_more, color: Colors.grey),
        iconEnabledColor: AppColor.normalTextColor,
        hint: Row(
          children: [
            Text(
              AppString.text_slected_an_option.tr,
              style: AppStyle.normal_text.copyWith(color: AppColor.hintColor),
            )
          ],
        ),
        value: dropDownValue,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        items: Get.find<ApplyLeaveController>()
            .leaveType
            ?.map<DropdownMenuItem<String>>((String? value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value ?? "",
                style: AppStyle.normal_text
                    .copyWith(color: AppColor.normalTextColor),
              ));
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropDownValue = newValue;
            GetLeaveTypesDropdown? getLeaveTypesDropdown =
                Get.find<ApplyLeaveController>()
                    .leaveTypeDropdown
                    ?.getLeaveTypesDropdown
                    ?.firstWhere((element) => element.name == newValue);

            //set data according to leave type
            Get.find<DateTimeController>().numberOfLeaves.value =
                getLeaveTypesDropdown?.leaveStatuses?[0].availableNumberOfDays
                        .toString() ??
                    "";
            Get.find<DateTimeController>().leaveId?.value =
                getLeaveTypesDropdown?.id ?? "";
            Get.find<DateTimeController>().isDocumentRequired.value =
                getLeaveTypesDropdown?.attachDocumentRequired ?? false;
            Get.find<DateTimeController>().isNoteRequired.value =
                getLeaveTypesDropdown?.addNoteRequired ?? false;
          });
        },
      ),
    );
  }
}

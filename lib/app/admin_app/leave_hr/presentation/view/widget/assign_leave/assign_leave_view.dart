import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../../common/widget/custom_button_sheet_appbar.dart';
import '../../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../../common/widget/custom_network_image.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../modules/leave/presentation/view/widget/custom_title_text_widget.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../employee/presentation/view/widget/serach_employee_list/search_employee_list.dart';
import '../../../controller/hr_leave_controller.dart';
import '../../../controller/leave_controller.dart';
import 'assign_leave.dart';
import 'leave_type.dart';


class AssignLeaveView extends StatelessWidget {
  const AssignLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaveController controller = Get.put(LeaveController());

    return Column(
      children: [
        _buildBottomSheetHeader(),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTitleText(AppString.textEmployees.tr),
                  const SizedBox(height: 6),


                  Obx(
                        () => _buildSearchBar(context, onSearch: () {
                      showEmployeeSelectionSheet();
                    }),
                  ),


                  const SizedBox(height: 18),
                  _buildTitleText(AppString.textLeaveTimeline.tr),
                  const SizedBox(height: 6),
                  _buildDropdownField(
                    items: controller.items,
                    value: controller.selectAssignLeave.value,
                    onChanged: (value) =>
                    controller.selectAssignLeave.value = value ?? '',
                  ),
                  const SizedBox(height: 18),

                  customTitleText(
                      text: AppString.text_leave_name.tr, isRequired: true),
                  customSpacerHeight(height: 8),
                  const LeaveTypeDropDown(),


                //  _buildSearchEmployeeField(),
                  // const SizedBox(height: 18),
                  // _buildTitleText(AppString.textLeaveTimeline.tr),
                  // const SizedBox(height: 6),
                  // _buildDropdownField(
                  //   items: controller.items,
                  //   value: controller.selectAssignLeave.value,
                  //   onChanged: (value) =>
                  //   controller.selectAssignLeave.value = value ?? '',
                  // ),
                  // const SizedBox(height: 18),
                  // _buildTitleText(AppString.textLeaveType.tr),
                  // const SizedBox(height: 6),
                  // _buildLeaveTypeGrid(data),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}





// Search bar method renamed and optimized
Widget _buildSearchBar(BuildContext context, {required Function onSearch}) {
  HrLeaveController controller = Get.put(HrLeaveController());

  return GestureDetector(
    onTap: () => onSearch(),
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: SizedBox(
        height: 52,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 0,
          color: AppColor.cardColor,
          shape: roundedRectangleBorder.copyWith(
            side: BorderSide(
              color: AppColor.hintColor.withOpacity(0.3),
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(Dimensions.fontSizeMid + 2),
          ),
          child: Row(
            children: [
              customSpacerWidth(width: 12),
              const Icon(CupertinoIcons.search,
                  color: AppColor.hintColor, size: 25),
              customSpacerWidth(width: 8),
              if (controller.selectedEmployeeImgKey.isNotEmpty) ...[
                CustomNetworkImage(
                  imgUrlKey: controller.selectedEmployeeImgKey.value,
                  errorText: "Er",
                  height: 12,
                  borderColor: Colors.transparent,
                  errorTextStyle: AppStyle.normal_text_black
                      .copyWith(fontSize: 14, color: AppColor.secondaryColor),
                ),
                customSpacerWidth(width: 6),
              ],
              Expanded(
                child: Text(
                  controller.selectedEmployeeInfo.value,
                  maxLines: 1,
                  style: AppStyle.normal_text_black.copyWith(
                      fontSize: Dimensions.fontSizeMid - 3,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              if (controller.selectedEmployeeInfo.value !=
                  AppString.textSearchEmployee)
                InkWell(
                  onTap: () {
                    controller.selectedEmployeeInfo.value =
                        AppString.textSearchEmployee.tr;
                    controller.selectedEmployeeImgKey.value = "";
                    controller.getLeaveRecord();
                  },
                  child: const Icon(CupertinoIcons.clear,
                      color: AppColor.hintColor, size: 23),
                ),
              customSpacerWidth(width: 12),
            ],
          ),
        ),
      ),
    ),
  );
}



void showEmployeeSelectionSheet() {
  HrLeaveController controller = Get.put(HrLeaveController());
  LeaveController leaveController = Get.put(LeaveController());
  customButtonSheet(
    context: Get.context!,
    child: SearchEmployeeList(
      onValueSelected: (value) {
        leaveController.tabLength.value = 1;
        controller.getLeaveRecord(assignedLeaveId: value);
        Get.back(canPop: false);
        print("value ::: $value");
      },
      userInfo: (name) {
       // controller.selectedEmployeeInfo.value = name.name ?? "";
       // controller.selectedEmployeeImgKey.value = name.imgUrl ?? "";
      },
      onClickRouteAction: () {},
    ),
    height: 0.8,
  );
}





/// Builds a dropdown field for selecting options (Leave Type, Timeline, etc.).
Widget _buildDropdownField({
  required List<String> items,
  String? value,
  ValueChanged<String?>? onChanged,
}) {
  return DropdownButtonFormField2(
    value: value?.isNotEmpty == true ? value : null,
    decoration: buildDropdownDecoration(),
    isExpanded: true,
    hint: Text("Select an option",
        style:
        AppStyle.normal_text_grey.copyWith(fontWeight: FontWeight.w500)),
    items: items
        .map((item) => DropdownMenuItem<String>(
      value: item,
      child: Text(item,
          style: AppStyle.normal_text_black
              .copyWith(fontSize: Dimensions.fontSizeDefault + 2)),
    ))
        .toList(),
    onChanged: onChanged,
  );
}




/// Builds the bottom sheet header widget with a given title.
Widget _buildBottomSheetHeader() {
  return buildBottomSheetHeader(text: AppString.textAssignLeave.tr);
}

/// Builds a title text widget with the provided text.
Widget _buildTitleText(String text) {
  return customTitleText(text: text, isRequired: true);
}





























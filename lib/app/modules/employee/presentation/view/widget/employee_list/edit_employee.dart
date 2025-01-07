import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import '../../../../../../../common/widget/custom_app_button.dart';
import '../../../../../../../common/widget/custom_inside_appbar.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/custom_text_field.dart';
import '../../../../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../../modules/auth/view/screens/otp_screen.dart';
import '../../../../domain/user_work_info_dropdown.dart';
import '../../../controller/employment_controller.dart';

class EditEmployee extends GetView<EmploymentController> {
  const EditEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customInsideAppbar(
        title: AppString.textEditEmployee.tr,
        onPressAction: () => Get.back(),
      ),
      body: controller.obx((state) => _body(context),
          onLoading: const LoadingIndicator()),
    );
  }

  Widget _buildDropdownField({
    required String title,
    required String hint,
    required List<DropdownItem> items,
    required String initValue,
    bool isRequired = false,
    ValueChanged<String?>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText(text: title, isRequired: isRequired),
        customSpacerHeight(height: 8),



        DropdownButtonFormField2(
          value: initValue.isNotEmpty ? initValue : null,
          decoration: _buildDropdownDecoration(),
          isExpanded: true,
          hint: Text(
            hint,
            style:
                AppStyle.normal_text_grey.copyWith(fontWeight: FontWeight.w500),
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item.id,
                    child: Text(item.name, style: AppStyle.normal_text_black),
                  ))
              .toList(),
          onChanged: onChanged,
        ),





      ],
    );
  }

  Widget _userTextField(String titleText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText(text: titleText, isRequired: true),
        customSpacerHeight(height: 12),
        CustomInputField(
          hint: titleText,
          hintStyle:
              AppStyle.normal_text_grey.copyWith(fontWeight: FontWeight.w500),
          controller: controller,
        ),
        customSpacerHeight(height: 12),
      ],
    );
  }

  Widget _buildJoiningDate(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //CustomCalendarPicker(isRangeSelectionEnabled: false, weekendDays: Get.find<LeaveScreenController>().holidays, holidayDates: const [])
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColor.hintColor.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              final dateTime =
                  Get.find<DateTimePickerController>().outDateTime.value;
              final parsedDate = DateTime.tryParse(dateTime) ?? DateTime.now();
              final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
              return Text(formattedDate,
                  style: const TextStyle(color: Colors.black, fontSize: 16));
            }),
            const Icon(CupertinoIcons.calendar, color: Colors.grey, size: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleText({required String text, bool isRequired = false}) {
    return Row(
      children: [
        Text(
          text,
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor,
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.fontSizeDefault + 2),
        ),
        customSpacerWidth(width: 4),
        if (isRequired)
          Text(
            "*",
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.errorColor,
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.fontSizeDefault + 1),
          ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 45,
            child: CustomAppButton(
              isButtonExpanded: false,
              buttonText: Text(
                AppString.text_cancel.tr,
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault + 2,
                ),
              ),
              onPressed: () => Get.back(),
              buttonColor: AppColor.cardColor,
              borderColor: AppColor.hintColor.withOpacity(0.5),
            ),
          ),
        ),
        customSpacerWidth(width: 14),
        Expanded(
          child: SizedBox(
            height: 45,
            child: CustomAppButton(
              isButtonExpanded: false,
              buttonText: Text(
                AppString.text_save.tr,
                style: AppStyle.normal_text.copyWith(
                  color: AppColor.cardColor,
                  fontSize: Dimensions.fontSizeDefault + 2,
                ),
              ),
              onPressed: controller.hasChangedProfileInfo.isFalse
                  ? () {}
                  : () {},
              buttonColor: controller.hasChangedProfileInfo.isFalse
                  ? AppColor.primaryColor.withOpacity(.5)
                  : AppColor.primaryColor,
              borderColor: controller.hasChangedProfileInfo.isFalse
                  ? AppColor.primaryColor.withOpacity(.5)
                  : AppColor.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _buildDropdownDecoration() {
    return InputDecoration(
      isDense: true,
      disabledBorder: _outlineInputBorder,
      enabledBorder: _outlineInputBorder,
      focusedBorder: _outlineInputBorder,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    );
  }

  OutlineInputBorder get _outlineInputBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: AppColor.hintColor, width: 1),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: marginLayout,
      child: SingleChildScrollView(
        child: Column(
          children: [
            customSpacerHeight(height: 12),
            _userTextField(AppString.text_first_name.tr,
                controller.editFirstNameController),
            _userTextField(
                AppString.text_last_name.tr, controller.editLastNameController),
            _buildDropdownField(
                title: AppString.textEmployeeStatus.tr,
                isRequired: true,
                hint: 'Select status',
                items: controller.employmentStatuses?.statuses ?? [],
                initValue: controller.initEmploymentStatusId ?? "",
                onChanged: (value) {}),
            customSpacerHeight(height: 12),
            _buildDropdownField(
                title: AppString.text_designation.tr,
                hint: 'Select designation',
                items: controller.designations?.designations ?? [],
                initValue: controller.initDesignationId ?? "",
                onChanged: (value) {}),
            customSpacerHeight(height: 12),
            _buildDropdownField(
                title: AppString.text_deparmtnet.tr,
                isRequired: true,
                hint: 'Select department',
                items: controller.departments?.departments ?? [],
                initValue: controller.initDepartmentId ?? '',
                onChanged: (value) {}),
            customSpacerHeight(height: 12),
            _buildTitleText(
                text: AppString.textJoiningDate.tr, isRequired: true),
            customSpacerHeight(height: 8),
            _buildJoiningDate(context),
            customSpacerHeight(height: 28),
            Obx(
              () => _buildButtons(),
            ),
          ],
        ),
      ),
    );
  }
}

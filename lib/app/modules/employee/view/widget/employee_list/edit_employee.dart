import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:payrun_mobile/app/global/view/widgets/custom_phone_number_input_field.dart';
import 'package:payrun_mobile/app/modules/employee/controller/update_org_user_info_controller.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../../../../common/widget/custom_app_button.dart';
import '../../../../../../../common/widget/custom_inside_appbar.dart';
import '../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../common/widget/custom_text_field.dart';
import '../../../../../global/view/widget/app_margin.dart';
import '../../../../../global/view/widgets/custom_date_picker.dart';
import '../../../../../../../utils/app_string.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../auth/view/screens/otp_screen.dart';
import '../../../controller/employment_controller.dart';
import '../../../model/user_work_info_dropdown.dart';

class EditEmployee extends GetView<UpdateOrgUserInfoController> {
  EditEmployee({super.key});

  String orgUserId = '';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        Get.arguments as Map<String, dynamic>;

    orgUserId = arguments['orgUserId'];

    Get.find<UpdateOrgUserInfoController>()
        .getUpdateAbleUserInfo(orgUserId: orgUserId);
    return Scaffold(
        appBar: customInsideAppbar(
            title: AppString.textEditEmployee.tr,
            onPressAction: () {
              Get.back();
              Get.back();
            }),
        body: controller.obx((state) => _body(context),
            onLoading: const LoadingIndicator()));
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: marginLayout,
      child: SingleChildScrollView(
        child: Column(
          children: [
            customSpacerHeight(height: 12),
            _userTextField(AppString.text_first_name.tr,
                controller.editFirstNameController, true),
            _userTextField(AppString.text_last_name.tr,
                controller.editLastNameController, false),
            _userTextField(AppString.text_employee_Id.tr,
                controller.editEmployeeIdController, false),
            _buildDropdownField(
                title: AppString.textEmployeeStatus.tr,
                isRequired: true,
                hint: 'Select status',
                items: Get.find<EmploymentController>()
                        .employmentStatuses
                        ?.statuses ??
                    [],
                initValue:
                    controller.getOrganizationUserDetails.employmentStatus.id,
                onChanged: (value) {
                  if (value !=
                      controller
                          .getOrganizationUserDetails.employmentStatus.id) {
                    controller.employeeStatusId = value!;
                  } else {
                    controller.employeeStatusId = '';
                  }
                  controller.checkForChanges();
                }),
            customSpacerHeight(height: 12),
            _buildDropdownField(
              title: AppString.text_designation.tr,
              hint: 'Select designation',
              items:
                  Get.find<EmploymentController>().designations?.designations ??
                      [],
              initValue: controller.getOrganizationUserDetails.designation.id,
              onChanged: (value) {
                if (value !=
                    controller.getOrganizationUserDetails.designation.id) {
                  controller.employeeDesignationId = value!;
                } else {
                  controller.employeeDesignationId = '';
                }
                controller.checkForChanges();
              },
            ),
            customSpacerHeight(height: 12),
            _buildDropdownField(
              title: AppString.text_deparmtnet.tr,
              isRequired: true,
              hint: 'Select department',
              items:
                  Get.find<EmploymentController>().departments?.departments ??
                      [],
              initValue: controller.getOrganizationUserDetails.department.id,
              onChanged: (value) {
                if (value !=
                    controller.getOrganizationUserDetails.department.id) {
                  controller.employeeDepartmentId = value!;
                } else {
                  controller.employeeDepartmentId = '';
                }
                controller.checkForChanges();
              },
            ),
            customSpacerHeight(height: 12),
            _buildTitleText(
                text: AppString.textJoiningDate.tr, isRequired: true),
            customSpacerHeight(height: 8),
            _buildJoiningDate(context),
            customSpacerHeight(height: 8),
            _personalPhoneNumberInput(),
            customSpacerHeight(height: 8),
            _emergencyPhoneNumberInput(),
            customSpacerHeight(height: 28),
            Obx(
              () => controller.isUpdateDataLoading.isTrue
                  ? const Center(
                      child: CupertinoActivityIndicator(
                          color: AppColor.primaryColor, radius: 14))
                  : _buildButtons(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userTextField(
      String titleText, TextEditingController controller, bool isRequired) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText(text: titleText, isRequired: isRequired),
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

  Widget _buildJoiningDate(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final weekendDays = [DateTime.saturday, DateTime.sunday];

        final selectedRange = await showDialog<Map<String, DateTime?>>(
          context: context,
          builder: (BuildContext context) => CustomCalendarPicker(
              isRangeSelectionEnabled: false, weekendDays: weekendDays),
        );
        if (selectedRange != null) {
          controller.employeeJoiningDate.value = formatDate(
              date: selectedRange['start'].toString(), format: "yyyy-MM-dd");
          controller.checkForChanges();
        }
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
            Obx(
              () => Text(
                  formatDate(
                      date: controller.employeeJoiningDate.value,
                      format: "yyyy-MM-dd"),
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            ),
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

  Widget _buildButtons(BuildContext context) {
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
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
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
              onPressed: Get.find<UpdateOrgUserInfoController>()
                      .isUpdateDataChanged
                      .isFalse
                  ? () {}
                  : () async {
                      bool value = await Get.find<UpdateOrgUserInfoController>()
                          .updateAOrgUserInfo(orgUserId: orgUserId);
                      if (value) {
                        if (context.mounted) {
                          showSuccessMessage(
                              message: AppString
                                  .profile_update_successfully_text.tr);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      } else {
                        showErrorMessage(message: AppString.error_text.tr);
                      }
                    },
              buttonColor: Get.find<UpdateOrgUserInfoController>()
                      .isUpdateDataChanged
                      .isFalse
                  ? AppColor.primaryColor.withOpacity(.5)
                  : AppColor.primaryColor,
              borderColor: Get.find<UpdateOrgUserInfoController>()
                      .isUpdateDataChanged
                      .isFalse
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
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
    );
  }

  OutlineInputBorder get _outlineInputBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(color: AppColor.hintColor, width: 1),
    );
  }

  _personalPhoneNumberInput() {
    return Column(
      children: [
        _buildTitleText(text: AppString.text_personal_number.tr),
        customSpacerHeight(height: 8),
        CustomPhoneNumberInputField(
            onInputChanged: (PhoneNumber phoneNumber) {
              controller.changedPersonalNumber = phoneNumber.phoneNumber ?? '';
              controller.checkForChanges();
            },
            initPhoneNumberValue: controller.employeePersonalPhoneNumber)
      ],
    );
  }

  _emergencyPhoneNumberInput() {
    return Column(
      children: [
        _buildTitleText(text: AppString.text_emergency_number.tr),
        customSpacerHeight(height: 8),
        CustomPhoneNumberInputField(
          onInputChanged: (PhoneNumber phoneNumber) {
            controller.changedEmergencyNumber = phoneNumber.phoneNumber ?? '';
            controller.checkForChanges();
          },
          initPhoneNumberValue: controller.employeeEmergencyPhoneNumber,
        )
      ],
    );
  }
}

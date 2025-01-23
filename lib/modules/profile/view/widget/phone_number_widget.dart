import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../app/modules/leave_hr/presentation/view/widget/assign_leave/assign_leave.dart';
import '../../controller/update_profile_controller.dart';

class PersonalPhoneNumber extends StatefulWidget {
  const PersonalPhoneNumber({super.key});

  @override
  State<PersonalPhoneNumber> createState() => _PersonalPhoneNumberState();
}

class _PersonalPhoneNumberState extends State<PersonalPhoneNumber> {
  PhoneNumber number =
      PhoneNumber(isoCode: 'NO', phoneNumber: editPhoneController.text);

  @override
  void initState() {
    super.initState();
    getPhoneNumber(editPhoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        print("onInputChanged:: ${number.phoneNumber}");
        Get.find<UpdateProfileController>().initialPersonalPhoneNumber.value =
            number.phoneNumber.toString();
      },
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DIALOG,
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 12,
      ),
      inputBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      ignoreBlank: true,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      formatInput: false,
      inputDecoration: InputDecoration(
        hintText: 'Enter phone number',
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        hintStyle: AppStyle.normal_text.copyWith(color: AppColor.hintColor),
        disabledBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
      ),
      initialValue: number,
      textFieldController: editPhoneController,
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');
    setState(() {
      this.number = number;
    });
  }
}

class EmergencyPhoneNumber extends StatefulWidget {
  const EmergencyPhoneNumber({super.key});

  @override
  State<EmergencyPhoneNumber> createState() => _EmergencyPhoneNumberState();
}

class _EmergencyPhoneNumberState extends State<EmergencyPhoneNumber> {
  PhoneNumber number = PhoneNumber(
      isoCode: 'NO', phoneNumber: editEmergencyPhoneController.text);

  @override
  void initState() {
    super.initState();
    getPhoneNumber(editEmergencyPhoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        print("onInputChanged:: ${number.phoneNumber}");
        Get.find<UpdateProfileController>().initialEmergencyPhoneNumber.value =
            number.phoneNumber.toString();
      },
      onInputValidated: (bool value) {
        print(value);
      },
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.DIALOG,
        setSelectorButtonAsPrefixIcon: true,
        leadingPadding: 12,
      ),
      inputBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      ignoreBlank: true,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      formatInput: false,
      inputDecoration: InputDecoration(
        hintText: 'Not added yet',
        hintStyle: AppStyle.normal_text.copyWith(color: AppColor.hintColor),
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        disabledBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
      ),
      initialValue: number,
      textFieldController: editEmergencyPhoneController,
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'NO');
    setState(() {
      this.number = number;
    });
  }
}

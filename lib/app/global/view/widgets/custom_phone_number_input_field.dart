import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../utils/input_decoration_helper.dart';

class CustomPhoneNumberInputField extends StatelessWidget {
  final Function(PhoneNumber) onInputChanged;
  final PhoneNumber? initPhoneNumberValue;

  const CustomPhoneNumberInputField(
      {super.key, required this.onInputChanged, this.initPhoneNumberValue});

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: onInputChanged,
      selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          setSelectorButtonAsPrefixIcon: true,
          useBottomSheetSafeArea: true,
          trailingSpace: false,
          leadingPadding: 8),
      autoValidateMode: AutovalidateMode.onUserInteraction,
      inputDecoration: InputDecorationHelper.commonInputDecoration(),
      initialValue: initPhoneNumberValue ?? PhoneNumber(isoCode: 'NO'),
    );
  }
}

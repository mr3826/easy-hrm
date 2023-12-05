import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

Widget taskInputFieldLayout(
    {required TextEditingController controller,
    hint,
    suffixIcon,
    required onAction}) {
  return SizedBox(
    height: AppLayout.getHeight(55),
    child: TextFormField(
      controller: controller,
      style: subTextFieldTitleStyle,
      autofocus: false,
      readOnly: true,
      onTap: () => onAction(),
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
            color: AppColor.hintColor,
            fontFamily: "Poppins",
            fontSize: Dimensions.fontSizeDefault + 1),
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0, color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
        ),
        focusColor: AppColor.primaryColor,
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.hintColor,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.hintColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
      ),
    ),
  );
}

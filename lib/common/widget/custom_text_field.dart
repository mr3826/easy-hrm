import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInputField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? weight;
  final Function? onAction;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool? isObscureText;
  final TextStyle ?hintStyle;
  final TextInputType? textInputType;

  const CustomInputField(
      {super.key,
      required this.hint,
      this.controller,
      this.weight,
      this.textInputType,
      this.hintStyle,
      this.prefixWidget,
      this.validator,
      this.prefixIcon,
      this.onChanged,
      this.onAction,
      this.isObscureText});

  @override
  Widget build(BuildContext context) {
    final focusedCtx = FocusManager.instance.primaryFocus?.context;
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => Scrollable.ensureVisible(
              focusedCtx ?? context,
              duration: const Duration(milliseconds: 100),
              curve: Curves.bounceInOut,
            ));
    return prefixWidget != null
        ? _textFieldLayout(context)
        : prefixIcon != null
            ? _textFieldLayout(context)
            : _noPrefixIconField();
  }

  _textFieldLayout(context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: subTextFieldTitleStyle,
      validator: validator,
      autofocus: false,
      obscureText: isObscureText == null ? false : true,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:hintStyle?? TextStyle(
            color: AppColor.normalTextColor.withOpacity(0.4),
            fontFamily: "Poppins",
            fontSize: Dimensions.fontSizeDefault + 1),
        prefixIcon: prefixWidget ??
            Icon(
              prefixIcon,
              color: AppColor.hintColor,
            ),
        suffixIcon: weight,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 0.0, color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault-2),
        ),
        focusColor: AppColor.primaryColor,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.disableColor)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.disableColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault-2)),
      ),
    );
  }

  _noPrefixIconField() {
    return TextFormField(
      controller: controller,
      style: subTextFieldTitleStyle,
      validator: validator,
      onChanged: onChanged,
      autofocus: false,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:hintStyle??  TextStyle(
            color: AppColor.hintColor,
            fontFamily: "Poppins",
            fontSize: Dimensions.fontSizeDefault + 1),
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0, color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault-2),
        ),
        focusColor: AppColor.primaryColor,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.normalTextColor)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.hintColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault-2)),
      ),
    );
  }
}

TextStyle get subTextFieldTitleStyle {
  return AppStyle.mid_large_text.copyWith(
      fontWeight: FontWeight.w400,
      color: AppColor.normalTextColor,
      fontSize: Dimensions.fontSizeDefault);
}

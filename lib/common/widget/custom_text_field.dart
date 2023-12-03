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
  final String? Function(String?)? validator;
  final bool? isObscureText;

  const CustomInputField(
      {super.key,
      required this.hint,
      this.controller,
      this.weight,
      this.validator,
      this.prefixIcon,
      this.onAction,
      this.isObscureText});

  @override
  Widget build(BuildContext context) {
    final focusedCtx = FocusManager.instance.primaryFocus?.context;
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => Scrollable.ensureVisible(
      focusedCtx??context,
      duration: const Duration(milliseconds: 100),
      curve: Curves.bounceInOut,
    ));
    return prefixIcon !=null?

      _textFieldLayout(context):_noPrefixIconField();
  }

  _textFieldLayout(context) {
    return TextFormField(
      controller: controller,
      style: subTextFieldTitleStyle,
      validator: validator,
      autofocus: false,
      obscureText: isObscureText == null ? false : true,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: AppColor.hintColor,
            fontFamily: "Poppins",
            fontSize: Dimensions.fontSizeDefault + 1),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColor.hintColor,
        ),
        suffixIcon: weight,
        border: OutlineInputBorder(
          borderSide:
          const BorderSide(width: 0.0, color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
        ),
        focusColor: AppColor.primaryColor,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.disableColor)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.disableColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
      ),
    );
  }

  _noPrefixIconField() {

    return  TextFormField(
      controller: controller,
      style: subTextFieldTitleStyle,
      validator: validator,
      autofocus: false,
      decoration: InputDecoration(
        hintText: hint,
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
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.normalTextColor)),
        enabledBorder: OutlineInputBorder(
            borderSide:
            const BorderSide(color: AppColor.hintColor),
            borderRadius:
            BorderRadius.circular(Dimensions.radiusDefault)),
      ),
    );
  }

}

class CustomPassInputField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? weight;
  final Function? onAction;
  final bool? obsValue;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;

  const CustomPassInputField({
    super.key,
    required this.hint,
    this.controller,
    this.obsValue,
    this.weight,
    this.validator,
    this.prefixIcon,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {

    final focusedCtx = FocusManager.instance.primaryFocus?.context;
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => Scrollable.ensureVisible(
      focusedCtx??context,
      duration: const Duration(milliseconds: 100),
      curve: Curves.bounceInOut,
    ));
    return _passwordFieldLayout(context,obsValue);

  }

  _passwordFieldLayout(context, obsValue) {
    return TextFormField(
      controller: controller,
      style: _subTitleStyle1(context),
      autofocus: false,
      obscureText: obsValue,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: AppColor.hintColor,
            fontFamily: "Poppins",
            fontSize: Dimensions.fontSizeDefault + 1),

        suffixIcon: weight,
        prefixIcon: Icon(
          prefixIcon,
          color: AppColor.hintColor,
        ),
        focusColor: AppColor.primaryColor,
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0.0, color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.disableColor)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.disableColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
      ),
    );
  }
}


_subTitleStyle1(BuildContext context) {
  return AppStyle.mid_large_text.copyWith(
      fontWeight: FontWeight.w400,
      color: context.isDarkMode ? AppColor.cardColor : AppColor.normalTextColor,
      fontSize: Dimensions.fontSizeDefault);
}

RoundedRectangleBorder get _cardStyle {
  return RoundedRectangleBorder(
      // side: const BorderSide(width: 1,color: AppColor.disableColor),
      borderRadius: BorderRadius.circular(Dimensions.radiusDefault));
}





TextStyle get subTextFieldTitleStyle {
  return AppStyle.mid_large_text.copyWith(
      fontWeight: FontWeight.w400,
      color: AppColor.normalTextColor,
      fontSize: Dimensions.fontSizeDefault);
}

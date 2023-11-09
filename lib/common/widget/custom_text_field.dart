import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppInputField extends StatelessWidget {
  final String? title;
  final String hint;
  final TextEditingController? controller;
  final Widget? weight;
  final bool? isButtonExpanded;
  final bool? isFieldTitleHide;
  final bool? isPasswordField;
  final bool? obsValue;
  final bool? isReadVal;
  final Function? onAction;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;

  const AppInputField({
    super.key,
    this.title,
    required this.hint,
    this.controller,
    this.weight,
    this.validator,
    this.prefixIcon,
    this.isButtonExpanded = false,
    this.isPasswordField = false,
    this.isFieldTitleHide = false,
    this.obsValue = false,
    this.isReadVal = false,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isFieldTitleHide != true
            ? Text(title ?? "",
                style: _titleStyle(context.isDarkMode
                    ? AppColor.cardColor
                    : AppColor.normalTextColor))
            : Container(),
        isFieldTitleHide != true ? customSpacerHeight(height: 10) : Container(),
        isPasswordField != true
            ? _textFieldLayout(context)
            : _passwordFieldLayout(context, obsValue)
      ],
    );
  }

  _textFieldLayout(context) {
    return Row(
      children: [
        isFieldTitleHide != true
            ? Expanded(
                child: TextFormField(
                  controller: controller,
                  style: _subTitleStyle,
                  validator: validator,
                  autofocus: false,
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
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 0.0, color: AppColor.primaryColor),
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
                    ),
                    focusColor: AppColor.primaryColor,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.disableColor)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppColor.disableColor),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusDefault)),
                  ),
                  maxLines: isButtonExpanded == true ? 8 : 1,
                  minLines: isButtonExpanded == true ? 6 : 1,
                ),
              )
            : Expanded(
                child: TextFormField(
                  controller: controller,
                  style: _subTitleStyle,
                  validator: validator,
                  autofocus: false,
                  readOnly: isReadVal ?? false,
                  onTap: () => onAction!(),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: Theme.of(context).hintColor,
                      fontFamily: "Poppins",
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 0.0, color: AppColor.primaryColor),
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
                    ),
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: Theme.of(context).hintColor,
                    ),
                    focusColor: Theme.of(context).primaryColor,
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(
                            Dimensions.radiusDefault + 7)),
                  ),
                  maxLines: isButtonExpanded == true ? 8 : 1,
                  minLines: isButtonExpanded == true ? 6 : 1,
                ),
              )
      ],
    );
  }

  _passwordFieldLayout(context, obsValue) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
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
                  borderRadius:
                      BorderRadius.circular(Dimensions.radiusDefault)),
            ),
            maxLines: isButtonExpanded == true ? 8 : 1,
            minLines: isButtonExpanded == true ? 6 : 1,
          ),
        ),
      ],
    );
  }

  _subTitleStyle1(BuildContext context) {
    return AppStyle.mid_large_text.copyWith(
        fontWeight: FontWeight.w400,
        color:
            context.isDarkMode ? AppColor.cardColor : AppColor.normalTextColor,
        fontSize: Dimensions.fontSizeDefault);
  }
}

RoundedRectangleBorder get _cardStyle {
  return RoundedRectangleBorder(
      // side: const BorderSide(width: 1,color: AppColor.disableColor),
      borderRadius: BorderRadius.circular(Dimensions.radiusDefault));
}

TextStyle _titleStyle(color) {
  return AppStyle.mid_large_text.copyWith(
      fontWeight: FontWeight.w400,
      color: color,
      fontSize: Dimensions.fontSizeDefault + 2);
}

TextStyle get _subTitleStyle {
  return AppStyle.mid_large_text.copyWith(
      fontWeight: FontWeight.w400,
      color: AppColor.normalTextColor,
      fontSize: Dimensions.fontSizeDefault);
}

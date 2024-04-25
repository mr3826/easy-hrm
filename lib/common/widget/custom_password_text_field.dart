import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/app_color.dart';

import '../../utils/app_string.dart';
import '../../utils/app_style.dart';
import '../../utils/dimensions.dart';

class CustomPasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? hitText;
  final Widget? suffixWidget;
  final IconData? suffixVisibleIcon;
  final IconData? suffixHideIcon;
  final String? suffixHideText;
  final String? suffixShowText;
  final double? corneRadius;
  final Widget? prefixIcon;
  final InputDecoration? inputDecoration;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;

  const CustomPasswordInputField(
      {super.key,
        required this.controller,
        this.corneRadius,
        this.hintStyle,
        this.prefixIcon,
        this.suffixHideText,
        this.suffixShowText,
        this.suffixHideIcon,
        this.inputDecoration,
        this.suffixVisibleIcon,
        this.hitText,
        this.suffixWidget,
        this.validator});
  @override
  State<CustomPasswordInputField> createState() => _GSCustomInputFieldState();
}

class _GSCustomInputFieldState extends State<CustomPasswordInputField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final focusedCtx = FocusManager.instance.primaryFocus?.context;
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => Scrollable.ensureVisible(
      focusedCtx ?? context,
      duration: const Duration(milliseconds: 100),
      curve: Curves.bounceInOut,
    ));

    /// Widget according to style
    return widget.prefixIcon == null
        ? TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: obscureText,
        decoration: widget.inputDecoration ?? _inputStyleForSuffix())
        : TextFormField(
        validator: widget.validator,
        obscureText: obscureText,
        controller: widget.controller,
        decoration:
        widget.inputDecoration ?? _inputStyleForSuffixAndPrefix());
  }

  _inputStyleForSuffix() {
    return InputDecoration(
      hintText: widget.hitText ?? "Enter input here",
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.corneRadius ?? 12),
          borderSide: const BorderSide(width: 1, color: Colors.grey)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(widget.corneRadius ?? 12),
      ),
      suffixIcon: widget.suffixWidget ?? (_showPasswordIconLayout()),
      hintStyle: widget.hintStyle ?? const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.disableColor),
          borderRadius: BorderRadius.circular(widget.corneRadius??Dimensions.radiusDefault)
      ),
    );
  }




  _inputStyleForSuffixAndPrefix() {
    return InputDecoration(
      hintText: widget.hitText ?? "Enter input here",
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.disableColor),
          borderRadius: BorderRadius.circular(widget.corneRadius??12)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.disableColor),
          borderRadius: BorderRadius.circular(widget.corneRadius??12)
      ),
      suffixIcon: widget.suffixWidget ?? (_showPasswordIconLayout()),
      prefixIcon: widget.prefixIcon,
      hintStyle: widget.hintStyle ?? const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.disableColor),
          borderRadius: BorderRadius.circular(widget.corneRadius??12)

      ),
    );
  }

  _showPasswordIconLayout() {
    return widget.suffixHideText !=null?

    TextButton(
      child: obscureText  ? _showHideText(widget.suffixShowText.toString())
        : _showHideText(widget.suffixHideText.toString()),

      onPressed: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
    ):

      IconButton(
      icon: Icon(
        obscureText
            ? widget.suffixHideIcon ?? CupertinoIcons.eye_slash
            : widget.suffixVisibleIcon ?? CupertinoIcons.eye,
        color: AppColor.hintColor,
      ),
      onPressed: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
    );
  }

  _showHideText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Text(
        text,
        style: AppStyle.mid_large_text.copyWith(
            fontSize: Dimensions.fontSizeExtraDefault - 1,
            color: AppColor.secondaryColor),
      ),
    );
  }
}

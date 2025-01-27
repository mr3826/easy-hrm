import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../utils/app_style.dart';

class InputNote extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? hintColor;
  final Color? borderColor;
  final int? maxLength;
   final BorderRadius ? borderRadius ;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  const InputNote({
    super.key,
    required this.controller,
    this.hintColor,
    this.borderRadius,
    this.borderColor,
    this.maxLength,
    this.onChanged,
    this.hintText = AppString.text_add_description,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final focusedCtx = FocusManager.instance.primaryFocus?.context;
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => Scrollable.ensureVisible(
      focusedCtx ?? context,
      duration: const Duration(milliseconds: 100),
      curve: Curves.bounceInOut,
    ));

    return TextFormField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.multiline,
      controller: controller,
      validator: validator,
      onChanged: onChanged ??
              (value) {
            // For using update timelog details.
            // If requirement changes, we need to refactor this method.
            Get.find<TimelineController>().isValueChangeForTimeLogUpdate(true);
          },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyle.normal_text.copyWith(
          color: hintColor ?? AppColor.solidGray,
          fontWeight: FontWeight.w400,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? AppColor.primaryColor),
          borderRadius:borderRadius?? BorderRadius.circular(Dimensions.radiusDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? AppColor.solidGray),
          borderRadius:borderRadius?? BorderRadius.circular(Dimensions.radiusDefault),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? AppColor.solidGray),
        ),
        counterText: maxLength == null ? '' : null, // Hides the counter when maxLength is null.
      ),
      maxLines: 4,
      maxLength: maxLength,
      minLines: 4,
      maxLengthEnforcement:
      maxLength == null ? MaxLengthEnforcement.none : MaxLengthEnforcement.enforced,
    );
  }
}

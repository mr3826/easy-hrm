import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  final String? Function(String?)? validator;

  const InputNote(
      {super.key,
      required this.controller,
      this.hintColor,
      this.hintText = AppString.text_add_description,
      this.validator});

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
      onChanged: (value) {
        ///For using update timelog details.
        ///If requirement change than we need to refactor this method
        Get.find<TimelineController>().isValueChangeForTimeLogUpdate(true);
      },
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyle.normal_text.copyWith(
              color: hintColor ?? AppColor.solidGray,
              fontWeight: FontWeight.w400),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.primaryColor),
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.solidGray),
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.solidGray))),
      maxLines: 4,
      maxLength: 150,
      minLines: 4,
    );
  }
}

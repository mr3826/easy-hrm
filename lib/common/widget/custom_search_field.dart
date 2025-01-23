import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/app_color.dart';
import '../../utils/app_layout.dart';
import '../../utils/app_style.dart';
import '../../utils/dimensions.dart';
import 'custom_card_style.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final String? searchHintText;

  const CustomSearchField({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    this.searchHintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLayout.getHeight(60),
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder.copyWith(
          borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
        ),
        color: AppColor.hintColor.withOpacity(0.08),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextField(
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onChanged: (value) async {
              onSearchChanged(value); // Call the onSearchChanged callback
            },
            cursorColor: AppColor.normalTextColor,
            showCursor: true,
            decoration: inputStyleForPrefix(
              text: searchHintText ?? "Enter search here",
            ),
            controller: searchController,
          ),
        ),
      ),
    );
  }
}

InputDecoration inputStyleForPrefix({required String text, Widget? suffixIcon}) {
  return InputDecoration(
    hintText: text,
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
      borderSide: const BorderSide(width: 0, color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusColor: AppColor.primaryColor,
    prefixIcon:   const Icon(
      CupertinoIcons.search,
      size: 28,
      color: AppColor.hintColor,
    ),
    hintStyle: AppStyle.normal_text_grey.copyWith(
      fontWeight: FontWeight.w500,
      color: AppColor.normalTextColor.withOpacity(0.7),
      fontSize: Dimensions.fontSizeExtraDefault,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
    ),
  );
}
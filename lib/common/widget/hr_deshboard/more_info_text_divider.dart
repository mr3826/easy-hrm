import 'package:flutter/cupertino.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_style.dart';
import '../../../utils/dimensions.dart';

/// Builds an action button for various leave options like Approve, Reject, Edit.
///
///
Widget customMoreInfoTextWithDiver(
    {required String text, required VoidCallback onTap, Widget? trailing}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: AppColor.cardColor,
                  width: double.infinity,
                  height: 54,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    style: AppStyle.normal_text_black.copyWith(
                      color: AppColor.normalTextColor.withOpacity(0.8),
                      fontSize: Dimensions.fontSizeDefault + 1,
                    ),
                  ),
                ),
              ),
              if (trailing != null) Container(child: trailing)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
          child: Container(
            height: .8,
            width: double.infinity,
            color: AppColor.disableColor,
          ),
        )
      ],
    ),
  );
}
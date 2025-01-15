import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';




class ExpendableLabelWidget extends StatefulWidget {
  final String text;
  final int maxLength; // New parameter for maximum length
  final bool showToggle; // New parameter to control "view more"/"view less"
  final TextStyle? textStyle; // Optional text style
  final TextStyle? toggleTextStyle; // Optional toggle text style

  const ExpendableLabelWidget({
    Key? key,
    required this.text,
    this.maxLength = 100,
    this.showToggle = true,
    this.textStyle,
    this.toggleTextStyle,
  }) : super(key: key);

  @override
  State<ExpendableLabelWidget> createState() => _ExpendableLabelWidgetState();
}

class _ExpendableLabelWidgetState extends State<ExpendableLabelWidget> {
  late String firstHalf;
  late String secondHalf;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _splitText(widget.text);
  }

  void _splitText(String text) {
    if (text.length > widget.maxLength) {
      firstHalf = text.substring(0, widget.maxLength);
      secondHalf = text.substring(widget.maxLength);
    } else {
      firstHalf = text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update the text length check here
    if (widget.text.length > widget.maxLength) {
      _splitText(widget.text); // Split text based on current widgets.text
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          secondHalf.isEmpty
              ? RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.text,
                  style: widget.textStyle ?? disTextStyle,
                ),
              ],
            ),
          )
              : RichText(
            text: TextSpan(
              children: [
                _halfText(),
                if (widget.showToggle)
                  TextSpan(
                    text: isExpanded ? " " : " .....",
                    style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.normalTextColor.withOpacity(0.5),
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                  ),
              ],
            ),
          ),
          customSpacerHeight(height: 8),
          if (widget.showToggle)
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded
                    ? " ${AppString.text_view_less.tr}"
                    : AppString.text_view_more,
                style: widget.toggleTextStyle ??
                    AppStyle.mid_large_text.copyWith(
                      color: AppColor.secondaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.fontSizeDefault - 1,
                    ),
              ),
            )
        ],
      );
    } else {
      return Text(
        widget.text,
        style: widget.textStyle ?? AppStyle.mid_large_text.copyWith(
          color: AppColor.hintColor,
          fontSize: Dimensions.fontSizeDefault,
        ),
      );
    }
  }

  // Returns the half text based on expansion state
  TextSpan _halfText() {
    return TextSpan(
      text: isExpanded ? widget.text : firstHalf,
      style: widget.textStyle ?? disTextStyle,
    );
  }
}

// Decoration getter for container styles
Decoration get decoration {
  return AppStyle.ContainerStyle.copyWith(
    color: AppColor.primaryColor.withOpacity(0.1),
    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
  );
}

// Text styles for various UI components
TextStyle get cardTitleTextStyle {
  return AppStyle.title_text.copyWith(
    color: AppColor.normalTextColor,
    fontWeight: FontWeight.w500,
    fontSize: Dimensions.fontSizeMid,
  );
}

TextStyle get viewCardSubTextStyle {
  return AppStyle.mid_large_text;
}

TextStyle get disTextStyle {
  return AppStyle.mid_large_text.copyWith(
    color: AppColor.hintColor,
    fontSize: Dimensions.fontSizeDefault,
  );
}

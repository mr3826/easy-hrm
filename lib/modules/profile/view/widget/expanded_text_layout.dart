import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class ExpandedText extends StatefulWidget {
  final String text;
  const ExpandedText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  late String firstHalf;
  late String secondHalf;
  bool isExpanded = false;

  @override
  void initState() {
    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 100);
      secondHalf = widget.text.substring(101, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        secondHalf == ""
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.text,
                      style: disTextStyle,
                    ),
                  ],
                ),
              )
            : RichText(
                text: TextSpan(
                  children: [
                    // half text layout here
                    _halfText(),
                    TextSpan(
                      text: isExpanded ? " " : " .....",
                      style: AppStyle.mid_large_text.copyWith(
                          color: AppColor.normalTextColor.withOpacity(0.5),
                          fontSize: Dimensions.fontSizeDefault),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });

                          //_readMoreText();
                        },
                    ),
                  ],
                ),
              ),
        customSpacerHeight(height: 8),
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
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.fontSizeDefault-1),
            ))
      ],
    );
  }

  _halfText() {
    return TextSpan(
      text: isExpanded ? widget.text : firstHalf,
      style: disTextStyle,
    );
  }
}

Decoration get decoration {
  return AppStyle.ContainerStyle.copyWith(
      color: AppColor.primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(Dimensions.radiusDefault));
}

TextStyle get cardTitleTextStyle {
  return AppStyle.title_text.copyWith(
      color: AppColor.normalTextColor,
      fontWeight: FontWeight.w500,
      fontSize: Dimensions.fontSizeMid);
}

TextStyle get viewCardSubTextStyle {
  return AppStyle.mid_large_text;
}

TextStyle get disTextStyle {
  return AppStyle.mid_large_text.copyWith(
      color: AppColor.hintColor, fontSize: Dimensions.fontSizeDefault);
}

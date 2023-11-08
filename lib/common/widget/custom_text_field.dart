import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? weight;
  final bool? isButtonExpanded;
  final bool? isFieldTitleHide;
  final bool? isFieldElevationHide;
  final bool? obsValue;
  final bool? isReadVal;
  final Function?onAction;

  const AppInputField(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.weight,
      this.isButtonExpanded = false,
      this.isFieldElevationHide = false,
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
            ? Text(title,
                style: _titleStyle(context.isDarkMode
                    ? AppColor.cardColor
                    : AppColor.normalTextColor))
            : Container(),

        isFieldTitleHide != true ? customSpacerHeight(height: 10) : Container(),

        isFieldElevationHide != true
            ? Card(
                elevation: 3,
                shadowColor: Colors.grey.withOpacity(0.2),
                shape: _cardStyle,
                child: _textFieldLayout(context),
              )
            : Card(
                color: Theme.of(context).hintColor.withOpacity(0.1),
                elevation: 0,
                shadowColor: Colors.grey.withOpacity(0.2),
                shape: _cardStyle,
                child: _passwordFieldLayout(context,obsValue),
              )
      ],
    );
  }

  _textFieldLayout(context) {
    return Row(
      children: [
        customSpacerWidth(width: 12),
        isFieldTitleHide != true
            ? Expanded(
                child: TextFormField(
                  controller: controller,
                  style: _subTitleStyle,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.poppins(
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
            : Expanded(
                child: TextFormField(
                  controller: controller,
                  style: _subTitleStyle,
                  autofocus: false,
                  readOnly: isReadVal??false,
                  onTap: ()=>onAction!(),

                  decoration: InputDecoration(
                    hintText: hint,

                    hintStyle: GoogleFonts.poppins(
                      color: Theme.of(context).hintColor,
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
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: weight,
              hintStyle: GoogleFonts.poppins(
                color: Theme.of(context).hintColor,
              ),
              focusColor: Theme.of(context).primaryColor,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius:
                      BorderRadius.circular(Dimensions.radiusDefault + 5)),
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
        color: context.isDarkMode?AppColor.cardColor:AppColor.normalTextColor,
        fontSize: Dimensions.fontSizeDefault);
  }
}

RoundedRectangleBorder get _cardStyle {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimensions.radiusMid-5));
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


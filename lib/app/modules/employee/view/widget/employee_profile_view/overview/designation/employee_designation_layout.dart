import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../../../../utils/app_color.dart';
import '../../../../../../../../../utils/app_string.dart';
import '../../../../../../../../../utils/app_style.dart';
import '../../../../../../../../../utils/dimensions.dart';
import '../../../../../../../../../utils/images.dart';
import '../../../../../../../modules/auth/view/screens/otp_screen.dart';

/// A stateless widgets that displays the employee status with a designated
/// image, title, and date.

class EmployeeStatusCard extends StatelessWidget {
  /// Creates an [EmployeeStatusCard].
  ///
  /// The [context] is used for showing modal sheets.
  /// The [sVGImg] is an optional SVG image path.
  /// The [titleText] is a required title to display.
  /// The [date] is a required date to display.
  const EmployeeStatusCard({
    Key? key,
    this.context,
    this.sVGImg,
    required this.titleText,
    required this.date,
    required this.onAction,
  }) : super(key: key);

  final BuildContext? context;
  final String? sVGImg;
  final String titleText;
  final String date;
  final Function? onAction;


  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ()=>onAction!(),
      child: SizedBox(
        child: Card(
          elevation: 0,
          color: AppColor.bgColorWithPrimary.withOpacity(0.3),
          shape: roundedRectangleBorder,
          child: Padding(
            padding: marginLayout.copyWith(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the SVG image
                customSvgImage(
                  imageUrl: sVGImg ?? Images.EMPLOYEE_STATUS,
                  height: 25,
                  width: 25,
                ),
                customSpacerHeight(height: 14),
                // Display designation information
                _designationInfo(titleText, date),
                customSpacerHeight(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// A helper method to display designation information including the
  /// title and date.
  ///
  /// [text] is the title of the designation.
  /// [date] is the date to be displayed.
  Widget _designationInfo(String text, String date) {
    return Wrap(
      children: [
        Text(
          text,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            overflow: TextOverflow.ellipsis,
            fontSize: Dimensions.fontSizeMid,
          ),
          maxLines: 2,
        ),
        Text(
          "${AppString.text_from.tr} - ${formatDate(date: date,format: "dd MMM, yyyy")}",
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeDefault - 1,
          ),
        ),
      ],
    );
  }
}

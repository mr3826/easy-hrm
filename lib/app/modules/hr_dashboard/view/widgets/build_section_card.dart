import 'package:flutter/cupertino.dart';
import '../../../../../common/widget/custom_svg_image.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/app_margin.dart';

class BuildSectionCard extends StatelessWidget {
  final String labelText;
  final String value;
  final String imgUrl;
  final Color bgColor;
  final Function? onClick;
  final EdgeInsets? padding;

  const BuildSectionCard({
    super.key,
    required this.labelText,
    required this.value,
    required this.imgUrl,
    required this.bgColor,
    this.onClick,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Provide a fallback value for padding if null
      padding: padding ?? marginLayout,
      child: GestureDetector(
        // Check if onClick is not null before calling it
        onTap: onClick != null ? () => onClick!() : null,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            // Ensure bgColor is used safely
            color: bgColor.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                // Handle the SVG image gracefully
                if (imgUrl.isNotEmpty)
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: customSvgImage(imageUrl: imgUrl),
                  ),
                if (imgUrl.isNotEmpty) const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ensure value is displayed even if it's an empty string
                      Text(
                        value.isNotEmpty ? value : "N/A",
                        style: AppStyle.mid_large_text.copyWith(
                          color: bgColor,
                          fontSize: Dimensions.fontSizeExtraLarge - 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Ensure labelText is displayed even if it's an empty string
                      Text(
                        labelText.isNotEmpty ? labelText : "No Label",
                        style: AppStyle.normal_text.copyWith(
                          color: AppColor.hintColor,
                          fontSize: Dimensions.fontSizeSmall + 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

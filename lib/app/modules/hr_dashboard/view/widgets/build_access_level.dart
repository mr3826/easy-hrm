import 'package:flutter/cupertino.dart';
import '../../../../../common/widget/custom_svg_image.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';

class BuildAccessLevel extends StatelessWidget {
  final String labelText;
  final String value;
  final String imgUrl;
  final Color bgColor;
  final Function? onClick;

  const BuildAccessLevel({
    super.key,
    required this.labelText,
    required this.value,
    this.onClick,
    required this.imgUrl,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick!() ?? () {}, // Pass the function reference directly
      ///todo why not null [check if possible to custom]
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          color: bgColor.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: customSvgImage(imageUrl: imgUrl),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: AppStyle.mid_large_text.copyWith(
                        color: bgColor,
                        fontSize: Dimensions.fontSizeExtraLarge - 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      labelText,
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
    );
  }
}

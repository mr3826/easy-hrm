import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/widget/custom_spacer.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_layout.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_style.dart';
import '../../../utils/images.dart';

class NetworkErrorPage extends StatelessWidget {
  final VoidCallback onRetry;

  const NetworkErrorPage({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Images.networkError),
            customSpacerHeight(height: 20),
            Text(
              AppString.no_internet_title_text,
              style: AppStyle.extra_large_text_black
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            customSpacerHeight(height: 20),
            Text(
              "${AppString.no_internet_subtitle_text}.",
              style: AppStyle.normal_text_black,
              textAlign: TextAlign.center,
            ),
            customSpacerHeight(height: 40),
            GestureDetector(
              onTap: onRetry,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(8)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

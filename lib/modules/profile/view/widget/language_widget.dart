import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

class LanguageLayout extends StatelessWidget {
  LanguageLayout({super.key});
  final currentIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customButtonSheetAppbar(text: AppString.text_select_language.tr),
        customSpacerHeight(height: 20),
        Expanded(
            child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            List languageIndex = ["English", "Norwegian"];
            return Obx(() => Padding(
                  padding: marginLayout.copyWith(top: 12),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          currentIndex.value = index;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  languageIndex[index],
                                  style: AppStyle.mid_large_text.copyWith(
                                      color: AppColor.normalTextColor,
                                      fontSize: Dimensions.fontSizeDefault + 2),
                                ),
                                customSpacerWidth(width: 12),
                                currentIndex.value == index
                                    ? const Icon(
                                        Icons.done,
                                        color: AppColor.primaryColor,
                                      )
                                    : Container()
                              ],
                            ),
                            Image(image: AssetImage(Images.FLAG_PNG)),
                          ],
                        ),
                      ),
                      customSpacerHeight(height: 12),
                      const Divider()
                    ],
                  ),
                ));
          },
        ))
      ],
    );
  }
}

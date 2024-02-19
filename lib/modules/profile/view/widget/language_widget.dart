import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../common/controller/language_controller.dart';
import '../../../../enum.dart';

class LanguageLayout extends StatelessWidget {
  LanguageLayout({super.key});

  final currentIndex = int.parse(GetStorage().read("languageIndex") !=null?GetStorage().read("languageIndex").toString():"0").obs;

  @override
  Widget build(BuildContext context) {
    List languageIndex = ["English", "Norwegian"];
    List languageFlagIndex = [Images.FLAG_PNG, Images.NOEWAYFLAG];
    return Column(
      children: [
        customButtonSheetAppbar(text: AppString.text_select_language.tr),
        customSpacerHeight(height: 20),
        Expanded(
            child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Obx(() => Padding(
                  padding: marginLayout.copyWith(top: 0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          currentIndex.value = index;
                          GetStorage().write("languageIndex",index);
                          _changeLanguage(index: _getStringAccordingToIndex(index));
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
                            Image(image: AssetImage(languageFlagIndex[index])),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0, bottom: 14),
                        child: Divider(
                          color: AppColor.disableColor.withOpacity(0.9),
                          thickness: 1,
                        ),
                      )
                    ],
                  ),
                ));
          },
        ))
      ],
    );
  }
}

_changeLanguage({required String index}) {
  if (index.toLowerCase() == Language.english.name) {
    Get.find<LanguageController>().changeLanguage("en", "US");
  } else if (index.toLowerCase() == Language.norwegian.name) {
    Get.find<LanguageController>().changeLanguage('no', 'NO');
  } else {
  }
}

String _getStringAccordingToIndex(index) {
  switch (index) {
    case == 0:
      return "English";
    case == 1:
      return "Norwegian";
    default:
      return "English";
  }
}

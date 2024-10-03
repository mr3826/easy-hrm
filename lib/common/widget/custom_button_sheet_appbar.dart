import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../utils/app_color.dart';
import '../../utils/app_style.dart';
import '../../utils/dimensions.dart';

Widget buildBottomSheetHeader({Widget? customWidget, String? text}) {
  print(MediaQuery.of(Get.context!).size.height / 8.8);
  return Container(
    height: MediaQuery.of(Get.context!).size.height / 8.8,
    width: double.infinity,
    decoration: const BoxDecoration(
      color: AppColor.bgColorWithTimeline,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            height: 4,
            width: 120,
            color: AppColor.backgroundColor,
          ),
        ),
        const Spacer(),
        Center(
          child: customWidget ??
              (text != null
                  ? Text(
                      text, // Display the text if a string is passed
                      style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.normalTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.fontSizeMid + 1,
                      ),
                    )
                  : const SizedBox.shrink()), // If both are null, show nothing
        ),
        const Spacer(),
      ],
    ),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/convart_color_code_controller.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';



Widget taskInputFieldLayout({required Function onAction}) {
  return InkWell(
    onTap: () => onAction(),
    child: Container(
      width: double.infinity,
      padding: marginLayout.copyWith(left: 12, right: 8, top: 12, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.hintColor),
      ),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Get.find<TimelineController>().projectColor.value.isNotEmpty
              ? Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              Icons.circle,
              size: 14,
              color: HexColor(
                Get.find<TimelineController>().projectColor.value,
              ),
            ),
          )
              : Container(),
          customSpacerWidth(width: 8),
          Expanded(
            child: Get.find<TimelineController>().taskName.value.isNotEmpty
                ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        Get.find<TimelineController>().taskName.value,
                        style: AppStyle.mid_large_text.copyWith(
                          fontSize: Dimensions.fontSizeDefault + 1,
                          color: AppColor.normalTextColor,
                        ),
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        maxLines: 1, // Limit to 1 line
                      ),
                    ],
                  ),
                )
                : Text(
              AppString.text_select_option.tr,
              style: AppStyle.mid_large_text.copyWith(
                fontSize: Dimensions.fontSizeDefault + 1,
                color: AppColor.hintColor,
              ),
              overflow: TextOverflow.ellipsis, // Handle overflow
              maxLines: 1, // Limit to 1 line
            ),
          ),
          customSpacerWidth(width: 3),


          Get.find<TimelineController>().isLoading.isTrue
              ? const CupertinoActivityIndicator(
            color: Colors.blueAccent,
            radius: 12,
          )
              : const Icon(
            CupertinoIcons.search,
            size: 30,
            color: AppColor.hintColor,
          ),
        ],
      )),
    ),
  );
}


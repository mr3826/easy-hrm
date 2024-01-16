import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/timeline/controller/timeline_controller.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';

import '../../controller/selected_task_controller.dart';
import '../../controller/timeline_controller.dart';

Widget taskInputFieldLayout({required onAction}) {
  return InkWell(
    onTap: () => onAction(),
    child: Card(
      elevation: 0,
      color: Colors.transparent,
      shape: roundedRectangleBorder.copyWith(
          side: const BorderSide(width: .8, color: AppColor.hintColor)),
      child: Padding(
        padding: marginLayout.copyWith(left: 12, right: 8, top: 12, bottom: 12),
        child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Get.find<TimelineController>().taskName.value.isNotEmpty
                    ? Text(
                        Get.find<TimelineController>().taskName.value,
                        style: AppStyle.mid_large_text.copyWith(
                            fontSize: Dimensions.fontSizeDefault + 1,
                            color: AppColor.normalTextColor),
                      )
                    : Text(
                        AppString.text_select_option.tr,
                        style: AppStyle.mid_large_text.copyWith(
                            fontSize: Dimensions.fontSizeDefault + 1,
                            color: AppColor.hintColor),
                      ),
                const Icon(
                  CupertinoIcons.search,
                  size: 30,
                  color: AppColor.hintColor,
                )
              ],
            )),
      ),
    ),
  );
}

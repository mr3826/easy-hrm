import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_card_style.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/view/screen/chnage_email.dart';
import 'package:payrun_mobile/modules/profile/view/widget/email_verification_otp.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../utils/images.dart';
import '../../../timeline/view/widget/timeline_calendar.dart';

class BuildEmail extends StatelessWidget {
  const BuildEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.text_email.tr,
          style: AppStyle.normal_text_grey.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault + 1,
          ),
        ),
        customSpacerHeight(height: 2),
        Row(
          children: [
            Flexible(
              child: Text(
                Get.find<UserProfileController>()
                        .userDetails
                        ?.getOrganizationUserDetails
                        ?.user
                        ?.email ??
                    "",
                maxLines: 2,
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.hintColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.fontSizeDefault - 1),
              ),
            ),
            const SizedBox(width: 12),
            if (Get.find<UserProfileController>()
                    .userDetails
                    ?.getOrganizationUserDetails
                    ?.user
                    ?.email !=
                null)
              SizedBox(
                height: 17,
                width: 17,
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                        text: Get.find<UserProfileController>()
                                .userDetails
                                ?.getOrganizationUserDetails
                                ?.user
                                ?.email ??
                            ""));

                    showSuccessMessage(message: "Copied");
                  },
                  child: const Icon(
                    Icons.copy,
                    size: 14,
                    color: AppColor.secondaryColor,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

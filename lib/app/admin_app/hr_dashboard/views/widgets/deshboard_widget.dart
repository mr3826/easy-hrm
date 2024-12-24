import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/custom_network_img.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';


userInfoAppbarLayout() {
  return Padding(
    padding: const EdgeInsets.only(top: 46.0),
    child: Row(
      children: [
        _userImageLayout(),
        customSpacerWidth(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.text_welcome.tr,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.hintColor,
                  fontSize: Dimensions.fontSizeDefault),
            ),
            Text(
              "Rifat Hasan",
              style: AppStyle.normal_text_grey.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.fontSizeMid),
            ),
          ],
        ),
        const Spacer(),
        Icon(
          CupertinoIcons.bell,
          color: AppColor.normalTextColor.withOpacity(0.5),
          size: 27,
        )
      ],
    ),
  );
}

_userImageLayout() {
  return const CustomNetworkImage(
    radius: 22,
    errorText: "ER",
    isCircleImage: true,
    borderColor: AppColor.primaryColor,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToDhcKo7SHf5KPPVnfFFV8zlgE4nNCubsP9w&s',
  );
}


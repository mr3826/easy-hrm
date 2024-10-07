import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_appbar.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

class TerminateWidget extends StatelessWidget {
  const TerminateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSvgImage(imageUrl: Images.terminate,width: 64,height: 64),
            customSpacerHeight(height: 20),
            
            Row(
              children: [
                Text(AppString.textTerminating.tr,style: AppStyle.title_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeMid,fontWeight: FontWeight.w500),),
                customSpacerWidth(width: 8),
                Text("Bartosz Friedemann",style: AppStyle.title_text.copyWith(color: AppColor.secondaryColor,fontSize: Dimensions.fontSizeMid,fontWeight: FontWeight.w500),),
              ],
            ),
            customSpacerHeight(height: 15),
            
            Text(AppString.textThisActionWillRemoveEtc.tr,style: AppStyle.normal_text_black.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault+1),),

            customSpacerHeight(height: 15),


            Text("What type of termination?",style: AppStyle.normal_text.copyWith(color: AppColor.normalTextColor,fontWeight: FontWeight.w500,fontSize: Dimensions.fontSizeMid),),








          ],
        ),
      ),
    );
  }
}

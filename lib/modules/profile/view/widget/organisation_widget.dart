import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import 'org_buttonsheet_appbar.dart';
class OrganisationView extends StatelessWidget {
    OrganisationView({super.key});
  final isSelected=0.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        orgButtonSheetAppbar(orgLength: 3),
        Expanded(child: Padding(
          padding: marginLayout.copyWith(top: 12,bottom: 12),
          child: ListView.builder(
            itemCount: 3,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                isSelected.value=index;
              },
              child: Obx(() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: AssetImage(Images.ORG),
                        ),
                        customSpacerWidth(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("TrueCoders",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontWeight: FontWeight.w900,fontSize: Dimensions.fontSizeDefault+1),),
                            Text("Senior Developer",style: AppStyle.normal_text_grey.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-1),),
                            customSpacerHeight(height: 6),

                          ],
                        ),
                        const Spacer(),
                        isSelected.value==index?  const Icon(Icons.done,color: AppColor.primaryColor,):Container()
                      ],
                    ),
                    customSpacerHeight(height: 8),
                    const Divider(thickness: 1,)
                  ],
                ),
              )),
            );
          },),
        ))
      ],
    );
  }
}

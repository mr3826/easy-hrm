import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/designation_layout.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/employeement_status_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

Widget employeeStatusLayout(context){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
         onTap: ()=>customButtonSheet(child:const DesignationLayout(),height: .7,context: context),
        child: Expanded(
          child: Card(
            elevation: 0,
            color: AppColor.primaryColor.withOpacity(0.05),
            shape: roundedRectangleBorder,
            child: Padding(
              padding: marginLayout.copyWith(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSvgImage(imageUrl: Images.EMPLOYEE_STATUS,height: 25,width: 25),
                  customSpacerHeight(height: 12),
                  Text("Senior \nDeveloper",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeMid),)
                  ,Text("From - 01 Jan,2021",style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-1),)
                  ,customSpacerHeight(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
      customSpacerWidth(width: 4),
      Expanded(
        child: GestureDetector(
          onTap: ()=>customButtonSheet(context: context,height: .7,child:const EmploymentLayout() ),
          child: Card(
            elevation: 0,
            color: AppColor.primaryColor.withOpacity(0.05),
            shape: roundedRectangleBorder,
            child: Padding(
              padding: marginLayout.copyWith(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSvgImage(imageUrl: Images.FLAG,height: 25,width: 25),
                  customSpacerHeight(height: 12),
                  Text("Permanent \nEmployee",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeMid),)
                  ,Text("From - 01 Jan,2021",style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-1),)
                  ,customSpacerHeight(height: 12),
                ],
              ),
            ),
          ),
        ),
      )


    ],
  );
}
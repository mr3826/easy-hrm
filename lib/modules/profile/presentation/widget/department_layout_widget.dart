import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';

import 'department_history.dart';

Widget departmentLayout(context) {
  return GestureDetector(
    onTap: ()=>customButtonSheet(context: context,height: .7,child:  DepartmentHistory(
      date: "02 Jan,2022",
      departmentName: "Laravel Department",
      employeeDptStatus: "Manager",
      employeeStatus: "Present",
      imageUrl: Images.user,
      name: "Noah",
      itemCount: 2,
    )),
    child: SizedBox(
      height: AppLayout.getHeight(289),

      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder,
        color: AppColor.primaryColor.withOpacity(0.05),
        child: Padding(
          padding: marginLayout.copyWith(top: 12,bottom: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSvgImage(imageUrl: Images.department_notification,color: AppColor.primaryColor,height: 25,width: 25),
              customSpacerHeight(height: 12),
              Text("Laravel Department",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor),),

              Row(
                children: [
                  Text(AppString.text_child_of_deparmtnet.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.secondaryColor,fontSize: Dimensions.fontSizeDefault-1),),
                 _divider(),
                  Expanded(child: Text("From - 01 Jan,2021",style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-1,overflow: TextOverflow.ellipsis),))
                ],
              ),
              _workingShiftLayout(context),

            ],
          ),
        ),
      ),

    ),
  );
}

_workingShiftLayout(context) {
  return Expanded(
    child: Padding(
      padding: marginLayout.copyWith(left: 2,top: 12),
      child: Row(
        children: [
         Container(width: 1,height: double.infinity,color: AppColor.hintColor.withOpacity(0.4),),
          customSpacerWidth(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Regular Worksheet",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault+1),),
              Row(
                children: [
                  Text("11.00 am -08.00 pm",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor.withOpacity(0.7),fontSize: Dimensions.fontSizeDefault+1),),
                  _divider(),
                  Text("9h",style: AppStyle.mid_large_text.copyWith(color: AppColor.hintColor,fontSize: Dimensions.fontSizeDefault-1),)
                ],
              ),
              customSpacerHeight(height: 8),
              Text("Working day",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor.withOpacity(0.7),fontSize: Dimensions.fontSizeDefault+1),),
              _workingDaySchedule(context)

            ],
          ),
        ],
      ),
    ),
  );
}

_workingDaySchedule(context) {
  List day=[
    "Sun",
    "Mon",
    "Tue",
    "Web",
    "Thu"
  ];
  return  SizedBox(

    height: AppLayout.getHeight(76),
    width: MediaQuery.of(context).size.width/1.5,

    child: ListView.builder(
      shrinkWrap: true,
      itemCount: day.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0.0,right: 30,top: 12,bottom: 12),
            child: Column(
              children: [
                customSpacerWidth(width: 8),
                Text(day[index],style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault+1,overflow: TextOverflow.ellipsis),),
                const Icon(Icons.done,color: AppColor.successColor,),
              ],
            ),
          ),
        ],
      );
    },),
  );
}

_divider() {
  return  Padding(
    padding: marginLayout.copyWith(left: 8,right: 8),
    child: Container(width: 1,height: 12,color: AppColor.hintColor,),
  );
}

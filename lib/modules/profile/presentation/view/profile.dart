import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_status_button.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/action_layout_widget.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/expanded_text_layout.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/user_info_section_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';


import '../widget/profile_appbar.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:profileAppbar(onAction: (){}),
      body: Padding(
        padding: marginLayout,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSpacerHeight(height: 20),
              _userInfoLayout(),
              customSpacerHeight(height: 30),
              _monthlyStatusLayout(),
              customSpacerHeight(height: 30),
              _actionBtnLayout(context),
              customSpacerHeight(height: 15),
              _descriptionTextLayout(),
              customSpacerHeight(height: 15),
              const Divider(thickness: .6,),


              userInfoSectionLayout(staticText: AppString.text_email.tr,dynamicText: "rifatal@gmail.com",isChangeEmailVisible: true,onAction: (){}),
              customSpacerHeight(height: 15),


              userInfoSectionLayout(staticText: AppString.text_phone.tr,dynamicText: "+0884523452345",),
              customSpacerHeight(height: 15),

              userInfoSectionLayout(staticText: AppString.text_emergency_phone.tr,dynamicText: "+0884523452345",),
              customSpacerHeight(height: 15),

              userInfoSectionLayout(staticText: AppString.text_address.tr,dynamicText: "Personal added one"),






            ],
          ),
        ),
      ),


    );
  }

  _userInfoLayout() {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 33,
          backgroundColor: AppColor.disableColor,
          child: CircleAvatar(
            radius: 32,
            backgroundColor: AppColor.backgroundColor,
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(Images.user),
            ),
          ),
        ),
        customSpacerWidth(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Agens Neilson",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor),),
            Text("Laravel department",style: AppStyle.normal_text_grey,),
            customSpacerHeight(height: 8),
            Row(
              children: [
                CustomStatusButton(bgColor: AppColor.successColor.withOpacity(0.2), textColor: AppColor.successColor,text: "Permanent",),
                customSpacerWidth(width: 8),
                CustomStatusButton(bgColor: AppColor.successColor.withOpacity(0.2), textColor: AppColor.successColor,text: "Active",)
              ],
            )
          ],
        ),


      ],
    );
  }

  _monthlyStatusLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       _infoTextLayout(dynamicText: "12d4h",staticText: AppString.text_leave_balance.tr),
        _divider(),
        _infoTextLayout(dynamicText: "160h",staticText: AppString.text_monthly_goal.tr),
        _divider(),
        _infoTextLayout(dynamicText: "12dh+",staticText:AppString.text_logged_time.tr),

      ],
    );
  }

  _infoTextLayout({required dynamicText,required staticText}) {
    return  Column(
      children: [
        Text("$dynamicText",style: AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor),),
        Text("$staticText",style: AppStyle.mid_large_text.copyWith(fontSize: Dimensions.fontSizeDefault-3,color: AppColor.hintColor),)
      ],
    );
  }

  _divider() {
    return Container(width: 1,height: 20,color: AppColor.disableColor,);
  }

  _actionBtnLayout(context) {
    return GestureDetector(
      onTap: ()=>customButtonSheet(context: context,height: .5,child:actionLayout(userName: "Agens Neilson",departmentText: "Laravel department",) ),
      child: Container(
        height: AppLayout.getHeight(44),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
          color: AppColor.primaryColor,
        ),
        child: Center(child: Text(AppString.text_action.tr,style: AppStyle.mid_large_text.copyWith(fontSize: Dimensions.fontSizeDefault+3),)),
      ),
    );
  }

  _descriptionTextLayout() {
    return  _filterTextLengthLayout();
  }


  _filterTextLengthLayout(){
    var drc="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book";
    final wordCount = drc.split(' ').length;
    if (wordCount > 20) {
      return ExpandedText(text: drc,);
    } else {
      return Text(drc,style: AppStyle.mid_large_text.copyWith(color: AppColor.primaryColor),);
    }
  }


}












import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_status_button.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/presentation/controller/profile_image_selected_controller.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/action_layout_widget.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/chnage_email_notify_layout.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/department_layout_widget.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/employee_stauts_layout.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/expanded_text_layout.dart';
import 'package:payrun_mobile/modules/profile/presentation/widget/user_info_section_layout.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../widget/language_widget.dart';
import '../widget/organisation_widget.dart';
import '../widget/profile_appbar.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:profileAppbar(onAction: (){}),
      endDrawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            customSpacerHeight(height: 70),

            _profileLayout(),
            customSpacerHeight(height: 40),

            _organisationLayout(context),

            const Spacer(),
            _languageLayout(context),
            customSpacerHeight(height: 30),

            _logoutLayout(context)

          ],
        ),
      ),

      body: Padding(
        padding: marginLayout,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSpacerHeight(height: 20),
              Obx(() => _userInfoLayout(),),
              customSpacerHeight(height: 30),
              _monthlyStatusLayout(),
              customSpacerHeight(height: 30),
              _actionBtnLayout(context),
              customSpacerHeight(height: 25),
              _descriptionTextLayout(),
              customSpacerHeight(height: 15),
              const Divider(thickness: .6,),
               ChangeEmailNotifyLayout(),

              customSpacerHeight(height: 15),
              userInfoSectionLayout(staticText: AppString.text_phone.tr,dynamicText: "+0884523452345",),
              customSpacerHeight(height: 15),

              userInfoSectionLayout(staticText: AppString.text_emergency_phone.tr,dynamicText: "+0884523452345",),
              customSpacerHeight(height: 15),

              userInfoSectionLayout(staticText: AppString.text_address.tr,dynamicText: "Personal added one"),
              customSpacerHeight(height: 15),
              departmentLayout(context),
              customSpacerHeight(height: 5),
              employeeStatusLayout(context: context),
              customSpacerHeight(height: 50),

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
              backgroundColor: AppColor.backgroundColor,
              child:Get.find<PikedProfileImgController>()
                  .storageForUpload
                  .filePath
                  .value.isNotEmpty?

              CircleAvatar(
                radius: 37,
                backgroundImage:
                FileImage(
                    File(Get.find<PikedProfileImgController>()
                        .storageForUpload
                        .filePath
                        .value

                    )
                        .absolute

                ),
              ): CircleAvatar(
                radius: 37,
                backgroundImage:AssetImage(Images.user),
              ),
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

  _userProfileImgLayout() {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: AppColor.disableColor,
          child: CircleAvatar(
            radius: 44,
            backgroundColor: AppColor.backgroundColor,
            child: CircleAvatar(
              radius: 44,
              backgroundColor: AppColor.primaryColor.withOpacity(0.08),
              child:Get.find<PikedProfileImgController>()
                  .storageForUpload
                  .filePath
                  .value.isNotEmpty?

              CircleAvatar(
                radius: 41,
                backgroundImage:
                FileImage(
                    File(Get.find<PikedProfileImgController>()
                        .storageForUpload
                        .filePath
                        .value

                    )
                        .absolute

                ),
              ): CircleAvatar(
                radius: 41,
                backgroundImage:AssetImage(Images.user),
              ),
            ),
          ),
        ),
        customSpacerWidth(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Agens Neilson",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor),),
            Text("Laravel department",style: AppStyle.normal_text_grey.copyWith(fontSize: Dimensions.fontSizeDefault-1),),
            customSpacerHeight(height: 8),
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
      onTap: ()=>customButtonSheet(context: context,height: .5,child:actionLayout(context: context,userName: "Agens Neilson",departmentText: "Laravel department",editAction: (){},changePassAction: (){}) ),
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

  _logoutLayout(context) {
    return GestureDetector(
      onTap: (){
        customDialog(context: context,saveBtnAction: (){
         Get.back();
        },
            icon: Icons.logout,
            titleText: AppString.text_are_you_sure.tr,
            subText: AppString.text_if_you_do_this_etc.tr,
            iconBgColor: AppColor.errorColorLight,
            btnBgColor: AppColor.errorColorLight,
            btnText: AppString.text_log_out.tr,
            drcText: "",
            drcFontSize: Dimensions.fontSizeDefault,
        );
      },
      child: Container(
        height: AppLayout.getHeight(90),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: AppColor.secondaryColor.withOpacity(0.4)),
        child: Padding(
          padding: marginLayout.copyWith(top: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.logout_rounded,color: AppColor.cardColor,),
              customSpacerWidth(width: 12),
              Text(AppString.text_log_out.tr,style: AppStyle.mid_large_text.copyWith(color: AppColor.cardColor),),
            ],
          ),
        ),
      ),
    );
  }

  _languageLayout(context) {
    return InkWell(
      onTap: ()=>customButtonSheet(child: LanguageLayout(),context: context,height: .5),
      child: Container(
        padding: marginLayout.copyWith(left: 8,right: 8),
        child: Row(
          children: [
             SizedBox(height: 20,child: Image.asset(Images.FLAG_PNG)),
            customSpacerWidth(width: 8),
            Row(
              children: [
                Text(AppString.text_language.tr,style: AppStyle.mid_large_text.copyWith(fontSize: Dimensions.fontSizeDefault+1,color: AppColor.hintColor),),
                Text("English",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault+1),)
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_sharp,color: AppColor.hintColor,size: 20,)


          ],
        ),
      ),
    );
  }

  _organisationLayout(context) {
    return Padding(
      padding: marginLayout,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text("Your organisation",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault,letterSpacing: 3.5),),
          customSpacerHeight(height: 12),
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
                  GestureDetector(
                      onTap: ()=>customButtonSheet(context: context,height: .7,child:  OrganisationView()),
                      child: Text(AppString.text_swich_organisation.tr,style: AppStyle.normal_text_grey.copyWith(color: AppColor.secondaryColor,fontSize: Dimensions.fontSizeDefault-1),)),
                ],
              )
            ],
          )

        ],
      ),
    );
  }

  _profileLayout() {
    return   Center(
      child: _userProfileImgLayout(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_text_field.dart';
import 'package:payrun_mobile/common/widget/input_note.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/utils.dart';

Widget textFiledLayout(){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     userTextFieldLayout(hintText: AppString.text_first_name.tr,titleText: AppString.text_first_name.tr,controller:editFirstNameController ),
     userTextFieldLayout(titleText: AppString.text_last_name.tr,controller:editLastNameController ),

     userTextFieldLayout(titleText: AppString.text_email.tr,controller:editEmailController ),

     userTextFieldLayout(titleText: AppString.text_address.tr,controller:editAddressController ),

     userTextFieldLayout(titleText: AppString.text_phone.tr,controller:editPhoneController ),

     userTextFieldLayout(titleText: AppString.text_emergency_phone.tr,controller:editEmergencyPhoneController ),

     userTextFieldLayout(hintText: AppString.text_bio.tr,titleText: AppString.text_first_name.tr,controller:editBioController ,isNoteFieldVisible: true),
     customSpacerHeight(height: 20),


    CustomDoubleAppButton(buttonText: AppString.text_save.tr, onAction: (){}, cancelAction: ()=>Get.back()),

      customSpacerHeight(height: 80),

    ],
  );
}


userTextFieldLayout({required titleText,required TextEditingController controller,hintText,isNoteFieldVisible=false,validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("$titleText",style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault+2),),
      customSpacerHeight(height: 12),
      isNoteFieldVisible !=false?   InputNote(controller: editBioController,hintText: AppString.text_bio.tr,):

      CustomInputField(hint: hintText??titleText,controller: controller,validator:validator ,),
      customSpacerHeight(height: 12),
    ],
  );
}
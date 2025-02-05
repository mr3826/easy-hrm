import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/update_profile_screen.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../../../modules/timeline/view/widget/timeline_calendar.dart';
import '../../../../global/view/widget/app_margin.dart';
import '../../controller/global_profile_controller.dart';
import '../../controller/profile_image_selected_controller.dart';
import '../../models/user_profile.dart';
import 'change_password.dart';
import 'tab_bar_body/change_email/chnage_email.dart';



class UpdateProfileActionView extends StatelessWidget {
 final UserDetails userDetails;

 const UpdateProfileActionView({super.key,required this.userDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customButtonSheetAppbar(text: "${userDetails.getOrganizationUserDetails?.profile?.firstName??""} ${userDetails.getOrganizationUserDetails?.profile?.lastName??""}", subtext: userDetails.getOrganizationUserDetails?.department?.name??""),
        customSpacerHeight(height: 20),

        ///Edit profile route and action added.
        InkWell(
          onTap: () => _editProfileRoute(userDetails),
          child: _fieldLayout(
            hintText: AppString.text_edit_profile.tr,
            url: Images.EDIT_ICON,
          ),
        ),
        InkWell(
          onTap: () {
            currentPasswordController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
            customAntButtonSheet(context: context, child: ChangeEmailScreen());
          },
          child: _fieldLayout(
            hintText: AppString.text_change_email.tr,
            url: Images.EMAIL_ICON,
          ),
        ),
        InkWell(
          onTap: () {
            currentPasswordController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
            customAntButtonSheet(
              height: 600,
              context: context,
              child: ChangePasswordScreen(),
            );
          },
          child: _fieldLayout(
            hintText: AppString.text_change_password.tr,
            url: Images.KEY_ICON,
          ),
        ),
      ],
    );
  }




 void _editProfileRoute(UserDetails userDetails) {
   ///clear img local path
   Get.find<PikedProfileImgController>().storageForUpload.filePath.value = "";

   _setDataForUpdateChecker(userDetails); ///Save data

   ProfileGlobalController controller =Get.find<ProfileGlobalController>();
   ///Clear controller
   controller.firstName.value = "";
   controller.lastName.value = "";
   controller.address.value = "";
   controller.description.value = "";
   Get.to(()=>UpdateProfileScreen(userDetails: userDetails,));
 }



 void _setDataForUpdateChecker(UserDetails? userDetails) {
   editFirstNameController.text = userDetails?.getOrganizationUserDetails?.profile?.firstName ?? "";
   editLastNameController.text = userDetails?.getOrganizationUserDetails?.profile?.lastName ?? "";
   editAddressController.text = userDetails?.getOrganizationUserDetails?.profile?.address ?? "";
   editPhoneController.text = userDetails?.getOrganizationUserDetails?.profile?.personalNumber ?? "";
   editEmergencyPhoneController.text = userDetails?.getOrganizationUserDetails?.profile?.emergencyNumber ?? "";
   editBioController.text = userDetails?.getOrganizationUserDetails?.profile?.about ?? "";

   //todo
   Get.find<ProfileGlobalController>().editEmployeeIDController.text =  userDetails?.getOrganizationUserDetails?.employeeId??"";

 }



 Widget _fieldLayout({
   required String hintText,
   required String url,
 }) {
   return Padding(
     padding: marginLayout,
     child: Column(
       children: [
         customSpacerHeight(height: 12),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               hintText,
               style: AppStyle.mid_large_text.copyWith(
                 color: AppColor.normalTextColor.withOpacity(0.7),
                 fontSize: Dimensions.fontSizeDefault + 1,
               ),
             ),
             Image.asset(
               url,
               height: AppLayout.getHeight(50),
               width: AppLayout.getWidth(50),
             ),
           ],
         ),
         customSpacerHeight(height: 12),
         const Divider(
           thickness: 1,
           color: AppColor.disableColor,
         ),
       ],
     ),
   );
 }

}










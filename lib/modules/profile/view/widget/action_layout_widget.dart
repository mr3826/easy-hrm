import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import 'package:payrun_mobile/utils/utils.dart';
import '../../../timeline/view/widget/timeline_calendar.dart';
import '../../controller/profile_image_selected_controller.dart';
import '../../controller/user_profile_controller.dart';
import '../../model/user_profile.dart';
import '../screen/change_password.dart';
import '../screen/chnage_email.dart';

Widget actionLayout({
  required String userName,
  required String departmentText,
  required VoidCallback editAction,
  VoidCallback? changePassAction,
  required BuildContext context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customButtonSheetAppbar(text: userName, subtext: departmentText),
      customSpacerHeight(height: 20),

      ///Edit profile route and action added.
      InkWell(
        onTap: () => _editProfileRoute(),
        child: _fieldLayout(
          hintText: AppString.text_edit_profile.tr,
          onAction: editAction,
          url: Images.EDIT_ICON,
        ),
      ),
      InkWell(
        onTap: () {
          currentPasswordController.clear();
          newPasswordController.clear();
          confirmPasswordController.clear();
          customAntButtonSheet(
              context: context, child: ChangeEmailScreen());
        },
        child: _fieldLayout(
          hintText: AppString.text_change_email.tr,
          onAction: changePassAction,
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
          onAction: changePassAction,
          url: Images.KEY_ICON,
        ),
      ),
    ],
  );
}

void _editProfileRoute() {
  ///clear img local path
  Get.find<PikedProfileImgController>().storageForUpload.filePath.value = "";

  UserProfileController controller = Get.find<UserProfileController>();
  final userDetails = controller.userDetails?.getOrganizationUserDetails?.profile;
  _setDataForUpdateChecker(userDetails); ///Save data




  ///Clear controller
  controller.firstName.value = "";
  controller.lastName.value = "";
  controller.address.value = "";
  controller.description.value = "";
  Get.toNamed(Routes.EDIT_PROFILE_SCREEN);
}



void _setDataForUpdateChecker(Profile? userDetails) {
  editFirstNameController.text = userDetails?.firstName ?? "";
  editLastNameController.text = userDetails?.lastName ?? "";
  editAddressController.text = userDetails?.address ?? "";
  editPhoneController.text = userDetails?.personalNumber ?? "";
  editEmergencyPhoneController.text = userDetails?.emergencyNumber ?? "";
  editBioController.text = userDetails?.about ?? "";

  //todo
  Get.find<UserProfileController>().editEmployeeIDController.text =  Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.employeeId??"";

}



Widget _fieldLayout({
  required String hintText,
  required VoidCallback? onAction,
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

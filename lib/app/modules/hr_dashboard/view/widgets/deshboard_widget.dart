import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/global/view/widgets/custom_network_image.dart';
import 'package:payrun_mobile/app/modules/profile/controller/global_profile_controller.dart';
import '../../../../../common/widget/custom_dialog.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../common/widget/custom_svg_image.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/utils.dart';

userInfoAppbarLayout(BuildContext context) {
  final double statusBarHeight = MediaQuery.of(context).viewPadding.top;
  return Padding(
    padding: EdgeInsets.only(top: statusBarHeight),
    child: Row(
      children: [
        _userImageLayout(
          Get.find<ProfileGlobalController>().employeeImeKey.value,
          Get.find<ProfileGlobalController>().employeeName.value,
        ),
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
              Get.find<ProfileGlobalController>().employeeName.value,
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

_userImageLayout(String imgUrl, String error) {
  return CircularNetworkImage(
    imageUrl: buildImgIxUrl(imagePath: imgUrl, isPublic: true),
    errorText: getInitials(error),
    radius: 22,
  );
}

//copy
void showShareDialog({
  required String titleText,
  required String description,
  required Function copyAction,
  required Function whatAppAction,
  required Function slackAction,
  required Function linkDinAction,
  required Function messengerAction,
}) {
  displayCustomDialog(
    context: Get.context!,
    customIconWidget: SizedBox(
      height: 65,
      width: 65,
      child: customSvgImage(imageUrl: Images.SHEAR_JOB_ICON),
    ),
    customTitleWidget: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDialogTitle(
            "${AppString.text_share.tr} ", AppColor.normalTextColor),
        _buildDialogTitle(titleText, AppColor.secondaryColor),
      ],
    ),
    customDescriptionWidget: Column(
      children: [
        Center(
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: AppStyle.normal_text.copyWith(
              color: AppColor.hintColor,
              fontSize: Dimensions.fontSizeSmall - 1,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 14, top: 14, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildShareOption(Images.COPY_ICON, () => copyAction),
              _buildShareOption(Images.WHATS_APPS_ICON, () => whatAppAction),
              _buildShareOption(Images.SLACK_ICON, () => slackAction),
              _buildShareOption(Images.LINKDIN, () => linkDinAction),
              _buildShareOption(Images.MESSENGER_ICON, () => messengerAction,
                  height: 33, width: 33),
            ],
          ),
        )
      ],
    ),
    customActionButtons: _buildCancelAction(),
  );
}

Widget _buildDialogTitle(String text, Color color) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: AppStyle.normal_text_grey.copyWith(
      color: color,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
  );
}

Widget _buildShareOption(String imgUrl, VoidCallback onClick,
    {double? height, double? width}) {
  return GestureDetector(
    onTap: onClick,
    child: SizedBox(
      height: height ?? 40,
      width: width ?? 40,
      child: customSvgImage(imageUrl: imgUrl),
    ),
  );
}

Widget _buildCancelAction() {
  return GestureDetector(
    onTap: () => Get.back(canPop: false),
    child: Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Container(
        height: AppLayout.getHeight(40),
        width: AppLayout.getWidth(140),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            width: 1,
            color: AppColor.hintColor.withOpacity(0.4),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Text(
              AppString.text_cancel.tr,
              textAlign: TextAlign.center,
              style: AppStyle.normal_text.copyWith(
                color: AppColor.normalTextColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

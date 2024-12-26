import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_svg_image.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/custom_network_img.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/more_info_text_divider.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../../common/widget/custom_dialog.dart';
import '../../../../../../../common/widget/custom_title_text_widget.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';

class BuildAllCandidates extends StatelessWidget {
  const BuildAllCandidates({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return LayoutBuilder(
            builder: (context, constraints) {
              double imageSize = constraints.maxWidth * 0.15;
              double paddingSize = constraints.maxWidth * 0.04;
              return Padding(
                padding: _getPadding(), // Use a dedicated method for padding
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileImage(imageSize),
                    SizedBox(width: paddingSize),
                    _buildCandidateInfo(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  EdgeInsets _getPadding() {
    return marginLayout.copyWith(bottom: 18, top: 15);
  }

  Widget _buildProfileImage(double size) {
    return CustomNetworkImage(
      isCircleImage: true,
      radius: size / 2,
      imageUrl: "https://media.istockphoto.com/id/964216874/photo/worried-programmer-having-problems-while-working-on-new-computer-program-in-the-office.jpg?s=612x612&w=0&k=20&c=evobpENGDXI4uijYb7JOlrmxfl3l1wSdDzKZDZaioZg=",
    );
  }

  Widget _buildCandidateInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText(),
          const SizedBox(height: 2),
          _buildJobAppliedRow(),
          _buildInterviewTag(),
        ],
      ),
    );
  }

  // Method to build candidate title text
  Widget _buildTitleText() {
    return customTitleText(
      text: "Agens Neilson",
      textStyle: AppStyle.mid_large_text.copyWith(
        color: AppColor.secondaryColor,
        fontSize: Dimensions.fontSizeMid - 1,
      ),
    );
  }

  // Method to build the "Applied for" job info with more icon
  Widget _buildJobAppliedRow() {
    return Row(
      children: [
        Text(
          "Applied for: ",
          style: AppStyle.normal_text.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeSmall + 1,
          ),
        ),
        Expanded(
          child: Text(
            "Node.js developer",
            maxLines: 2,
            style: AppStyle.normal_text.copyWith(
              color: AppColor.normalTextColor,
              overflow: TextOverflow.ellipsis,
              fontSize: Dimensions.fontSizeSmall + 1,
            ),
          ),
        ),
        customSpacerWidth(width: 4),
        GestureDetector(
          onTap: () {
            customButtonSheet(height: .5, context: Get.context!, child: _buildMoreView());
          },
          child: Icon(
            Icons.more_horiz,
            color: AppColor.normalTextColor.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  // Method to build the interview tag
  Widget _buildInterviewTag() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.interViewCandidatesColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
        child: Text(
          "Interview",
          style: AppStyle.normal_text.copyWith(
            color: AppColor.interViewCandidatesColor,
          ),
        ),
      ),
    );
  }



  Widget _buildMoreView() {
    return Column(
      children: [
        customButtonSheetAppbar(
            text: "Agens Nelson", subtext: "email@gmail.com"),
        customMoreInfoTextWithDiver(
            text: AppString.text_edit.tr,
            onTap: () => Get.toNamed(Routes.EDIT_CANDIDATES),
            trailing: Image.asset(Images.EDIT_ICON)),
        customMoreInfoTextWithDiver(
            text: AppString.text_share.tr,
            onTap: () {
              _showShareDialog();
            },
            trailing: Icon(
              Icons.share,
              color: AppColor.normalTextColor.withOpacity(0.4),
              size: 24,
            )),
        customMoreInfoTextWithDiver(
            text: AppString.text_remove.tr,
            onTap: () {
              _showRemoveDialog();
            },
            trailing: Icon(
              Icons.delete_outline,
              color: AppColor.normalTextColor.withOpacity(0.4),
              size: 30,
            )),
      ],
    );
  }


  void _showShareDialog() {
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
          _buildDialogTitle("${AppString.text_share.tr} ", AppColor.normalTextColor),
          _buildDialogTitle(AppString.text_candidate.replaceAll("s", ""), AppColor.secondaryColor),
        ],
      ),
      customDescriptionWidget: Column(
        children: [
          Center(
            child: Text(
              AppString.text_only_admin_and_etc.tr,
              textAlign: TextAlign.center,
              style: AppStyle.normal_text.copyWith(
                color: AppColor.hintColor,
                fontSize: Dimensions.fontSizeSmall - 1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildShareOption(Images.COPY_ICON, () {}),
                _buildShareOption(Images.WHATS_APPS_ICON, () {}),
                _buildShareOption(Images.SLACK_ICON, () {}),
                _buildShareOption(Images.LINKDIN, () {}),
                _buildShareOption(Images.MESSENGER_ICON, () {},
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
      style: AppStyle.mid_large_text.copyWith(
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
        padding: const EdgeInsets.only(top: 25.0),
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

  void _showRemoveDialog() {
    return displayCustomDialog(
        context: Get.context!,
        customIconWidget: SizedBox(
            height: 65,
            width: 65,
            child: customSvgImage(imageUrl: Images.REMOVE_ICON)),
        titleText: AppString.text_remove_candidate.tr,
        descriptionText:
            AppString.text_are_you_sure_deleted_candidate.tr,
        customActionButtons: CustomDoubleAppButton(
          onAction: () {},
          cancelAction: () => Get.back(canPop: false),
          btnColor: AppColor.errorColorLight,
          buttonText: AppString.text_remove.tr,
        ));
  }
}

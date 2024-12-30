import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/custom_network_img.dart';
import 'package:payrun_mobile/routes/app_pages.dart';
import '../../../../../../../../common/widget/custom_buttom_sheet.dart';
import '../../../../../../../../common/widget/hr_deshboard/more_info_text_divider.dart';
import '../../../../../../../../utils/app_color.dart';
import '../../../../../../../../utils/app_string.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import '../../../../../../../../utils/images.dart';

class CandidateList extends StatelessWidget {
  const CandidateList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.toNamed(Routes.CANDIDATES_DETAILS),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double imageSize = constraints.maxWidth * 0.15;
                double paddingSize = constraints.maxWidth * 0.03;
                return Padding(
                  padding: _getPadding(), // Use a dedicated method for padding
                  child: Container(
                    decoration: _containerStyle(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          _buildProfileImage(imageSize),
                          SizedBox(width: paddingSize),
                          _buildCandidateInfo(context),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  EdgeInsets _getPadding() {
    return marginLayout.copyWith(top: 15);
  }

  Widget _buildProfileImage(double size) {
    return CustomNetworkImage(
      isCircleImage: true,
      radius: size / 2.7,
      borderColor: Colors.transparent,
      imageUrl:
          "https://media.istockphoto.com/id/964216874/photo/worried-programmer-having-problems-while-working-on-new-computer-program-in-the-office.jpg?s=612x612&w=0&k=20&c=evobpENGDXI4uijYb7JOlrmxfl3l1wSdDzKZDZaioZg=",
    );
  }

  Widget _buildCandidateInfo(context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleText(),
                const SizedBox(height: 2),
                _buildEmailText(),
              ],
            ),
          ),
          customSpacerWidth(width: 4),
          GestureDetector(
            onTap: () {
              customButtonSheet(
                  height: .5, context: context!, child: _buildMoreView());
            },
            child: Icon(
              Icons.more_horiz,
              color: AppColor.normalTextColor.withOpacity(0.5),
            ),
          ),
          customSpacerWidth(width: 8),
        ],
      ),
    );
  }

  // Method to build candidate title text
  Widget _buildTitleText() {
    return Text(
      "Agens Neilson",
      maxLines: 2,
      style: AppStyle.mid_large_text.copyWith(
        color: AppColor.secondaryColor,
        overflow: TextOverflow.ellipsis,
        fontSize: Dimensions.fontSizeMid - 1,
      ),
    );
  }

  Widget _buildEmailText() {
    return Text(
      "email@demo.com",
      maxLines: 2,
      style: AppStyle.normal_text.copyWith(
        color: AppColor.hintColor,
        overflow: TextOverflow.ellipsis,
        fontSize: Dimensions.fontSizeSmall + 1,
      ),
    );
  }

  _containerStyle() {
    return BoxDecoration(
        border: Border.all(width: 1, color: AppColor.disableColor),
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault));
  }

  Widget _buildMoreView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeaderSection(),
          _buildMoreInfoSection(
            text: AppString.text_move_to_the_next.tr,
            onTap: () {},
            trailing: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                CupertinoIcons.arrow_turn_right_down,
                color: AppColor.normalTextColor.withOpacity(0.4),
                size: 24,
              ),
            ),
          ),
          _buildMoreInfoSection(
            text: AppString.text_move_anywhere.tr,
            onTap: () {},
            trailing: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(Images.MOVE_ANY_WHERE_ICON),
            ),
          ),
          _buildMoreInfoSection(
            text: AppString.text_remove_candidate.tr,
            onTap: () {},
            trailing: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.delete_outline,
                color: AppColor.normalTextColor.withOpacity(0.4),
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

// A method to build the header section with profile image and name.
  Widget _buildHeaderSection() {
    return customButtonSheetAppbar(
      height: 150,
      titleWidget: Column(
        children: [
          const Center(
            child: CustomNetworkImage(
              isCircleImage: true,
              radius: 30,
              borderColor: Colors.transparent,
              imageUrl:
                  "https://media.istockphoto.com/id/964216874/photo/worried-programmer-having-problems-while-working-on-new-computer-program-in-the-office.jpg?s=612x612&w=0&k=20&c=evobpENGDXI4uijYb7JOlrmxfl3l1wSdDzKZDZaioZg=",
            ),
          ),
          customSpacerHeight(height: 4),
          Text(
            "Agens Nelson",
            style: AppStyle.mid_large_text.copyWith(
              color: AppColor.secondaryColor,
              fontWeight: FontWeight.w700,
              fontSize: Dimensions.fontSizeDefault + 3,
            ),
          ),
        ],
      ),
      subtext: "email@gmail.com",
    );
  }

// A method to build individual more info items with divider.
  Widget _buildMoreInfoSection({
    required String text,
    required VoidCallback onTap,
    required Widget trailing,
  }) {
    return customMoreInfoTextWithDiver(
      text: text,
      onTap: onTap,
      trailing: trailing,
    );
  }
}

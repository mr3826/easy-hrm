import 'package:flutter/material.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/hr_deshboard/custom_network_img.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import '../../../../../../modules/leave/presentation/view/widget/custom_title_text_widget.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';

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
      imageUrl:
          "https://media.istockphoto.com/id/964216874/photo/worried-programmer-having-problems-while-working-on-new-computer-program-in-the-office.jpg?s=612x612&w=0&k=20&c=evobpENGDXI4uijYb7JOlrmxfl3l1wSdDzKZDZaioZg=",
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
          onTap: () {},
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
}

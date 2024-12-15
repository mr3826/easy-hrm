import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../common/widget/custom_network_image.dart';
import '../../../../../common/widget/custom_spacer.dart';
import '../../../../../common/widget/success_message.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/utils.dart';
import '../../../../timeline/view/widget/timeline_calendar.dart';
import '../../widget/action_layout_widget.dart';
import '../../widget/common_widget.dart';
import '../../widget/expanded_text_layout.dart';
import '../../widget/user_info_section_layout.dart';
import 'custom.dart';

class ProfileUserInformation extends StatelessWidget {
  final UserInformation? userInformation;
  const ProfileUserInformation({super.key, this.userInformation});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                userInformation?.departmentName ?? "No added yet",
                maxLines: 2, // Replace with dynamic username
                style: AppStyle.mid_large_text
                    .copyWith(color: AppColor.secondaryColor),
                overflow:
                    TextOverflow.ellipsis, // Ensures long text is truncated
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              height: 17,
              width: 17,
              child: GestureDetector(
                onTap: () {
                  customAntButtonSheet(
                      context: context,
                      child: actionLayout(
                          context: context,
                          userName: userInformation?.userName ?? "",
                          departmentText: userInformation?.departmentName ?? "",
                          editAction: () {},
                          changePassAction: () {}));
                },
                child: Image.asset(Images.EDIT_ICON),
              ),
            ),
          ],
        ),

        Text(
          userInformation?.employeeId ?? "",
          style: AppStyle.normal_text_black
              .copyWith(fontWeight: FontWeight.w300, color: AppColor.hintColor),
        ),
        Text(
          userInformation?.departmentName ?? "",
          style: AppStyle.normal_text_black
              .copyWith(fontWeight: FontWeight.w300, color: AppColor.hintColor),
        ),

        /// Status
        if (userInformation?.employmentStatus != null &&
            userInformation!.employmentStatus!.isNotEmpty)
          Wrap(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: employmentContractStatus(),
              ),
              customSpacerWidth(width: 8),

              /// Status
              FittedBox(
                fit: BoxFit.scaleDown,
                child: employmentStatus(),
              ),
            ],
          ),
      ],
    );
  }
}


class BuildMonthlyGoal extends StatelessWidget {
  final UserInformation? userInformation;
  const BuildMonthlyGoal({super.key, this.userInformation});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          if(userInformation?.leaveBalance!=null && userInformation!.leaveBalance!.isNotEmpty)
            infoTextLayout(
                dynamicText:
                formatToTwoDecimalPlaces(userInformation?.leaveBalance ?? ""),
                staticText: AppString.text_leave_balance.tr)..[
            _divider()
            ],

          if(userInformation?.monthGoal!=null && userInformation!.monthGoal!.isNotEmpty)
          infoTextLayout(
              dynamicText: userInformation?.monthGoal ?? "",
              staticText: AppString.text_monthly_goal.tr)..[
          _divider()
          ],

          if(userInformation?.loggedTime!=null && userInformation!.loggedTime!.isNotEmpty)
          infoTextLayout(
              dynamicText: userInformation?.loggedTime ?? "",
              staticText: AppString.text_logged_time.tr),
        ],
      ),
    );
  }
}


class BuildDescription extends StatelessWidget {
  final String? description;
  const BuildDescription({super.key, this.description});

  @override
  Widget build(BuildContext context) {

    if(description!.isNotEmpty){
      final wordCount = description?.split(' ').length ?? 0;
      if (wordCount > 20) {
        return ExpandedText(
          text: description ?? "",
        );
      } else {
        return Text(
          description ?? "",
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor, fontSize: Dimensions.fontSizeDefault),
        );
      }
    }else{
      return const SizedBox.shrink();
    }
  }
}



class BuildEmailWithCopied extends StatelessWidget {
  final String email;
  const BuildEmailWithCopied({super.key,required this.email});

  @override
  Widget build(BuildContext context) {

    if(email.isNotEmpty){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppString.text_email.tr,
            style: AppStyle.normal_text_grey.copyWith(
              color: AppColor.normalTextColor,
              fontSize: Dimensions.fontSizeDefault + 1,
            ),
          ),
          customSpacerHeight(height: 2),
          Row(
            children: [
              Flexible(
                child: Text(
                  email ?? "",
                  maxLines: 2,
                  style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.hintColor,
                      overflow: TextOverflow.ellipsis,
                      fontSize: Dimensions.fontSizeDefault - 1),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 17,
                width: 17,
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: email ?? ""));
                    showSuccessMessage(message: "Copied");
                  },
                  child: const Icon(
                    Icons.copy,
                    size: 14,
                    color: AppColor.secondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }else{
      return const SizedBox.shrink();

    }

  }
}


Widget buildPhoneNumberText({required String personalNumber}) {
  if(personalNumber.isNotEmpty){
    return userInfoSectionLayout(
      staticText: AppString.text_personal_number.tr,
      dynamicText:personalNumber,
    );
  }else{
    return const SizedBox.shrink();
  }
}


Widget buildEmergencyPhoneNumber({required String emergencyPersonalNumber}) {
  if(emergencyPersonalNumber.isNotEmpty){
    return userInfoSectionLayout(
      staticText: AppString.text_emergency_number.tr,
      dynamicText: emergencyPersonalNumber,
    );
  }else{
    return const SizedBox.shrink();
  }

}

Widget buildAddressText({required String address}) {
  if(address.isNotEmpty){
    return userInfoSectionLayout(
        staticText: AppString.text_address.tr,
        dynamicText: address);
  }else{
    return const SizedBox.shrink();
  }

}



Widget buildUserImageLayout({double? height,required String errorText,required String url}) {
  return CustomNetworkImage(
    errorText:errorText,
    height: height ?? 36,
    isPublic: true,
    profileImageKey: url,
    imgUrlKey: '',
  );
}



_divider() {
  return Container(
    width: 1,
    height: 30,
    color: AppColor.disableColor.withOpacity(0.7),
  );
}




class BuildDepartmentWithEmployeeStatus extends StatelessWidget {

  const BuildDepartmentWithEmployeeStatus({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}


























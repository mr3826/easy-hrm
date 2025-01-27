import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_status_button.dart';
import 'package:payrun_mobile/enum.dart';
import 'package:payrun_mobile/app/modules/auth/view/screens/otp_screen.dart';
import 'package:payrun_mobile/app/modules/profile/controller/log_out_controller.dart';
import 'package:payrun_mobile/app/modules/profile/view/widgets/update_profile_action_view.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timeline_calendar.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../global/view/widget/app_margin.dart';
import '../../../../global/view/widgets/custom_network_image.dart';
import '../../../../../common/widget/custom_drawer.dart';
import '../../../../../utils/utils.dart';
import '../../controller/global_profile_controller.dart';
import '../../models/user_log_history.dart';
import '../../models/user_profile.dart';
import 'language_widget.dart';
import 'organization_widget.dart';




class UserInfoLayout extends StatelessWidget {
  final UserDetails information;
  final String? editIconUrl;
  const UserInfoLayout({super.key, required this.information, this.editIconUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: marginLayout.copyWith(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _userImageLayout(),
          customSpacerWidth(width: 20),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  ///User name and department
                  _userNameAndDptLayout(context),
                ],
              ),
            ),
          ),
          customSpacerWidth(width: 18),
        ],
      ),
    );
  }

  _userImageLayout({double? height}) {
    String userName = "${information.getOrganizationUserDetails?.profile?.firstName ?? ""} ${information.getOrganizationUserDetails?.profile?.lastName ?? ""}";
    return CircularNetworkImage(
      errorText: getInitials(userName),
      radius: height ?? 28,
      imageUrl: buildImgIxUrl(
          imagePath: information.getOrganizationUserDetails?.profile?.image ?? "",
          isPublic: true),
    );
  }

  _userNameAndDptLayout(BuildContext context) {
    String userName = "${information.getOrganizationUserDetails?.profile?.firstName ?? ""} ${information.getOrganizationUserDetails?.profile?.lastName ?? ""}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
                child: Text(
              userName,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  overflow: TextOverflow.ellipsis),
              maxLines: 2,
            )),
            customSpacerWidth(width: 8),
            if (editIconUrl != null)
              GestureDetector(
                onTap: ()=>_updateProfileAction(context),
                child: SizedBox(
                    height: AppLayout.getHeight(17),
                    width: AppLayout.getWidth(17),
                    child: Image.asset(editIconUrl??"")),
              )
          ],
        ),

        Text(
          information.getOrganizationUserDetails?.department?.name ?? "",
          style: AppStyle.normal_text_grey,
        ),
        customSpacerHeight(height: 6),

        /// Status
        if (information.getOrganizationUserDetails?.employmentStatus != null)
          Wrap(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: _employmentContractStatus(),
              ),
              customSpacerWidth(width: 12),
              if (information.getOrganizationUserDetails?.status != null)
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: employmentStatus(
                      information.getOrganizationUserDetails?.status ?? ""),
                ),
            ],
          ),
      ],
    );
  }

  _employmentContractStatus() {
    EmploymentStatusData? data =
        information.getOrganizationUserDetails?.employmentStatus;
    // Return an empty container if employment status or its color is null
    if (data?.color == null || data!.color!.isEmpty) {
      return const SizedBox.shrink();
    }
    // Safely parse the color code
    final colorCodeString = data.color?.replaceAll("#", "");
    final colorCode = int.tryParse("0xFF$colorCodeString");

    // Return an empty container if color code is invalid
    if (colorCode == null) {
      return const SizedBox.shrink();
    }
    return CustomStatusButton(
      bgColor: Color(colorCode).withOpacity(.2),
      textColor: Color(colorCode),
      text: data.name ?? "",
    );
  }


  _updateProfileAction(BuildContext context) {
    customAntButtonSheet(
        context: context,
        child: UpdateProfileActionView(
          userDetails: information));
  }



}



class LeaveStatusGoal extends StatelessWidget {
  final UserLogHistory userLogHistory;

  const LeaveStatusGoal({super.key,required this.userLogHistory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: marginLayout,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _infoTextLayout(
              value: formatToTwoDecimalPlaces(userLogHistory
                  .geTimelogAndLeaveAvailabilityForApp?.balanceLeave ??
                  ""),
              label: AppString.text_leave_balance.tr),
          _divider(),
          _infoTextLayout(
              value: userLogHistory
                  .geTimelogAndLeaveAvailabilityForApp?.totalSchedule ??
                  "",
              label: AppString.text_monthly_goal.tr),
          _divider(),
          _infoTextLayout(
              value: userLogHistory
                  .geTimelogAndLeaveAvailabilityForApp?.totalLogged ??
                  "",
              label: AppString.text_logged_time.tr),
        ],
      ),
    );
  }

  _infoTextLayout({required String value, required String label}) {
    return Column(
      children: [
        Text(
          value,
          style: AppStyle.normal_text
              .copyWith(color: AppColor.normalTextColor,fontSize: Dimensions.fontSizeMid),
        ),
        Text(
          label,
          style: AppStyle.mid_large_text.copyWith(
              fontSize: Dimensions.fontSizeSmall-1,
              color: AppColor.hintColor),
        )
      ],
    );
  }

  _divider() {
    return Container(
      width: 1,
      height: 30,
      color: AppColor.disableColor,
    );
  }

}







logoutLayout(context) {
  return GestureDetector(
    onTap: () {
      showCustomAlertDialog(
          context: context,
          onConfirm: () {
            Get.find<LogoutController>().logout();
          },
          iconData: Icons.logout,
          titleText: AppString.text_are_you_sure.tr,
          descriptionText: "${AppString.text_if_you_do_this_etc.tr}.",
          iconBackgroundColor: AppColor.errorColorLight,
          confirmButtonColor: AppColor.errorColorLight,
          confirmButtonText: AppString.text_log_out.tr,
          extraInfoText: "",
          descriptionFontSize: Dimensions.fontSizeDefault,
          confirmButtonChild: Obx(() => logoutTextLayout()));
    },
    child: Container(
      height: AppLayout.getHeight(80),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: AppColor.hintColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: marginLayout.copyWith(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.logout_rounded,
                  color: AppColor.cardColor,
                  size: 28,
                ),
                customSpacerWidth(width: 12),
                Text(
                  AppString.text_log_out.tr,
                  style: AppStyle.mid_large_text
                      .copyWith(color: AppColor.cardColor),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

languageLayout(context) {
  return InkWell(
    onTap: () {
      _customButtonSheet(context: context, child: LanguageLayout());
    },
    child: Container(
      padding: marginLayout.copyWith(left: 8, right: 8),
      child: Row(
        children: [
          SizedBox(height: 20, child: Image.asset(_getLanguageFlag())),
          customSpacerWidth(width: 8),
          Row(
            children: [
              Text(
                AppString.text_language.tr,
                style: AppStyle.mid_large_text.copyWith(
                    fontSize: Dimensions.fontSizeDefault + 1,
                    color: AppColor.hintColor),
              ),
              Text(
                _getLanguageName(),
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.normalTextColor,
                    fontSize: Dimensions.fontSizeDefault + 1),
              )
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColor.hintColor,
            size: 20,
          )
        ],
      ),
    ),
  );
}

_organisationLayout(context,UserDetails userDetails) {
  ProfileGlobalController controller=Get.find<ProfileGlobalController>();
  return Padding(
    padding: marginLayout,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.yourOrganizationText.tr,
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor,
              fontSize: Dimensions.fontSizeDefault,
              letterSpacing: 3.5),
        ),
        customSpacerHeight(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            organisationLogoLayout(userDetails),
            customSpacerWidth(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 userDetails.getOrganizationUserDetails
                          ?.organization?.name ??
                      "Not added yet",
                  style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.normalTextColor,
                      fontWeight: FontWeight.w900,
                      fontSize: Dimensions.fontSizeDefault + 1),
                ),
                customSpacerHeight(height: 6),
                if (controller.employeeWorkHistory?.getOrganizationUserHistory
                            ?.designationHistories !=
                        null &&
                   controller.employeeWorkHistory!.getOrganizationUserHistory!
                        .designationHistories!.isNotEmpty)
                  Text(
                    controller.employeeWorkHistory?.getOrganizationUserHistory
                            ?.designationHistories?[0].designation?.name ??
                        "",
                    style: AppStyle.mid_large_text.copyWith(
                      color: AppColor.normalTextColor,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                customSpacerHeight(height: 6),
                GestureDetector(
                  onTap: () {
                    _customButtonSheet(
                        context: context, child: OrganisationView(orgId: userDetails.getOrganizationUserDetails?.organization?.id.toString()??"",));
                  },
                  child: Text(
                    AppString.text_swich_organisation.tr,
                    style: AppStyle.normal_text_grey.copyWith(
                        color: AppColor.secondaryColor,
                        fontSize: Dimensions.fontSizeDefault - 1),
                  ),
                )
              ],
            )
          ],
        )
      ],
    ),
  );
}

_profileInfoDrawerLayout(UserDetails userDetails) {
  ProfileGlobalController controller = Get.find<ProfileGlobalController>();
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 1),
        color: AppColor.bgColorWithPrimary.withOpacity(0.6),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20.0, bottom: 20, left: 12, right: 12),
        child: Center(
          child: Column(
            children: [
               _userProfileImgLayout(userDetails),
              customSpacerHeight(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${userDetails.getOrganizationUserDetails?.profile?.firstName ?? ""} ${userDetails.getOrganizationUserDetails?.profile?.lastName ?? ""}",
                    style: AppStyle.mid_large_text
                        .copyWith(color: AppColor.normalTextColor),
                  ),
                  if (controller.employeeWorkHistory?.getOrganizationUserHistory
                              ?.designationHistories !=
                          null &&
                      controller
                          .employeeWorkHistory!
                          .getOrganizationUserHistory!
                          .designationHistories!
                          .isNotEmpty)
                    Text(
                      controller.employeeWorkHistory?.getOrganizationUserHistory
                              ?.designationHistories?[0].designation?.name ??
                          "Not designation",
                      style: AppStyle.normal_text_grey
                          .copyWith(fontSize: Dimensions.fontSizeDefault - 1),
                    ),
                  customSpacerHeight(height: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

_userProfileImgLayout(UserDetails userDetails) {
    String userName="${userDetails.getOrganizationUserDetails?.profile?.firstName} ${userDetails.getOrganizationUserDetails?.profile?.lastName}";
    return CircularNetworkImage(
      errorText: getInitials(userName),
      radius:  28,
      imageUrl:buildImgIxUrl(imgKey: userDetails.getOrganizationUserDetails?.profile?.image,isPublic: true),
    );
}







employmentStatus(String? employmentStatus) {
  if (employmentStatus == null) {
    return Container();
  }
  if (employmentStatus.toLowerCase() == EmploymentStatus.active.name) {
    return CustomStatusButton(
      statusIcon: Icons.check_circle,
      text: EmploymentStatus.active.name.capitalizeFirst.toString(),
      bgColor: AppColor.successColor.withOpacity(.2),
      textColor: AppColor.successColor,
    );
  } else if (employmentStatus.toLowerCase() == EmploymentStatus.inactive.name) {
    return CustomStatusButton(
      statusIcon: Icons.stop_circle_outlined,
      text: EmploymentStatus.inactive.name.capitalizeFirst.toString(),
      bgColor: AppColor.disableColor.withOpacity(.2),
      textColor: Colors.black87,
    );
  } else if (employmentStatus.toLowerCase() == EmploymentStatus.invited.name) {
    return CustomStatusButton(
      statusIcon: Icons.send,
      text: EmploymentStatus.invited.name.capitalizeFirst.toString(),
      bgColor: AppColor.pendingColor.withOpacity(.2),
      textColor: AppColor.pendingColor,
    );
  } else {
    return Container();
  }
}

organisationLogoLayout(UserDetails userDetails) {
  return CircularNetworkImage(
    radius: AppLayout.getHeight(25),
    imageUrl: buildImgIxUrl(
        imgKey:
            "${userDetails?.getOrganizationUserDetails?.organization?.organizationSetting?.logoIconKey}",
        isPublic: true,
        fileDirectory: "profile_images"),
    errorText: getInitials(
            userDetails
            .getOrganizationUserDetails
            ?.organization!
            .name ??
        ""),
    borderColor: Colors.transparent,
  );
}

endDrawer(BuildContext context,UserDetails userDetails) {
  return Drawer(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customSpacerHeight(height: 40),
        _profileInfoDrawerLayout(userDetails),
        customSpacerHeight(height: 40),
        _organisationLayout(context,userDetails),
        const Spacer(),
        languageLayout(context),
        customSpacerHeight(height: 30),
        logoutLayout(context)
      ],
    ),
  );
}

logoutTextLayout() {
  return Get.find<LogoutController>().isLogoutLoading.value
      ? const CupertinoActivityIndicator(
          color: AppColor.cardColor,
        )
      : Text(
          AppString.text_log_out.tr,
          style: AppStyle.normal_text_grey.copyWith(
              fontSize: Dimensions.fontSizeDefault + 1,
              color: AppColor.cardColor),
        );
}

void _customButtonSheet({context, child}) {
  return showCustomAtmBtnSheet(
      context: context,
      child: Material(
        color: AppColor.noColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radiusMid),
                topLeft: Radius.circular(Dimensions.radiusMid)),
            color: AppColor.cardColor,
          ),
          child: child,
        ),
      ));
}

String _getLanguageName() {
  if (GetStorage().read("languageCode") != null) {
    switch (GetStorage().read("languageCode")) {
      case "en":
        {
          return "English";
        }
      case "no":
        {
          return "Norwegian";
        }
      default:
        return "English";
    }
  }
  return "English";
}

List languageFlagIndex = [Images.FLAG_PNG, Images.NOEWAYFLAG];

String _getLanguageFlag() {
  if (GetStorage().read("languageCode") != null) {
    switch (GetStorage().read("languageCode")) {
      case "en":
        {
          return Images.FLAG_PNG;
        }
      case "no":
        {
          return Images.NOEWAYFLAG;
        }
      default:
        return Images.FLAG_PNG;
    }
  }
  return Images.FLAG_PNG;
}

horizontalDivider() {
  return const Padding(
    padding: EdgeInsets.only(top: 15.0, bottom: 15),
    child: Divider(thickness: .6, color: AppColor.disableColor),
  );
}

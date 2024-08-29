import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_network_image.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_status_button.dart';
import 'package:payrun_mobile/enum.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/log_out_controller.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/view/widget/user_info_section_layout.dart';
import 'package:payrun_mobile/modules/timeline/view/widget/timeline_calendar.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../common/widget/custom_drawer.dart';
import '../../../../utils/utils.dart';
import '../widget/action_layout_widget.dart';
import '../widget/expanded_text_layout.dart';
import '../widget/language_widget.dart';
import '../widget/organization_widget.dart';

userInfoLayout() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      userImageLayout(),
      customSpacerWidth(width: 20),
      Expanded(
        child: SizedBox(
          width: double.infinity,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              ///User name and department
              _userNameAndDptLayout(),
            ],
          ),
        ),
      ),
      customSpacerWidth(width: 18),
    ],
  );
}

userProfileImgLayout() {
  return userImageLayout(height: 41);
}

monthlyStatusLayout() {
  var controller = Get.find<UserProfileController>();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      infoTextLayout(
          dynamicText: formatToTwoDecimalPlaces(controller.userLogHistory
                  ?.geTimelogAndLeaveAvailabilityForApp?.balanceLeave ??
              ""),
          staticText: AppString.text_leave_balance.tr),
      divider(),
      infoTextLayout(
          dynamicText: controller.userLogHistory
                  ?.geTimelogAndLeaveAvailabilityForApp?.totalSchedule ??
              "",
          staticText: AppString.text_monthly_goal.tr),
      divider(),
      infoTextLayout(
          dynamicText: controller.userLogHistory
                  ?.geTimelogAndLeaveAvailabilityForApp?.totalLogged ??
              "",
          staticText: AppString.text_logged_time.tr),
    ],
  );
}

infoTextLayout({required dynamicText, required staticText}) {
  return Column(
    children: [
      Text(
        "$dynamicText",
        style:
            AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor),
      ),
      Text(
        "$staticText",
        style: AppStyle.mid_large_text.copyWith(
            fontSize: Dimensions.fontSizeDefault - 3,
            color: AppColor.hintColor),
      )
    ],
  );
}

divider() {
  return Container(
    width: 1,
    height: 20,
    color: AppColor.disableColor,
  );
}

actionBtnLayout(context) {
  return GestureDetector(
    onTap: () => customAntButtonSheet(
        context: context,
        child: actionLayout(
            context: context,
            userName:
                "${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.firstName ?? ""} ${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.lastName ?? ""}",
            departmentText: Get.find<UserProfileController>()
                    .userDetails
                    ?.getOrganizationUserDetails
                    ?.department
                    ?.name ??
                "",
            editAction: () {},
            changePassAction: () {})),
    child: Container(
      height: AppLayout.getHeight(44),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
        color: AppColor.primaryColor,
      ),
      child: Center(
          child: Text(
        AppString.text_action.tr,
        style: AppStyle.mid_large_text
            .copyWith(fontSize: Dimensions.fontSizeDefault + 3),
      )),
    ),
  );
}

descriptionTextLayout() {
  return filterTextLengthLayout();
}

filterTextLengthLayout() {
  String drc = Get.find<UserProfileController>()
          .userDetails
          ?.getOrganizationUserDetails
          ?.profile
          ?.about ??
      '';
  final wordCount = drc.split(' ').length;
  if (wordCount > 20) {
    return ExpandedText(
      text: drc,
    );
  } else {
    return Text(
      drc,
      style: AppStyle.mid_large_text.copyWith(
          color: AppColor.hintColor, fontSize: Dimensions.fontSizeDefault),
    );
  }
}

logoutLayout(context) {
  return GestureDetector(
    onTap: () {
      customDialog(
          context: context,
          saveBtnAction: () {
            Get.find<LogoutController>().logout();
          },
          icon: Icons.logout,
          titleText: AppString.text_are_you_sure.tr,
          subText: "${AppString.text_if_you_do_this_etc.tr}.",
          iconBgColor: AppColor.errorColorLight,
          btnBgColor: AppColor.errorColorLight,
          btnText: AppString.text_log_out.tr,
          drcText: "",
          drcFontSize: Dimensions.fontSizeDefault,
          childForSaveBtn: Obx(() => logoutTextLayout()));
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

organisationLayout(context) {
  var controller = Get.find<UserProfileController>();
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
            organisationLogoLayout(),
            customSpacerWidth(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.userDetails?.getOrganizationUserDetails
                          ?.organization?.orgName ??
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
                        context: context, child: OrganisationView());
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

profileInfoDrawerLayout() {
  var controller = Get.find<UserProfileController>();
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
              userProfileImgLayout(),
              customSpacerHeight(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${controller.userDetails?.getOrganizationUserDetails?.profile?.firstName ?? ""} ${controller.userDetails?.getOrganizationUserDetails?.profile?.lastName ?? "Not added yet"}",
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
                          "Not added yet",
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

phoneNumberText() {
  return userInfoSectionLayout(
    staticText: AppString.text_phone.tr,
    dynamicText: Get.find<UserProfileController>()
            .userDetails
            ?.getOrganizationUserDetails
            ?.profile
            ?.personalNumber ??
        "",
  );
}

emergencyPhoneNumber() {
  return userInfoSectionLayout(
    staticText: AppString.text_emergency_phone.tr,
    dynamicText: Get.find<UserProfileController>()
            .userDetails
            ?.getOrganizationUserDetails
            ?.profile
            ?.emergencyNumber ??
        "",
  );
}

addressText() {
  return userInfoSectionLayout(
      staticText: AppString.text_address.tr,
      dynamicText: Get.find<UserProfileController>()
              .userDetails
              ?.getOrganizationUserDetails
              ?.profile
              ?.address ??
          "");
}

employmentContractStatus() {
  var controller = Get.find<UserProfileController>();
  if (controller.employeeWorkHistory?.getOrganizationUserHistory == null ||
      controller.employeeWorkHistory!.getOrganizationUserHistory!
          .employmentHistories!.isEmpty) {
    return Container();
  }
  String? colorsCode =
      "0xFF${controller.employeeWorkHistory?.getOrganizationUserHistory!.employmentHistories?[0].employmentStatus?.color?.replaceAll("#", "")}";
  return CustomStatusButton(
    bgColor: Color(int.parse(colorsCode)).withOpacity(.2),
    textColor: Color(int.parse(colorsCode)),
    text: controller.employeeWorkHistory?.getOrganizationUserHistory
            ?.employmentHistories?[0].employmentStatus?.name ??
        "",
  );
}

employmentStatus() {
  var controller = Get.find<UserProfileController>();
  if (controller.userDetails?.getOrganizationUserDetails?.status == null) {
    return Container();
  }
  if (controller.userDetails?.getOrganizationUserDetails?.status
          ?.toLowerCase() ==
      EmploymentStatus.active.name) {
    return CustomStatusButton(
      statusIcon: Icons.check_circle,
      text: EmploymentStatus.active.name.capitalizeFirst,
      bgColor: AppColor.successColor.withOpacity(.2),
      textColor: AppColor.successColor,
    );
  } else if (controller.userDetails?.getOrganizationUserDetails?.status
          ?.toLowerCase() ==
      EmploymentStatus.inactive.name) {
    return CustomStatusButton(
      statusIcon: Icons.stop_circle_outlined,
      text: EmploymentStatus.inactive.name.capitalizeFirst,
      bgColor: AppColor.disableColor.withOpacity(.2),
      textColor: Colors.black87,
    );
  } else if (controller.userDetails?.getOrganizationUserDetails?.status
          ?.toLowerCase() ==
      EmploymentStatus.invited.name) {
    return CustomStatusButton(
      statusIcon: Icons.send,
      text: EmploymentStatus.invited.name.capitalizeFirst,
      bgColor: AppColor.pendingColor.withOpacity(.2),
      textColor: AppColor.pendingColor,
    );
  } else {
    return Container();
  }
}

userImageLayout({double? height}) {
  return CustomNetworkImage(
    errorText: (Get.find<UserProfileController>()
                        .userDetails
                        ?.getOrganizationUserDetails
                        ?.profile
                        ?.firstName !=
                    null &&
                Get.find<UserProfileController>()
                    .userDetails!
                    .getOrganizationUserDetails!
                    .profile!
                    .firstName!
                    .isNotEmpty) &&
            (Get.find<UserProfileController>()
                        .userDetails
                        ?.getOrganizationUserDetails
                        ?.profile
                        ?.lastName !=
                    null &&
                Get.find<UserProfileController>()
                    .userDetails!
                    .getOrganizationUserDetails!
                    .profile!
                    .lastName!
                    .isNotEmpty)
        ? "${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.firstName?[0].toUpperCase() ?? ""}"
            "${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.lastName?[0].toUpperCase() ?? ""}"
        : "",
    height: height ?? 32,
    profileImageKey:
        "${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.image}",
    imgUrlKey: '',
  );
}

organisationLogoLayout() {
  return CustomNetworkImage(
    height: AppLayout.getHeight(25),
    fileDir: "profile_images",
    errorText: getFirstTwoLetterFromWord(Get.find<UserProfileController>()
            .userDetails
            ?.getOrganizationUserDetails
            ?.organization!
            .orgName ??
        ""),
    isPublic: true,
    imgUrlKey:
        "${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.organization?.organizationSetting?.logoIconKey}",
    borderColor: Colors.transparent,
    logoUrl: Images.ORG,
  );
}

endDrawer(BuildContext context) {
  return Drawer(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customSpacerHeight(height: 40),
        profileInfoDrawerLayout(),
        customSpacerHeight(height: 40),
        organisationLayout(context),
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

Widget _userNameAndDptLayout() {
  final user = Get.find<UserProfileController>()
      .userDetails
      ?.getOrganizationUserDetails
      ?.profile;
  final department = Get.find<UserProfileController>()
          .userDetails
          ?.getOrganizationUserDetails
          ?.department
          ?.name ??
      "";
  final employmentHistories = Get.find<UserProfileController>()
      .employeeWorkHistory
      ?.getOrganizationUserHistory
      ?.employmentHistories;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "${user?.firstName ?? "Not added yet"} ${user?.lastName ?? ""}",
        style:
            AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor),
      ),
      Text(
        department,
        style: AppStyle.normal_text_grey,
      ),
      customSpacerHeight(height: 6),

      /// Status
      if (employmentHistories != null && employmentHistories.isNotEmpty)
        Wrap(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: employmentContractStatus(),
            ),
            customSpacerWidth(width: 12),

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

horizontalDivider() {
  return const Padding(
    padding: EdgeInsets.only(top: 15.0, bottom: 15),
    child: Divider(thickness: .6, color: AppColor.disableColor),
  );
}

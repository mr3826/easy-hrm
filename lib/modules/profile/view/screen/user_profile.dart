import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_buttom_sheet.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_network_image.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/custom_status_button.dart';
import 'package:payrun_mobile/common/widget/loading_indicator.dart';
import 'package:payrun_mobile/enum.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/view/widget/department_layout_widget.dart';
import 'package:payrun_mobile/modules/profile/view/widget/employee_stauts_layout.dart';
import 'package:payrun_mobile/modules/profile/view/widget/user_info_section_layout.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../widget/action_layout_widget.dart';
import '../widget/chnage_email_notify_layout.dart';
import '../widget/expanded_text_layout.dart';
import '../widget/language_widget.dart';
import '../widget/organisation_widget.dart';
import '../widget/profile_appbar.dart';

class ProfileScreen extends GetView<UserProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => Scaffold(
              appBar: profileAppbar(onAction: () {}),
              endDrawer: endDrawer(context),
              endDrawer: Drawer(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customSpacerHeight(height: 70),
                    _profileInfoDrawerLayout(),
                    customSpacerHeight(height: 40),
                    _organisationLayout(context),
                    const Spacer(),
                    _languageLayout(context),
                    customSpacerHeight(height: 30),
                    _logoutLayout(context)
                  ],
                ),
              ),
              body: Padding(
                padding: marginLayout,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customSpacerHeight(height: 20),
                      _userInfoLayout(),
                      customSpacerHeight(height: 30),
                      _monthlyStatusLayout(),
                      customSpacerHeight(height: 30),
                      _actionBtnLayout(context),
                      customSpacerHeight(height: 25),
                      _descriptionTextLayout(),
                      customSpacerHeight(height: 15),
                      const Divider(
                          thickness: .6, color: AppColor.disableColor),
                      ChangeEmailNotifyLayout(),
                      customSpacerHeight(height: 15),
                      _phoneNumberText(),
                      customSpacerHeight(height: 15),
                      _emergencyPhoneNumber(),
                      customSpacerHeight(height: 15),
                      _addressText(),
                      customSpacerHeight(height: 15),
                      departmentLayout(context),
                      customSpacerHeight(height: 5),
                      employeeStatusLayout(context: context),
                      customSpacerHeight(height: 50),
                    ],
                  ),
                ),
              ),
            ),
        onLoading: const LoadingIndicator());
  }

  _userInfoLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _userImageLayout(),
        customSpacerWidth(width: 18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${controller.userDetails?.getOrganizationUserDetails?.profile?.firstName ?? ""} ${controller.userDetails?.getOrganizationUserDetails?.profile?.lastName ?? ""}",
              style: AppStyle.mid_large_text
                  .copyWith(color: AppColor.normalTextColor),
            ),
            Text(
              controller.userDetails?.getOrganizationUserDetails?.department
                      ?.name ??
                  "",
              style: AppStyle.normal_text_grey,
            ),
            customSpacerHeight(height: 8),
            Row(
              children: [
                _employmentContractStatus(),
                customSpacerWidth(width: 8),
                _employmentStatus(),
              ],
            )
          ],
        ),
      ],
    );
  }

  _userProfileImgLayout() {
    return _userImageLayout(height: 41);
  }

  _monthlyStatusLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _infoTextLayout(
            dynamicText: controller.userLogHistory
                    ?.geTimelogAndLeaveAvailabilityForApp?.balanceLeave ??
                "",
            staticText: AppString.text_leave_balance.tr),
        _divider(),
        _infoTextLayout(
            dynamicText: controller.userLogHistory
                    ?.geTimelogAndLeaveAvailabilityForApp?.totalSchedule ??
                "",
            staticText: AppString.text_monthly_goal.tr),
        _divider(),
        _infoTextLayout(
            dynamicText: controller.userLogHistory
                    ?.geTimelogAndLeaveAvailabilityForApp?.totalLogged ??
                "",
            staticText: AppString.text_logged_time.tr),
      ],
    );
  }

  _infoTextLayout({required dynamicText, required staticText}) {
    return Column(
      children: [
        Text(
          "$dynamicText",
          style: AppStyle.normal_text_grey
              .copyWith(color: AppColor.normalTextColor),
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

  _divider() {
    return Container(
      width: 1,
      height: 20,
      color: AppColor.disableColor,
    );
  }

  _actionBtnLayout(context) {
    return GestureDetector(
      onTap: () => customButtonSheet(
          context: context,
          height: .5,
          child: actionLayout(
              context: context,
              userName: "Agens Neilson",
              departmentText: "Laravel department",
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

  _descriptionTextLayout() {
    return _filterTextLengthLayout();
  }

  _filterTextLengthLayout() {
    String drc =
        controller.userDetails?.getOrganizationUserDetails?.profile?.about ??
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

  _logoutLayout(context) {
    return GestureDetector(
      onTap: () {
        customDialog(
          context: context,
          saveBtnAction: () {
            Get.back();
          },
          icon: Icons.logout,
          titleText: AppString.text_are_you_sure.tr,
          subText: AppString.text_if_you_do_this_etc.tr,
          iconBgColor: AppColor.errorColorLight,
          btnBgColor: AppColor.errorColorLight,
          btnText: AppString.text_log_out.tr,
          drcText: "",
          drcFontSize: Dimensions.fontSizeDefault,
        );
      },
      child: Container(
        height: AppLayout.getHeight(90),
        width: MediaQuery.of(context).size.width,
        decoration:
            BoxDecoration(color: AppColor.secondaryColor.withOpacity(0.4)),
        child: Padding(
          padding: marginLayout.copyWith(top: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.logout_rounded,
                color: AppColor.cardColor,
              ),
              customSpacerWidth(width: 12),
              Text(
                AppString.text_log_out.tr,
                style:
                    AppStyle.mid_large_text.copyWith(color: AppColor.cardColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _languageLayout(context) {
    return InkWell(
      onTap: () => customButtonSheet(
          child: LanguageLayout(), context: context, height: .5),
      child: Container(
        padding: marginLayout.copyWith(left: 8, right: 8),
        child: Row(
          children: [
            SizedBox(height: 20, child: Image.asset(Images.FLAG_PNG)),
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
                  "English",
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

  _organisationLayout(context) {
    return Padding(
      padding: marginLayout,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your organisation",
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.normalTextColor,
                fontSize: Dimensions.fontSizeDefault,
                letterSpacing: 3.5),
          ),
          customSpacerHeight(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _organisationLogoLayout(),
              customSpacerWidth(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TrueCoders",
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.normalTextColor,
                        fontWeight: FontWeight.w900,
                        fontSize: Dimensions.fontSizeDefault + 1),
                  ),
                  Text(
                    "Senior Developer",
                    style: AppStyle.normal_text_grey.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault - 1),
                  ),
                  customSpacerHeight(height: 6),
                  GestureDetector(
                      onTap: () => customButtonSheet(
                          context: context,
                          height: .7,
                          child: OrganisationView()),
                      child: Text(
                        AppString.text_swich_organisation.tr,
                        style: AppStyle.normal_text_grey.copyWith(
                            color: AppColor.secondaryColor,
                            fontSize: Dimensions.fontSizeDefault - 1),
                      )),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  _profileInfoDrawerLayout() {
    return Center(
      child: Column(
        children: [
          _userProfileImgLayout(),
          customSpacerHeight(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Agens Neilson",
                style: AppStyle.mid_large_text
                    .copyWith(color: AppColor.normalTextColor),
              ),
              Text(
                "Laravel department",
                style: AppStyle.normal_text_grey
                    .copyWith(fontSize: Dimensions.fontSizeDefault - 1),
              ),
              customSpacerHeight(height: 8),
            ],
          ),
        ],
      ),
    );
  }

  _phoneNumberText() {
    return userInfoSectionLayout(
      staticText: AppString.text_phone.tr,
      dynamicText: controller.userDetails?.getOrganizationUserDetails?.profile
              ?.personalNumber ??
          "",
    );
  }

  _emergencyPhoneNumber() {
    return userInfoSectionLayout(
      staticText: AppString.text_emergency_phone.tr,
      dynamicText: controller.userDetails?.getOrganizationUserDetails?.profile
              ?.emergencyNumber ??
          "",
    );
  }

  _addressText() {
    return userInfoSectionLayout(
        staticText: AppString.text_address.tr,
        dynamicText: controller
                .userDetails?.getOrganizationUserDetails?.profile?.address ??
            "");
  }

  _employmentContractStatus() {
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

  _employmentStatus() {
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

  _userImageLayout({double? height}) {
    return CustomNetworkImage(
        height: height ?? 32,
        imgUrl:
            "${Api.PUBLIC_IMAGE_URL_DOMAIN}/files/${GetStorage().read(AppString.ORGANIZATION_ID)}/${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.image}");
  }

  _organisationLogoLayout() {
    return CustomNetworkImage(
      height: 22,
      imgUrl: "",
      borderColor: Colors.transparent,
      logoUrl: Images.ORG,
    );
  }

  endDrawer(BuildContext context) {
    return Drawer(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customSpacerHeight(height: 70),
          _profileLayout(),
          customSpacerHeight(height: 40),
          _organisationLayout(context),
          const Spacer(),
          _languageLayout(context),
          customSpacerHeight(height: 30),
          _logoutLayout(context)
        ],
      ),
    );
  }
}

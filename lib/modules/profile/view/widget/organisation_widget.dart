import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_network_image.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/common/widget/error_message.dart';
import 'package:payrun_mobile/modules/auth/presentation/controller/signin_controller.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/update_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/modules/profile/model/organization_info.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../common/domain/last_input_model.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import 'org_buttonsheet_appbar.dart';

class OrganisationView extends StatelessWidget {
  OrganisationView({super.key});

  final RxInt isSelected = 0.obs;

  @override
  Widget build(BuildContext context) {
    _getSelectedIndex();
    return Column(
      children: [
        orgButtonSheetAppbar(
            orgLength: Get.find<UserProfileController>()
                    .organizationInfo
                    ?.getUserOrganizations
                    ?.data
                    ?.length ??
                0),
        Expanded(
            child: Padding(
          padding: marginLayout.copyWith(top: 12, bottom: 12),
          child: ListView.builder(
            itemCount: Get.find<UserProfileController>()
                .organizationInfo
                ?.getUserOrganizations
                ?.data
                ?.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  customDialog(
                    context: context,
                    saveBtnAction: () {
                      if (GetStorage().read(AppString.LAST_INPUT) != null) {
                        Map<String, dynamic> jsonMap = json
                            .decode(GetStorage().read(AppString.LAST_INPUT));
                        LastInput lastInput = LastInput.fromJson(jsonMap);
                        Get.find<UserProfileController>().login(
                            email: lastInput.email ?? "",
                            password: lastInput.password ?? "",
                            orgId: Get.find<UserProfileController>()
                                    .organizationInfo
                                    ?.getUserOrganizations
                                    ?.data?[index]
                                    .organization
                                    ?.id ??
                                "",
                            organizationName: Get.find<UserProfileController>()
                                    .organizationInfo
                                    ?.getUserOrganizations
                                    ?.data?[index]
                                    .organization
                                    ?.subDomain ??
                                "");
                      } else {
                        showErrorMessage(message: AppString.error_text);
                      }
                    },
                    childForSaveBtn: Obx(
                      () => Get.find<UserProfileController>()
                              .isOrganizationChangeLoading
                              .isTrue
                          ? const Center(
                              child: CupertinoActivityIndicator(
                                color: Colors.blueAccent,
                              ),
                            )
                          : Text(
                              AppString.text_yes.tr,
                              style:
                                  AppStyle.normal_text.copyWith(fontSize: 16),
                            ),
                    ),
                    icon: Icons.swap_horiz,
                    titleText: AppString.text_are_you_sure.tr,
                    subText: AppString.changeOrganizationWarningMessage.tr,
                    iconBgColor: AppColor.bgColor,
                    btnBgColor: AppColor.errorColorLight,
                    btnText: AppString.text_yes.tr,
                    drcText: "",
                    drcFontSize: Dimensions.fontSizeDefault,
                  );
                },
                child: Obx(() => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _organisationLogoLayout(index),
                              customSpacerWidth(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Get.find<UserProfileController>()
                                            .organizationInfo
                                            ?.getUserOrganizations
                                            ?.data?[index]
                                            .organization
                                            ?.name ??
                                        "",
                                    style: AppStyle.mid_large_text.copyWith(
                                        color: AppColor.normalTextColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize:
                                            Dimensions.fontSizeDefault + 1),
                                  ),
                                  customSpacerHeight(height: 6),
                                  Text(
                                    Get.find<UserProfileController>()
                                            .organizationInfo
                                            ?.getUserOrganizations
                                            ?.data?[index]
                                            .designation
                                            ?.name ??
                                        "",
                                    style: AppStyle.normal_text_grey.copyWith(
                                        color: AppColor.hintColor,
                                        fontSize:
                                            Dimensions.fontSizeDefault - 1),
                                  ),
                                  customSpacerHeight(height: 6),
                                ],
                              ),
                              const Spacer(),
                              isSelected.value == index
                                  ? const Icon(
                                      Icons.done,
                                      color: AppColor.primaryColor,
                                    )
                                  : Container()
                            ],
                          ),
                          customSpacerHeight(height: 8),
                          Divider(
                            thickness: 1,
                            color: AppColor.disableColor.withOpacity(0.9),
                          )
                        ],
                      ),
                    )),
              );
            },
          ),
        ))
      ],
    );
  }

  _organisationLogoLayout(int index) {
    return CustomNetworkImage(
      height: 22,
      imgUrlKey: Get.find<UserProfileController>()
              .organizationInfo
              ?.getUserOrganizations
              ?.data?[index]
              .organization
              ?.organizationSetting
              ?.logoKey ??
          "",
      borderColor: Colors.transparent,
      logoUrl: Images.ORG,
    );
  }

  void _getSelectedIndex() {
    int? index = Get.find<UserProfileController>()
        .organizationInfo
        ?.getUserOrganizations
        ?.data
        ?.indexWhere((element) =>
            element.organization?.id ==
            Get.find<UserProfileController>()
                .userDetails
                ?.getOrganizationUserDetails
                ?.organization
                ?.orgId);
    isSelected.value = index ?? 0;
  }
}

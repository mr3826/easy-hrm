import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/custom_network_image.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/profile/controller/user_profile_controller.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../common/domain/last_input_model.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/utils.dart';
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
                  if (GetStorage().read(AppString.LAST_INPUT) != null) {
                    Map<String, dynamic> jsonMap =
                        json.decode(GetStorage().read(AppString.LAST_INPUT));
                    LastInput lastInput = LastInput.fromJson(jsonMap);

                    Get.find<UserProfileController>().switchOrganization(
                        orgId: Get.find<UserProfileController>()
                                .organizationInfo
                                ?.getUserOrganizations
                                ?.data?[index]
                                .organization
                                ?.id ??
                            "",
                        email: lastInput.email ?? "");
                  }
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
                                        "Not added yet",
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
      fileDir: "profile_images",
      height: 22,
      errorText: getFirstTwoLetterFromWord(Get.find<UserProfileController>()
              .organizationInfo
              ?.getUserOrganizations
              ?.data?[index]
              .organization
              ?.name ??
          ""),
      orgId: Get.find<UserProfileController>()
          .organizationInfo
          ?.getUserOrganizations
          ?.data?[index]
          .organization
          ?.id,
      isPublic: true,
      imgUrlKey: Get.find<UserProfileController>()
              .organizationInfo
              ?.getUserOrganizations
              ?.data?[index]
              .organization
              ?.organizationSetting
              ?.logIconKey ??
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

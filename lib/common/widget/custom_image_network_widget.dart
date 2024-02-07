import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imgix_core_dart/url_builder.dart';
import '../../modules/dashboard/controller/dashbpard_controller.dart';
import '../../modules/profile/controller/user_profile_controller.dart';
import '../../utils/api_endpoints.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../utils/app_style.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import 'custom_card_style.dart';
import 'custom_spacer.dart';

String urlBuilder(imgUrlKey) {
  final client = URLBuilder(
    domain: Api.CDN_DOMAIN,
    shouldUseHttpsByDefault: true,
    defaultSignKey: Api.CDN_KEY,
  );
  final url = client.createURLString(
    '/files/${GetStorage().read(AppString.ORGANIZATION_ID)}/$imgUrlKey',
    params: {'w': '500', 'h': '500'},
  );
  print({"url imgix:: $url"});
  return url;
}

Widget circleImageLayout({radius, url, borderColor, logoUrl}) {
  return CircleAvatar(
    radius: radius + 2.5,
    backgroundColor: borderColor ?? AppColor.hintColor,
    child: CircleAvatar(
      backgroundColor: borderColor ?? AppColor.cardColor,
      radius: radius + 2,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColor.cardColor,
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => const CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => CircleAvatar(
            radius: radius,
            backgroundColor: AppColor.bgColorWithPrimary,
            child: _errorText(),
          ),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

_errorText() {
  return Text(
      "${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.firstName?[0].toUpperCase() ?? ""}${Get.find<UserProfileController>().userDetails?.getOrganizationUserDetails?.profile?.lastName?[0].toUpperCase() ?? ""}",
      style: AppStyle.normal_text_grey.copyWith(
          fontSize: Dimensions.fontSizeMid + 4, color: AppColor.primaryColor));
}

Widget rectangleImageLayout({url}) {
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) => const CupertinoActivityIndicator(),
    errorWidget: (context, url, error) => _emptyBox(),
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    ),
    fit: BoxFit.cover,
  );
}

_emptyBox() {
  return Container(
    color: AppColor.primaryColor.withOpacity(0.05),
    child: SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 0,
            shape: roundedRectangleBorder.copyWith(
                side: BorderSide(color: AppColor.hintColor.withOpacity(0.3))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.image_outlined,
                    color: AppColor.hintColor,
                  ),
                  customSpacerWidth(width: 8),
                  Text(
                    AppString.text_upload_image.tr,
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault + 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

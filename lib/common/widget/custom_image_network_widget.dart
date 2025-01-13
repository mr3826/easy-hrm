import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imgix_core_dart/url_builder.dart';
import '../../utils/api_endpoints.dart';
import '../../utils/app_color.dart';
import '../../utils/app_string.dart';
import '../../utils/app_style.dart';
import '../../utils/dimensions.dart';
import 'custom_card_style.dart';
import 'custom_spacer.dart';

String urlBuilder({
  required String imgUrlKey,
  String? fileDir,
  String? profileImageKey,
  String? orgId,
  bool isPublic = false,
}) {

  final cdmKey = isPublic
      ? Api.CDN_DOMAIN.replaceAll("private", "public")
      : Api.CDN_DOMAIN;


  final client = URLBuilder(
    domain: cdmKey,
    shouldUseHttpsByDefault: true,
    defaultSignKey: Api.CDN_KEY,
  );

  final urlPath = profileImageKey ??
      '${fileDir ?? "files"}/${orgId ?? GetStorage().read(AppString.ORGANIZATION_ID)}/$imgUrlKey';

  return client.createURLString(urlPath);
}





Widget circleImageLayout(
    {radius, required url, borderColor, required errorText,TextStyle ?errorTextStyle}) {
Widget circleImageLayout({radius, required url, borderColor, required errorText}) {
  return CircleAvatar(
    radius: radius + 2.1,
    backgroundColor: borderColor ?? AppColor.hintColor,
    child: CircleAvatar(
      backgroundColor: borderColor ?? AppColor.cardColor,
      radius: radius + 1.8,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppColor.cardColor,
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => const CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => CircleAvatar(
            radius: radius,
            backgroundColor: AppColor.bgColorWithPrimary,
            child: _errorText(errorText,errorTextStyle),
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

Widget _errorText(errorText,TextStyle ?errorTextStyle) {
  return Text("$errorText",
      style: errorTextStyle?? AppStyle.normal_text_grey.copyWith(
          fontSize: Dimensions.fontSizeMid, color: AppColor.primaryColor));
}


















Widget rectangleImageLayout({url}) {
  return CachedNetworkImage(
    imageUrl: url,
    placeholder: (context, url) =>
        const Center(child: CupertinoActivityIndicator()),
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

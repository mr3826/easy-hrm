import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:imgix_core_dart/url_builder.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../common/widget/custom_spacer.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';

class CircularNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? radius;
  final BorderRadius? imageRadius;
  final Color? borderColor;
  final String? errorText;
  final Widget? error;

  const CircularNetworkImage({
    super.key,
    required this.imageUrl,
    this.radius,
    this.error,
    this.imageRadius,
    this.borderColor,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final double resolvedRadius = radius ?? 40.0;
    return _buildCircularImage(resolvedRadius);
  }

  Widget _buildCircularImage(double resolvedRadius) {
    return CircleAvatar(
      radius: resolvedRadius + 2.4,
      backgroundColor: borderColor ?? AppColor.hintColor,
      child: CircleAvatar(
        backgroundColor: AppColor.cardColor,
        radius: resolvedRadius + 1.8,
        child: CircleAvatar(
          radius: resolvedRadius,
          backgroundColor: AppColor.cardColor,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => CircleAvatar(
              radius: resolvedRadius,
              backgroundColor: AppColor.bgColorWithPrimary,
              child: _buildErrorText(errorText: errorText),
            ),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
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
}












class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? radius;
  final BorderRadius? imageRadius;
  final double? height;
  final Color? borderColor;
  final String? errorText;
  final bool isCircleImage;
  final Widget? error;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.radius,
    this.error,
    this.height,
    this.imageRadius,
    this.borderColor,
    this.errorText,
    this.isCircleImage = false,
  });

  @override
  Widget build(BuildContext context) {
    final double resolvedRadius = radius ?? 40.0;
    final double resolvedHeight = height ?? 200.0;

    return isCircleImage
        ? _buildCircularImage(resolvedRadius)
        : _buildRectangleImage(resolvedHeight, error);
  }

  Widget _buildCircularImage(double resolvedRadius) {
    return CircleAvatar(
      radius: resolvedRadius + 2.4,
      backgroundColor: borderColor ?? AppColor.hintColor,
      child: CircleAvatar(
        backgroundColor: AppColor.cardColor,
        radius: resolvedRadius + 1.8,
        child: CircleAvatar(
          radius: resolvedRadius,
          backgroundColor: AppColor.cardColor,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => CircleAvatar(
              radius: resolvedRadius,
              backgroundColor: AppColor.bgColorWithPrimary,
              child: _buildErrorText(),
            ),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
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

  Widget _buildRectangleImage(double resolvedHeight, Widget? errorWidget) {
    return SizedBox(
      height: resolvedHeight,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) =>
            const Center(child: CupertinoActivityIndicator()),
        errorWidget: (context, url, error) => errorWidget != null
            ? Container(
                child: errorWidget,
              )
            : _buildEmptyBox(),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: imageRadius ?? BorderRadius.circular(4),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}

Widget _buildErrorText({String? errorText}) {
  return Text(
    errorText ?? AppString.text_upload_image.tr,
    style: AppStyle.mid_large_text.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 2,
    ),
    textAlign: TextAlign.center,
  );
}

Widget _buildEmptyBox() {
  return Container(
    color: AppColor.primaryColor.withOpacity(0.05),
    child: Center(
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder.copyWith(
          side: BorderSide(color: AppColor.hintColor.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
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
                  fontSize: Dimensions.fontSizeDefault + 2,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

String buildImgIxUrl({
  String? imgKey,
  String? fileDirectory,
  String? profileImageKey,
  String? orgId,
  bool isPublic = false,
}) {
  // Determine the appropriate domain based on visibility (public/private).
  final domain = isPublic
      ? Api.CDN_DOMAIN.replaceFirst("private", "public")
      : Api.CDN_DOMAIN;

  // Create the URL client with default configurations.
  final urlClient = URLBuilder(
    domain: domain,
    shouldUseHttpsByDefault: true,
    defaultSignKey: Api.CDN_KEY,
  );

  // Construct the URL path based on the given parameters.
  final organizationId = orgId ?? GetStorage().read(AppString.ORGANIZATION_ID);
  final urlPath =
      profileImageKey ?? '${fileDirectory ?? "files"}/$organizationId/$imgKey';

  // Generate the full URL string using the client.
  return urlClient.createURLString(urlPath);
}

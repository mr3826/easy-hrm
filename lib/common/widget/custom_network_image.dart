import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:imgix_core_dart/url_builder.dart';
import 'package:payrun_mobile/utils/app_color.dart';

import '../../utils/app_string.dart';
import '../../utils/images.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imgUrlKey;
  final String? logoUrl;
  final double height;
  final Color? borderColor;

  const CustomNetworkImage(
      {super.key,
      this.height = 32,
      required this.imgUrlKey,
      this.borderColor,
      this.logoUrl});

  @override
  Widget build(BuildContext context) {
    final client = URLBuilder(
      domain: 'payrun-local.imgix.net',
      shouldUseHttpsByDefault: true,
      defaultSignKey: 'AbuprUHFbUncYjep',
    );

    final url = client.createURLString(
      '/files/${GetStorage().read(AppString.ORGANIZATION_ID)}/$imgUrlKey',
      params: {'w': '500', 'h': '500'},
    );
    print({"url imgix:: $url"});

    var radius = height;
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
                backgroundImage: AssetImage(logoUrl ?? Images.user)),
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
}

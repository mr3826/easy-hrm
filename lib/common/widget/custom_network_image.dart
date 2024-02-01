import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:imgix_core_dart/url_builder.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_color.dart';

import '../../utils/app_string.dart';
import '../../utils/app_style.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import 'custom_card_style.dart';
import 'custom_image_network_widget.dart';
import 'custom_spacer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imgUrlKey;
  final String? logoUrl;
  final double height;
  final Color? borderColor;
  final bool? isDocumentLayout;

  const CustomNetworkImage({
    super.key,
    this.height = 32,
    required this.imgUrlKey,
    this.borderColor,
    this.logoUrl,
    this.isDocumentLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    String url = urlBuilder(imgUrlKey);
    var radius = height;
    return isDocumentLayout != true
        ? circleImageLayout(
            url: url,
            radius: radius,
            borderColor: borderColor,
            logoUrl: logoUrl)
        : rectangleImageLayout(url: url);
  }
}

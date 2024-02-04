import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_image_network_widget.dart';

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
    log("image url key ::: $imgUrlKey");
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

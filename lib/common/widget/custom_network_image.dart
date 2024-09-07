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
  final bool? isPublic;
  final String errorText;
  final String? fileDir;
  final String? profileImageKey;
  final  String? orgId;


  const CustomNetworkImage({
    super.key,
    this.height = 32,
    required this.imgUrlKey,
    this.borderColor,
    this.isPublic,
    this.orgId,
    this.logoUrl,
    this.profileImageKey,
    required this.errorText,
    this.isDocumentLayout = false,
    this.fileDir
  });

  @override
  Widget build(BuildContext context) {
    String url = urlBuilder(imgUrlKey: imgUrlKey,fileDir: fileDir,profileImageKey: profileImageKey,isPublic: isPublic??false,orgId: orgId);

    print("urlBuilder ::: $url");



    var radius = height;
    return isDocumentLayout != true
        ? circleImageLayout(
            url: url,
            radius: radius,
            borderColor: borderColor,
            errorText: errorText,
          )
        : rectangleImageLayout(url: url);
  }
}

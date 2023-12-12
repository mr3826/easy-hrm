import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payrun_mobile/utils/app_color.dart';

Widget customIconShapeStyle({required image,Color color=AppColor.primaryColor}){
  return  CircleAvatar(
    radius: 23,
    backgroundColor: color.withOpacity(0.1),
    child: SvgPicture.asset(
      image,
      color: color,
    ),
  );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payrun_mobile/utils/app_layout.dart';


SizedBox customSvgImage({required imageUrl ,double ?height, double ?width}){
 return SizedBox(
   height: AppLayout.getHeight(height!),width: AppLayout.getWidth(width!),
   child: SvgPicture.asset(
     imageUrl,

    ),
 );
}
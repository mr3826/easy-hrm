import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payrun_mobile/utils/app_layout.dart';


SizedBox customSvgImage({required imageUrl ,double ?height, double ?width,Color?color}){
 return SizedBox(
   height: AppLayout.getHeight(height??30),width: AppLayout.getWidth(width??30),
   child: SvgPicture.asset(
     imageUrl,
     color:color ,
    ),
 );
}
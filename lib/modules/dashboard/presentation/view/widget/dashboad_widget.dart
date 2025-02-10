import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../utils/app_color.dart';



Widget dotsDecorator({required currentIndex}) {
  return DotsIndicator(
    dotsCount: 2, // Number of dots should match the number of pages
    position: currentIndex.value,
    decorator: const DotsDecorator(
        color: AppColor.hintColor,
        activeColor: AppColor.primaryColor,
        size: Size.square(10.0),
        activeSize: Size(25.0, 9),
        activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(5.0), left: Radius.circular(5.0)))),
  );
}

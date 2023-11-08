import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: AppLayout.getSize(context).height,
        color: Colors.white,
        child: _android(),
      ),
    );
  }
}

bottomSheetLoader() {
  return Center(
    child: Container(
      height: Get.height * .8,
      color: Colors.white,
      child: _android(),
    ),
  );
}

loadingIndicatorLayout({double height = 100}) {
  return SizedBox(
    height: AppLayout.getHeight(height),
    child: Center(
      child: Image.asset(
        // Images.loading,
       ""
      ),
    ),
  );
}

_android() {
  return Center(
      child: SizedBox(
    height: AppLayout.getHeight(150),
    width: AppLayout.getWidth(150),
    child: Image.asset(""),
  ));
}

_ios() {
  return Center(
      child: SizedBox(
          height: AppLayout.getHeight(60),
          width: AppLayout.getWidth(60),
          child: const CupertinoActivityIndicator(
            color: AppColor.primaryColor,
          )));
}

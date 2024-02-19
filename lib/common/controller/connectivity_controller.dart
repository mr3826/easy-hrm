import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../utils/app_color.dart';
import '../../utils/app_layout.dart';
import '../../utils/app_string.dart';
import '../../utils/app_style.dart';
import '../../utils/images.dart';
import '../widget/custom_spacer.dart';


class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final isDialogIsOpened = false.obs;

  @override
  void onInit() {
    _connectivity.onConnectivityChanged.listen(
            (connectivityResult) => _updateConnectivity(connectivityResult));
    super.onInit();
  }

  void _updateConnectivity(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.to(const NetworkErrorPage());
      isDialogIsOpened(true);
    } else {
      if (isDialogIsOpened.isTrue) {
        Get.offAllNamed(Routes.MAIN_SCREEN);
      }
      isDialogIsOpened(false);
    }
  }
}


class NetworkErrorPage extends StatelessWidget {
  const NetworkErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WillPopScope(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Images.network_error),
            customSpacerHeight(height: 20),
            Text(
              AppString.no_internet_title_text,
              style: AppStyle.extra_large_text_black
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            customSpacerHeight(height: 20),
            Text(
              AppString.no_internet_subtitle_text,
              style: AppStyle.normal_text_black,
              textAlign: TextAlign.center,
            ),
            customSpacerHeight(height: 40),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(8)),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: AppLayout.getWidth(16),
                ),
                customSpacerWidth(width: 4),
                Text(AppString.text_retry, style: AppStyle.normal_text),
              ]),
            )
          ],
        ),
      ),
      onWillPop: () async => false,
    ));
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_double_app_button.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/auth/presentation/view/otp_screen.dart';
import 'package:payrun_mobile/modules/leave/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../utils/app_color.dart';

customDialog({
  required context,
  required icon,
  drcFontSize,
  required titleText,
  required subText,
  required saveBtnAction,
  required btnText,
  Widget? childForSaveBtn,
  String? drcText,
  required iconBgColor,
  required btnBgColor,
}) {
  showDialog(
    context: context,
    builder: (context) => CustomDialog(
        subtext: subText,
        drcFontSize: drcFontSize,
        titleText: titleText,
        icon: icon,
        saveBtnAction: saveBtnAction,
        btnText: btnText,
        drcText: drcText ?? "",
        childForSaveBtn: childForSaveBtn,
        iconBgColor: btnBgColor,
        btnBgColor: btnBgColor),
  );
}

class CustomDialog extends StatelessWidget {
  final IconData icon;
  final String titleText;
  final String subtext;
  final String drcText;
  final String btnText;
  final Color iconBgColor;
  final Color btnBgColor;
  final double? drcFontSize;
  final Widget? childForSaveBtn;
  final Function saveBtnAction;
  final isOTPVisible = false;

  const CustomDialog(
      {super.key,
      required this.icon,
      required this.titleText,
      this.drcFontSize,
      required this.iconBgColor,
      required this.btnBgColor,
      this.subtext = "",
      this.childForSaveBtn,
      required this.saveBtnAction,
      required this.btnText,
      required this.drcText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: AppColor.cardColor,
        shape: roundedRectangleBorder,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.radiusDefault)),
              margin: const EdgeInsets.only(top: 30),
              child: SizedBox(
                child: Padding(
                  padding: marginLayout.copyWith(bottom: 16),
                  child: Column(
                    children: [
                      customSpacerHeight(height: 55),
                      Text(
                        titleText,
                        style: AppStyle.mid_large_text.copyWith(
                            color: AppColor.normalTextColor,
                            fontWeight: FontWeight.w600),
                      ),
                      customSpacerHeight(height: 12),
                      Center(
                          child: Text(
                        subtext,
                        style: AppStyle.mid_large_text.copyWith(
                            color: AppColor.hintColor,
                            fontSize:
                                drcFontSize ?? Dimensions.fontSizeDefault - 3),
                      )),
                      Center(
                          child: Text(
                        drcText,
                        style: AppStyle.mid_large_text.copyWith(
                            color: AppColor.hintColor,
                            fontSize: Dimensions.fontSizeDefault - 3),
                      )),
                      const Spacer(),
                      Obx(
                        () => Get.find<LeaveScreenController>()
                                .cancelLeaveLoader
                                .isTrue
                            ? const Center(
                                child: CupertinoActivityIndicator(
                                  color: Colors.blueAccent,
                                  radius: 16,
                                ),
                              )
                            : CustomDoubleAppButton(
                                buttonText: btnText,
                                onAction: saveBtnAction,
                                cancelAction: () => Get.back(),
                                btnColor: btnBgColor,
                                saveBtn: childForSaveBtn,
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 10,
                child: CircleAvatar(
                  backgroundColor: iconBgColor.withOpacity(0.2),
                  radius: 32,
                  child: Icon(
                    icon,
                    size: 40,
                    color: iconBgColor,
                  ),
                ))
          ],
        ));
  }
}

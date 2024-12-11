import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/controller/hr_leave_controller.dart';
import 'package:payrun_mobile/common/widget/custom_app_button.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../../../../common/widget/custom_dialog.dart';
import '../../../../../../../../common/widget/custom_spacer.dart';
import '../../../../../../../../common/widget/custom_svg_image.dart';
import '../../../../../../../../utils/app_color.dart';
import '../../../../../../../../utils/app_style.dart';
import '../../../../../../../../utils/dimensions.dart';
import '../../../../../../../../utils/images.dart';
import 'more_leave_record_details.dart';

Widget buildPendingBtn({required String leaveDate, required String leaveId}) {
  return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(
        () => Get.find<HrLeaveController>().updateLeaveLoader.isTrue
            ? const Center(
                child: CupertinoActivityIndicator(
                  color: AppColor.primaryColor,
                ),
              )
            : Row(
                children: [
                  CustomAppButton(
                    buttonText: Text(
                      AppString.textReject.tr,
                      style: TextStyle(
                          color: AppColor.errorColor,
                          fontSize: Dimensions.fontSizeDefault),
                    ),
                    onPressed: () {
                      showRejectDialog(Get.context!, leaveDate.toString(),
                          leaveId: leaveId);
                    },
                    buttonColor: AppColor.cardColor,
                    borderColor: AppColor.errorColor,
                    textColor: AppColor.errorColor,
                    borderRadius: Dimensions.radiusLarge,
                  ),
                  customSpacerWidth(width: 20),
                  CustomAppButton(
                    buttonText: Text(
                      AppString.text_approved.tr,
                      style: TextStyle(
                          color: AppColor.cardColor,
                          fontSize: Dimensions.fontSizeDefault + 1),
                    ),
                    onPressed: () {
                      Get.find<HrLeaveController>()
                          .updateLeave(leaveId: leaveId, status: "approved");
                    },
                    buttonColor: AppColor.successColor,
                    borderColor: AppColor.successColor,
                    textColor: AppColor.cardColor,
                    borderRadius: Dimensions.radiusLarge,
                  ),
                ],
              ),
      ));
}

Widget buildApprovedBtn({required String leaveDate, required String leaveId}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Obx(() => Get.find<HrLeaveController>().updateLeaveLoader.isTrue
        ? const Center(
          child: CupertinoActivityIndicator(
              color: AppColor.primaryColor,
              radius: 15,
            ),
        )
        : CustomAppButton(
            isButtonExpanded: false,
            buttonText: Text(
              AppString.text_cancel.tr,
              style: TextStyle(
                  color: AppColor.cardColor,
                  fontSize: Dimensions.fontSizeDefault + 1),
            ),
            onPressed: () {
              showCustomAlertDialog(
                context: Get.context!,
                onConfirm: () {
                  Get.find<HrLeaveController>().updateLeave(leaveId: leaveId, status: "cancelled");
                  Get.back(canPop: false);
                },
                confirmButtonChild: Text(
                  AppString.confirmText.tr,
                  style: AppStyle.normal_text_grey.copyWith(
                      fontSize: Dimensions.fontSizeDefault + 1,
                      color: AppColor.cardColor),
                ),
                extraInfoText: "",
                iconWidget: customSvgImage(
                    imageUrl: Images.cancelLeave, height: 60, width: 60),
                titleText: AppString.cancelLeaveText.tr,
                descriptionText: AppString.cancelLeaveNotificationText.tr,
                iconBackgroundColor: AppColor.cardColor,
                confirmButtonColor: AppColor.hintColor,
                confirmButtonText: AppString.confirmText.tr,
              );
            },
            buttonColor: AppColor.hintColor,
            borderColor: AppColor.hintColor,
            textColor: AppColor.cardColor,
            borderRadius: Dimensions.radiusLarge,
          )),
  );
}

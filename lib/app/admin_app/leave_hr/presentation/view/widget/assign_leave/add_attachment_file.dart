import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/controller/hr_update_leave_controller.dart';
import 'package:payrun_mobile/app/admin_app/leave_hr/presentation/model/leave_details_by_id.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/leave/presentation/view/widget/dotted_circle_style.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import '../../../../../../../common/widget/custom_card_style.dart';
import '../../../../../../../common/widget/custom_network_image.dart';
import '../../../controller/hr_leave_controller.dart';

class AttachmentFile extends StatelessWidget {
  final bool? isAssignLeave;
  final GetLeaveDetailsById? getLeaveDetailsById;

  const AttachmentFile(
      {super.key, this.getLeaveDetailsById, this.isAssignLeave});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered()) {
      Get.delete<HrLeaveController>();
    }
    Get.put(HrLeaveController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dottedCircleStyle(
            child: GestureDetector(onTap: () {
          if (isAssignLeave == true) {
            Get.find<HrLeaveController>()
                .storageForUpload
                .pickFile(controller: Get.find<HrLeaveController>());
          } else {
            Get.find<HrUpdateLeaveController>()
                .storageForUpload
                .pickFile(controller: Get.find<HrUpdateLeaveController>());
          }
        }, child: Obx(() {
          return isAssignLeave == true
              ? _documentLayout()
              : _updateDocumentLayout();
        }))),
        customSpacerHeight(height: 8),
        if (getLeaveDetailsById?.files?.isNotEmpty ?? false)
          _pathNameText(getLeaveDetailsById?.files?.first.key.toString() ?? ""),
      ],
    );
  }

  Widget _documentLayout() {
    if (Get.find<HrLeaveController>().isFileUploadedSuccessfully.isTrue &&
        Get.find<HrLeaveController>().isUploadPolicyLoading.isFalse) {
      /// file image
      return Get.find<HrLeaveController>()
              .storageForUpload
              .filePath
              .endsWith(".pdf")
          ? _replaceFileLayout()
          : _selectedImageViewLayout(
              Get.find<HrLeaveController>().storageForUpload.filePath.value);
    } else if (Get.find<HrLeaveController>()
            .isFileUploadedSuccessfully
            .isFalse &&
        Get.find<HrLeaveController>().isUploadPolicyLoading.isFalse) {
      if (Get.find<HrLeaveController>().storageForUpload.filePath.isEmpty) {
        if (getLeaveDetailsById?.files != null) {
          if (getLeaveDetailsById?.files?.first.key == null) {
            return _emptyBox();
          } else if (getLeaveDetailsById!.files!.first.key!.endsWith(".pdf")) {
            return _replaceFileLayout();
          } else {
            return CustomNetworkImage(
              imgUrlKey: getLeaveDetailsById?.files?.first.key ?? "",
              isDocumentLayout: true,
              errorText: "",
            );
          }
        } else {
          return _emptyBox();
        }
      } else {
        /// broken image
        if (Get.find<HrLeaveController>().isUploadPolicyLoading.isFalse) {
          return const Center(
              child: CupertinoActivityIndicator(
            color: AppColor.primaryColor,
          ));
        } else {
          return const Center(
              child: CupertinoActivityIndicator(
            color: AppColor.primaryColor,
          ));
        }
      }
    } else {
      return const Center(
          child: CupertinoActivityIndicator(
        color: AppColor.primaryColor,
      ));
    }
  }

  Widget _updateDocumentLayout() {
    final hrUpdateLeaveController = Get.find<HrUpdateLeaveController>();

    // Extract flags for better readability
    final isFileUploaded =
        hrUpdateLeaveController.isFileUploadedSuccessfully.isTrue;
    final isUploadLoading =
        hrUpdateLeaveController.isUploadPolicyLoading.isFalse;
    final uploadedFilePath = hrUpdateLeaveController.storageForUpload.filePath;
    final leaveFiles = getLeaveDetailsById?.files;

    if (isFileUploaded && isUploadLoading) {
      // Handle uploaded file
      return uploadedFilePath.endsWith(".pdf")
          ? _replaceFileLayout()
          : _selectedImageViewLayout(uploadedFilePath.value);
    }

    if (!isFileUploaded && isUploadLoading) {
      if (uploadedFilePath.isEmpty) {
        if (leaveFiles?.isEmpty ?? true) {
          return _emptyBox();
        }

        final firstFileKey = leaveFiles?.first.key;
        if (firstFileKey == null) {
          return _emptyBox();
        }

        return firstFileKey.endsWith(".pdf")
            ? _replaceFileLayout()
            : CustomNetworkImage(
                imgUrlKey: firstFileKey,
                isDocumentLayout: true,
                errorText: "",
              );
      }
      // Show loading indicator for broken image
      return const Center(
        child: CupertinoActivityIndicator(color: AppColor.primaryColor),
      );
    }
    // Default fallback: Show loading indicator
    return const Center(
      child: CupertinoActivityIndicator(color: AppColor.primaryColor),
    );
  }
}

_replaceFileLayout() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Card(
        elevation: 0,
        shape: roundedRectangleBorder.copyWith(
            side: BorderSide(color: AppColor.hintColor.withOpacity(0.3))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                Icons.image_outlined,
                color: AppColor.primaryColor,
              ),
              customSpacerWidth(width: 8),
              Text(
                AppString.text_replace_file.tr,
                style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.primaryColor,
                    fontSize: Dimensions.fontSizeDefault + 2),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

_emptyBox() {
  return Container(
    color: AppColor.primaryColor.withOpacity(0.05),
    child: SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 0,
            shape: roundedRectangleBorder.copyWith(
                side: BorderSide(color: AppColor.hintColor.withOpacity(0.3))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.image_outlined,
                    color: AppColor.hintColor,
                  ),
                  customSpacerWidth(width: 8),
                  Text(
                    AppString.text_upload_image.tr,
                    style: AppStyle.mid_large_text.copyWith(
                        color: AppColor.hintColor,
                        fontSize: Dimensions.fontSizeDefault + 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

_pathNameText(String remoteUrl) {
  return remoteUrl.isEmpty ||
          Get.find<HrLeaveController>()
              .storageForUpload
              .filePath
              .value
              .isNotEmpty
      ? Obx(() => Text(
          Get.find<HrLeaveController>()
              .storageForUpload
              .filePath
              .value
              .split('/')
              .last,
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.primaryColor,
              fontSize: Dimensions.fontSizeDefault - 2)))
      : Text(remoteUrl,
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.primaryColor,
              fontSize: Dimensions.fontSizeDefault - 2));
}

_selectedImageViewLayout(String path) {
  return Container(
    height: AppLayout.getHeight(100),
    decoration: BoxDecoration(
      color: AppColor.disableColor.withOpacity(0.4),
      image: DecorationImage(
        image: FileImage(File(path).absolute),
        fit: BoxFit.cover,
      ),
    ),
  );
}


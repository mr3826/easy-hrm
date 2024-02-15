import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/leave/controller/apply_leave_controller.dart';
import 'package:payrun_mobile/modules/leave/controller/file_upload_controller.dart';
import 'package:payrun_mobile/modules/leave/controller/update_leave_controller.dart';
import 'package:payrun_mobile/modules/leave/view/widget/dotted_circle_style.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';
import 'package:payrun_mobile/utils/images.dart';
import '../../../../common/widget/custom_card_style.dart';
import '../../../../common/widget/custom_network_image.dart';
import '../../model/leave_records.dart';

class AddAttachmentFile extends StatelessWidget {
  final bool? isFromApplyLeave;
  final GetLeaveRecords? leaveRecords;
  const AddAttachmentFile(
      {this.isFromApplyLeave = false, super.key, this.leaveRecords});

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered()) {
      Get.delete<ApplyLeaveController>();
    }
    Get.put(ApplyLeaveController());
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dottedCircleStyle(
                isErrorOccurred: isFromApplyLeave == true
                    ? Get.find<ApplyLeaveController>().isErrorOccurred.value
                    : Get.find<UpDateLeaveController>().isErrorOccurred.value,
                child: GestureDetector(onTap: () {
                  Get.find<FileUploadController>()
                      .storageForUpload
                      .pickFile(isApplyLeave: isFromApplyLeave);
                }, child: Obx(() {
                  return isFromApplyLeave == true
                      ? _documentLayout()
                      : _updateDocumentLayout();
                }))),
            customSpacerHeight(height: 8),
            _pathNameText(leaveRecords?.leaveType?.fileKey ?? '')
          ],
        ));
  }

  Widget _documentLayout() {
    if (Get.find<ApplyLeaveController>().isFileUploadedSuccessfully.isTrue &&
        Get.find<ApplyLeaveController>().isUploadPolicyLoading.isFalse) {
      /// file image
      return Get.find<FileUploadController>()
              .storageForUpload
              .filePath
              .endsWith(".pdf")
          ? _replaceFileLayout()
          : _selectedImageViewLayout();
    } else if (Get.find<ApplyLeaveController>()
            .isFileUploadedSuccessfully
            .isFalse &&
        Get.find<ApplyLeaveController>().isUploadPolicyLoading.isFalse) {
      if (Get.find<FileUploadController>().storageForUpload.filePath.isEmpty) {
        /// initial stage
        return (leaveRecords?.files != null && leaveRecords!.files!.isNotEmpty)
            ? leaveRecords?.files![0].key == null ||
                    leaveRecords?.files![0].key == "null"
                ? _emptyBox()
                : leaveRecords!.files![0].key!.endsWith(".pdf")
                    ? _replaceFileLayout()
                    : CustomNetworkImage(
                        imgUrlKey: leaveRecords?.files?[0].key ?? "",
                        isDocumentLayout: true,
                        errorText: "",
                      )
            : _emptyBox();
      } else {
        /// broken image
        if (Get.find<ApplyLeaveController>().isUploadPolicyLoading.isFalse) {
          return _brokenImageViewLayout();
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
    if (Get.find<UpDateLeaveController>().isFileUploadedSuccessfully.isTrue &&
        Get.find<UpDateLeaveController>().isUploadPolicyLoading.isFalse) {
      /// file image
      return Get.find<FileUploadController>()
              .storageForUpload
              .filePath
              .endsWith(".pdf")
          ? _replaceFileLayout()
          : _selectedImageViewLayout();
    } else if (Get.find<UpDateLeaveController>()
            .isFileUploadedSuccessfully
            .isFalse &&
        Get.find<UpDateLeaveController>().isUploadPolicyLoading.isFalse) {
      if (Get.find<FileUploadController>().storageForUpload.filePath.isEmpty) {
        /// initial stage
        return (leaveRecords?.files != null && leaveRecords!.files!.isNotEmpty)
            ? leaveRecords?.files![0].key == null ||
                    leaveRecords?.files![0].key == "null"
                ? _emptyBox()
                : leaveRecords!.files![0].key!.endsWith(".pdf")
                    ? _replaceFileLayout()
                    : CustomNetworkImage(
                        imgUrlKey: leaveRecords?.files?[0].key ?? "",
                        isDocumentLayout: true,
                        errorText: "",
                      )
            : _emptyBox();
      } else {
        /// broken image
        if (Get.find<UpDateLeaveController>().isUploadPolicyLoading.isFalse) {
          return _brokenImageViewLayout();
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
          Get.find<FileUploadController>()
              .storageForUpload
              .filePath
              .value
              .isNotEmpty
      ? Obx(() => Text(
          Get.find<FileUploadController>()
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

_selectedImageViewLayout() {
  return Container(
    height: AppLayout.getHeight(100),
    decoration: BoxDecoration(
      color: AppColor.disableColor.withOpacity(0.4),
      image: DecorationImage(
        image: FileImage(File(Get.find<FileUploadController>()
                .storageForUpload
                .filePath
                .value)
            .absolute),
        fit: BoxFit.cover,
      ),
    ),
  );
}

_brokenImageViewLayout() {
  return Container(
    height: AppLayout.getHeight(100),
    decoration: BoxDecoration(
      color: AppColor.disableColor.withOpacity(0.4),
      image: DecorationImage(
        image: AssetImage(Images.PLACEHOLDER),
        fit: BoxFit.cover,
      ),
    ),
  );
}

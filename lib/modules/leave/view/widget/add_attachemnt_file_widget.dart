import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/common/controller/date_time_helper_controller.dart';
import 'package:payrun_mobile/common/widget/custom_alert_dialog.dart';
import 'package:payrun_mobile/common/widget/custom_spacer.dart';
import 'package:payrun_mobile/modules/leave/controller/file_upload_controller.dart';
import 'package:payrun_mobile/modules/leave/view/widget/dotted_circle_style.dart';
import 'package:payrun_mobile/utils/app_color.dart';
import 'package:payrun_mobile/utils/app_layout.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import 'package:payrun_mobile/utils/app_style.dart';
import 'package:payrun_mobile/utils/dimensions.dart';

class AddAttachmentFile extends StatelessWidget {
  const AddAttachmentFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dottedCircleStyle(
                isErrorOccurred:
                    Get.find<DateTimeController>().isErrorOccurred.value,
                child: GestureDetector(
                    onTap: () {
                      Get.find<FileUploadController>()
                          .storageForUpload
                          .pickFile();
                    },
                    child: Get.find<FileUploadController>()
                            .storageForUpload
                            .filePath
                            .isNotEmpty
                        ? Get.find<FileUploadController>()
                                .storageForUpload
                                .filePath
                                .endsWith(".pdf")
                            ? _replaceFileLayout()
                            : _selectedImageViewLayout()
                        : _emptyBox())),
            customSpacerHeight(height: 8),
            Obx(() => _pathNameText()),
          ],
        ));
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

_pathNameText() {
  return Text(
      Get.find<FileUploadController>()
          .storageForUpload
          .filePath
          .value
          .split('/')
          .last,
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

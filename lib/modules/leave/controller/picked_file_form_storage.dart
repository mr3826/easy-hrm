import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/modules/leave/controller/update_leave_controller.dart';
import '../../../../common/widget/error_message.dart';
import '../../../../common/widget/success_message.dart';
import '../../../../common/widget/warning_message.dart';
import '../../../../utils/app_string.dart';
import 'apply_leave_controller.dart';
import 'file_upload_controller.dart';

class PickedFileFormStorage {
  final box = GetStorage();

  Rx<File?> selectedFile = Rx<File?>(null);
  RxString filePath = ''.obs;
  RxString fileSize = '0'.obs;
  final isLoading = false.obs;

  //picked file form storage here
  Future<void> pickFile({bool? isApplyLeave=false}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (result.files.single.path!.length > 500.toInt()) {
        showWarningMessage(message: AppString.text_jpeg_format_not_support);
      } else if (result.files.single.path!.endsWith(".png") ||
          result.files.single.path!.endsWith(".jpg") ||
          result.files.single.path!.endsWith(".jpeg") ||
          result.files.single.path!.endsWith(".pdf")) {
        File file = File(result.files.single.path!);
        selectedFile.value = file;
        filePath.value = result.files.single.path!;
        int size = await file.length();
        fileSize.value = size.toString();
        log('File size::: ${fileSize.value} bytes');

        isApplyLeave==true?
        Get.find<ApplyLeaveController>().getUploadPolicy(
            fileName: Get.find<FileUploadController>()
                .storageForUpload
                .filePath
                .value):
        Get.find<UpDateLeaveController>().getUploadPolicy(
            fileName: Get.find<FileUploadController>()
                .storageForUpload
                .filePath
                .value);
      } else {
        showWarningMessage(message: AppString.text_please_valid_file);
        filePath.value = "";
      }
    }
  }

  toastMessage(bool status) {
    return status == false
        ? showSuccessMessage(
            message: AppString.text_file_upload_update_successfully)
        : showErrorMessage(message: AppString.text_file_upload_file);
  }
}

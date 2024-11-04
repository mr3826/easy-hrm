import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../common/widget/error_message.dart';
import '../../../../../common/widget/success_message.dart';
import '../../../../../common/widget/warning_message.dart';
import '../../../../../utils/app_string.dart';

import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../../common/widget/error_message.dart';
import '../../../../../common/widget/success_message.dart';
import '../../../../../common/widget/warning_message.dart';
import '../../../../../utils/app_string.dart';

class LeaveFileUploadController extends GetxController {
  final box = GetStorage();

  Rx<File?> file = Rx<File?>(null);
  RxString path = ''.obs;
  RxString sizeInBytes = '0'.obs;

  Future<void> selectFile({bool isLeaveApplication = false}) async {
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result != null) {
        final selectedPath = result.files.single.path!;
        _setFile(selectedPath);

        if (await _isFileSizeExceedingLimit(selectedPath)) {
          showWarningMessage(message: AppString.text_jpeg_format_not_support);
        } else if (_isSupportedExtension(selectedPath)) {
          await _setFile(selectedPath);
        } else {
          showWarningMessage(message: AppString.text_please_valid_file);
          path.value = "";
        }
      }
    } catch (e) {
      log("Error selecting file: $e");
      showErrorMessage(message: AppString.text_file_upload_file);
    }
  }

  Future<bool> _isFileSizeExceedingLimit(String filePath) async {
    final file = File(filePath);
    final fileSize = await file.length(); // in bytes
    return fileSize > 500 * 1024; // 500 KB
  }


  bool _isSupportedExtension(String filePath) {
    const supportedExtensions = [".png", ".jpg", ".jpeg", ".pdf"];
    return supportedExtensions.any(filePath.endsWith);
  }

  Future<void> _setFile(String filePath) async {
    file.value = File(filePath);
    path.value = filePath;
    sizeInBytes.value = (await file.value!.length()).toString();
  }

  void showStatusMessage(bool isError) {
    if (isError) {
      showErrorMessage(message: AppString.text_file_upload_file);
    } else {
      showSuccessMessage(message: AppString.text_file_upload_update_successfully);
    }
  }
}

import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../common/widget/error_message.dart';
import '../../../../common/widget/success_message.dart';
import '../../../../common/widget/warning_message.dart';
import '../../../../utils/app_string.dart';

class PickedFileFormStorage {
  final box = GetStorage();

  Rx<File?> selectedFile = Rx<File?>(null);
  RxString filePath = ''.obs;
  RxString fileSize = '0'.obs;
  final isLoading = false.obs;

  /// Picks a file from the storage.
  /// [controller] is the specific controller to handle the upload policy.
  Future<void> pickFile<T extends GetxController>({
    required T controller,
  }) async {
    print("called");
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        String pickedFilePath = result.files.single.path!;

        // Check if the file size is greater than 500 bytes.
        if (pickedFilePath.length > 500) {
          showWarningMessage(message: AppString.text_jpeg_format_not_support);
        }
        // Check for valid file extensions.
        else if (_isValidFileExtension(pickedFilePath)) {
          File file = File(pickedFilePath);
          selectedFile.value = file;
          filePath.value = pickedFilePath;

          int size = await file.length();
          fileSize.value = size.toString();

          // Call the common method for getting upload policy.
          (controller as dynamic).getUploadPolicy(fileName: filePath.value);
          print("HrLeaveController: $controller");
        } else {
          showWarningMessage(message: AppString.text_please_valid_file);
          filePath.value = "";
        }
      }
    } catch (e) {
      log("File picking error: $e");
      showErrorMessage(message: AppString.text_file_upload_file);
    }
  }

  /// Validates the file extension.
  bool _isValidFileExtension(String filePath) {
    final validExtensions = [".png", ".jpg", ".jpeg", ".pdf", ".JPG", ".PNG", ".JPEG", ".PDF"];
    return validExtensions.any((ext) => filePath.endsWith(ext));
  }

  /// Displays a toast message based on the [status].
  void toastMessage(bool status) {
    if (status) {
      showErrorMessage(message: AppString.text_file_upload_file);
    } else {
      showSuccessMessage(message: AppString.text_file_upload_update_successfully);
    }
  }
}

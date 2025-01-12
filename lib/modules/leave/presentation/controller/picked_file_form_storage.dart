import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/modules/leave/presentation/controller/update_leave_controller.dart';
import '../../../../app/modules/leave_hr/presentation/controller/hr_leave_controller.dart';
import '../../../../app/modules/leave_hr/presentation/controller/hr_update_leave_controller.dart';
import '../../../../common/widget/error_message.dart';
import '../../../../common/widget/success_message.dart';
import '../../../../common/widget/warning_message.dart';
import '../../../../utils/app_string.dart';
import 'apply_leave_controller.dart';

class PickedFileFormStorage {
  final box = GetStorage();

  Rx<File?> selectedFile = Rx<File?>(null);
  RxString filePath = ''.obs;
  RxString fileSize = '0'.obs;
  final isLoading = false.obs;

  /// Picks a file from the storage.
  /// If [isApplyLeave] is true, triggers the ApplyLeaveController,
  /// otherwise triggers the UpDateLeaveController to get the upload policy.
  Future<void> pickFile({bool isApplyLeave = false,bool isAssignLeave = false,bool isUpdateLeave=false}) async {
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

          // Trigger the appropriate controller based on isApplyLeave.
          if (isApplyLeave) {
            Get.find<ApplyLeaveController>().getUploadPolicy(fileName: filePath.value);
          }else if (isAssignLeave) {
            Get.find<HrLeaveController>().getUploadPolicy(fileName: filePath.value);
          }else if (isUpdateLeave) {

            Get.find<HrUpdateLeaveController>().getUploadPolicy(fileName: filePath.value);
          } else {
            Get.find<UpDateLeaveController>().getUploadPolicy(fileName: filePath.value);
          }
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
    print("filePath :: $filePath");
    final validExtensions = [".png", ".jpg", ".jpeg", ".pdf",".JPG",".PNG",".JPEG",".PDF"];
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

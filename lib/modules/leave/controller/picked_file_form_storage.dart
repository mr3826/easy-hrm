import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../common/widget/error_message.dart';
import '../../../../common/widget/success_message.dart';
import '../../../../common/widget/warning_message.dart';
import '../../../../utils/app_string.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'apply_leave_controller.dart';
import 'file_upload_controller.dart';

class PickedFileFormStorage {
  final box = GetStorage();

  Rx<File?> selectedFile = Rx<File?>(null);
  RxString filePath = ''.obs;
  RxString fileSize = ''.obs;
  final isLoading = false.obs;

  //picked file form storage here
  Future<void> pickFile() async {
 //   PermissionStatus permissionStatus;

    // //device sdk version check here
    // if (Platform.isAndroid) {
    //   final androidInfo = await DeviceInfoPlugin().androidInfo;
    //   if (androidInfo.version.sdkInt > 32) {
    //     permissionStatus = await Permission.photos.request();
    //   } else {
    //     permissionStatus = await Permission.storage.request();
    //   }
    // } else if (Platform.isIOS) {
    //   permissionStatus = await Permission.photos.request();
    // } else {
    //   permissionStatus = await Permission.storage.request();
    // }

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
        print('File size: ${fileSize.value} bytes');

        Get.find<ApplyLeaveController>().getUploadPolicy(
            fileName: Get.find<FileUploadController>()
                .storageForUpload
                .filePath
                .value);
      } else {
        showWarningMessage(message: AppString.text_please_valid_file);
        filePath.value = "";
      }
    }

    // // permission check for device form storage
    // if (permissionStatus.isGranted) {
    //   if (result != null) {
    //     if (result.files.single.path!.length > 500.toInt()) {
    //       showWarningMessage(message: AppString.text_jpeg_format_not_support);
    //     } else if (result.files.single.path!.endsWith(".png") ||
    //         result.files.single.path!.endsWith(".jpg") ||
    //         result.files.single.path!.endsWith(".jpeg") ||
    //         result.files.single.path!.endsWith(".pdf")) {
    //       File file = File(result.files.single.path!);
    //       selectedFile.value = file;
    //       filePath.value = result.files.single.path!;
    //       int size = await file.length();
    //       fileSize.value = size.toString();
    //       print('File size: ${fileSize.value} bytes');
    //
    //       Get.find<ApplyLeaveController>().getUploadPolicy(
    //           fileName: Get.find<FileUploadController>()
    //               .storageForUpload
    //               .filePath
    //               .value);
    //     } else {
    //       showWarningMessage(message: AppString.text_please_valid_file);
    //       filePath.value = "";
    //     }
    //   }
    // } else if (permissionStatus.isPermanentlyDenied) {
    //   openAppSettings();
    // } else {
    //   showWarningMessage(message: AppString.text_storage_permission);
    // }
  }

  toastMessage(bool status) {
    return status == false
        ? showSuccessMessage(
            message: AppString.text_file_upload_update_successfully)
        : showErrorMessage(message: AppString.text_file_upload_file);
  }
}

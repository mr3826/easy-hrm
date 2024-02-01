import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:payrun_mobile/modules/profile/controller/update_profile_controller.dart';
import '../../../../common/widget/error_message.dart';
import '../../../../common/widget/success_message.dart';
import '../../../../common/widget/warning_message.dart';
import '../../../../utils/app_string.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PikedProfileImgController extends GetxController {
  //picked document path here
  PickedProfileFormStorage storageForUpload = PickedProfileFormStorage();
}

class PickedProfileFormStorage {
  Rx<File?> selectedFile = Rx<File?>(null);
  RxString filePath = ''.obs;
  final isLoading = false.obs;
  RxString fileSize = ''.obs;

  //picked file form storage here
  Future<void> pickFile() async {
    PermissionStatus permissionStatus;
    //device sdk version check here
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt > 32) {
        permissionStatus = await Permission.photos.request();
      } else {
        permissionStatus = await Permission.storage.request();
      }
    } else if (Platform.isIOS) {
      permissionStatus = await Permission.photos.request();
    } else {
      permissionStatus = await Permission.storage.request();
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    // permission check for device form storage
    if (permissionStatus.isGranted) {
      if (result != null) {
        if (result.files.single.path!.length > 500.toInt()) {
          showWarningMessage(message: AppString.text_jpeg_format_not_support);
        } else if (result.files.single.path!.endsWith(".png") ||
            result.files.single.path!.endsWith(".jpg") ||
            result.files.single.path!.endsWith(".jpeg")) {
          File file = File(result.files.single.path!);
          selectedFile.value = file;
          filePath.value = result.files.single.path!;
          int size = await file.length();
          fileSize.value = size.toString();
          Get.find<UpdateProfileController>()
              .getUploadPolicy(fileName: filePath.value.toString());
        } else {
          showWarningMessage(message: AppString.text_please_valid_photo.tr);
        }
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    } else {
      showWarningMessage(message: AppString.text_storage_permission);
    }
  }

  toastMessage(bool status) {
    return status == false
        ? showSuccessMessage(
            message: AppString.text_file_upload_update_successfully)
        : showErrorMessage(message: AppString.text_file_upload_file);
  }
}

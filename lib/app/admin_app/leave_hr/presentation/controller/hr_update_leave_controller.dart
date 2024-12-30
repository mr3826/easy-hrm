import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/network/exception_helper.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../common/domain/upload_policy.dart';
import '../../../../../modules/leave/presentation/controller/file_upload_controller.dart';
import '../../../../../network/network_client.dart';
import '../../../../../utils/api_endpoints.dart';
import '../../../../../utils/utils.dart';
import 'hr_leave_controller.dart';

class HrUpdateLeaveController extends GetxController with StateMixin {
  RxBool isUpdateLeaveLoading = false.obs;
  RxBool isErrorOccurred = false.obs;
  final isUploadPolicyLoading = false.obs;
  RxBool isFileUploadedSuccessfully = false.obs;
  UploadPolicyResponse uploadPolicyResponse = UploadPolicyResponse();

  var isSelectLeaveType = ''.obs;
  var noteValue = ''.obs;
  var isSelectDate = ''.obs;

  // Method to check if the button should be enabled
  bool get isButtonEnabledForUpdateLeave {
    return isSelectLeaveType.isNotEmpty ||
        noteValue.isNotEmpty ||
        Get.find<FileUploadController>().storageForUpload.filePath.isNotEmpty ||
        isSelectDate.isNotEmpty;
  }

  void updateLeave(
      {required String leaveId,
      required String startDate,
      required String endDate,
      required String key,
      required String size,
      required String name,
      required String id,
      required String? leaveTypeId}) async {
    isUpdateLeaveLoading(true);
    final response = await NetworkClient()
        .graphRequest(queryString: cancelLeaveQuery, variables: {
      "inputData": {
        "leave_id": leaveId,
        "description": leaveNoteController.text,
        "end_date": DateTime.parse(endDate).toUtc().toString(),
        "start_date": DateTime.parse(startDate).toUtc().toString(),
        "leave_type_id": leaveTypeId,
        "files": _getFileInfo(
            id: id,
            key: key,
            size: size,
            name: name,
            filePath: Get.find<FileUploadController>()
                .storageForUpload
                .filePath
                .value,
            uploadPolicyResponse: uploadPolicyResponse)
      }
    });
    if (response.hasException) {
      ExceptionHelper.errorHandler(
          exception: response.exception!, methodName: "updateLeave");
    } else {
      isUpdateLeaveLoading(false);
      showSuccessMessage(message: AppString.leaveUpdatedSuccessMessage.tr);
      isFileUploadedSuccessfully(false);

      hrUpdateLeave();
    }
    isUpdateLeaveLoading(false);
  }

  getUploadPolicy({fileName}) async {
    isUploadPolicyLoading(true);
    final response = await NetworkClient()
        .graphRequest(queryString: getUploadPolicyQuery, variables: {
      "queryData": {
        "sub_folder_name": GetStorage().read(AppString.ORGANIZATION_ID),
        "filename":
            "${DateTime.now().millisecondsSinceEpoch.toString()}.${fileName.split('.').last}",
        "directive": "Files"
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(
          exception: response.exception!, methodName: "getUploadPolicy");
    } else {
      uploadPolicyResponse = UploadPolicyResponse.fromJson(response.data!);
      uploadFile(
          url: uploadPolicyResponse.getUploadPolicy?.url ?? "",
          fileName: fileName,
          list: uploadPolicyResponse.getUploadPolicy?.policyData);
    }
    isUploadPolicyLoading(false);
  }

  uploadFile(
      {required String fileName,
      List<PolicyData>? list,
      required String url}) async {
    if (list == null || url.isEmpty) return;
    isUploadPolicyLoading(true);

    FormData formData = FormData({});
    for (var data in list) {
      formData.fields.add(MapEntry(data.name!, data.value!));
    }

    formData.files.add(MapEntry(
        "file",
        MultipartFile(File(fileName),
            filename:
                "${DateTime.now().millisecondsSinceEpoch.toString()}.${fileName.split('.').last}")));

    await NetworkClient().post(url, formData).then((value) {
      isFileUploadedSuccessfully.value = true;
    }, onError: (_) => isFileUploadedSuccessfully.value = false);
    isUploadPolicyLoading(false);
  }

  _getFileInfo(
      {required String key,
      required String filePath,
      required UploadPolicyResponse uploadPolicyResponse,
      required String size,
      required String name,
      required String id}) {
    return (key != "null" && key.isNotEmpty || filePath.isNotEmpty)
        ? {
            "addData": filePath.isNotEmpty
                ? [
                    {
                      "size": int.parse(Get.find<FileUploadController>()
                          .storageForUpload
                          .fileSize
                          .value
                          .toString()),
                      "name": Get.find<FileUploadController>()
                          .storageForUpload
                          .filePath
                          .value
                          .split(".")
                          .last
                          .toString(),
                      "key": uploadPolicyResponse.getUploadPolicy?.policyData
                              ?.firstWhere((e) => e.name == 'key'.toLowerCase())
                              .value
                              ?.split("/")
                              .last ??
                          ""
                    }
                  ]
                : [
                    {"name": name, "key": key, "size": int.parse(size)}
                  ],
            "removeData": id.isNotEmpty && id != "null" ? id : null
          }
        : null;
  }
}

hrUpdateLeave() {
  HrLeaveController controller = Get.find<HrLeaveController>();
  final fileUploadController = Get.find<FileUploadController>();
  controller.getHrLeaveCalender();
  controller.getLeaveRecord();
  Get.back(canPop: false);
  Get.back();
  leaveNoteController.clear();
  fileUploadController.storageForUpload.fileSize.value = "";
  fileUploadController.storageForUpload.filePath.value = "";
}

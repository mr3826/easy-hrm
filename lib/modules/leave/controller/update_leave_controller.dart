import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/network/exception_helper.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../common/domain/upload_policy.dart';
import '../../../network/network_client.dart';
import '../../../utils/api_endpoints.dart';
import '../../../utils/utils.dart';
import '../model/leave_type.dart';
import 'file_upload_controller.dart';
import 'leave_screen_controller.dart';

class UpDateLeaveController extends GetxController with StateMixin {
  @override
  void onInit() async {
    await getLeaveTypeDropdown();
    super.onInit();
  }

  String leaveId = '';
  String leaveTypeId = '';
  RxBool isNoteRequired = false.obs;
  RxBool isDocumentRequired = false.obs;
  RxString numberOfLeaves = ''.obs;
  RxString calculateAllowanceOfLeave = ''.obs;

  RxBool isUpdateLeaveLoading = false.obs;
  RxBool isErrorOccurred = false.obs;
  final isUploadPolicyLoading = false.obs;
  RxBool isFileUploadedSuccessfully = false.obs;
  UploadPolicyResponse uploadPolicyResponse = UploadPolicyResponse();
  LeaveTypeDropdown? leaveTypeDropdown;

  var isSelectLeaveType = ''.obs;
  var noteValue = ''.obs;
  var isSelectDate = ''.obs;


  // Method to check if the button should be enabled
  bool get isButtonEnabledForUpdateLeave {
    return isSelectLeaveType.isNotEmpty || noteValue.isNotEmpty || Get.find<FileUploadController>()
        .storageForUpload
        .filePath.isNotEmpty || isSelectDate.isNotEmpty;
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
        .getGraphQuery(queryString: cancelLeaveQuery, variables: {
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
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      leaveId = '';
      isNoteRequired.value = false;
      isDocumentRequired.value = false;
      numberOfLeaves.value = '';
      leaveTypeId = '';
      leaveNoteController.clear();
      Get.find<FileUploadController>().storageForUpload.filePath.value = "";
      Get.find<FileUploadController>().storageForUpload.filePath.isEmpty;
      isUpdateLeaveLoading(false);
      showSuccessMessage(message: AppString.leaveUpdatedSuccessMessage.tr);
      isFileUploadedSuccessfully(false);
      Get.back(canPop: false);
      Get.back(canPop: false);
      updateData();
    }
    isUpdateLeaveLoading(false);
  }

  getUploadPolicy({fileName}) async {
    isUploadPolicyLoading(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: getUploadPolicyQuery, variables: {
      "queryData": {
        "sub_folder_name": GetStorage().read(AppString.ORGANIZATION_ID),
        "filename":
            "${DateTime.now().millisecondsSinceEpoch.toString()}.${fileName.split('.').last}",
        "directive": "Files"
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
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

  getLeaveTypeDropdown() async {
    change(null, status: RxStatus.loading());

    final response = await NetworkClient()
        .getGraphQuery(queryString: leaveTypeDropdownUpdateQuery, variables: {
      "queryData": {
        "org_user_id": GetStorage().read(AppString.ORGANIZATION_USER_ID),
        "leave_type_id": null
      }
    });
    print("getLeaveTypeDropdown :::: ${response.data}");
    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      leaveTypeDropdown = LeaveTypeDropdown.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }
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

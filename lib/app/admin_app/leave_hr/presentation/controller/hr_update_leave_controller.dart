import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/network/exception_helper.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../../common/controller/file_piker_controller.dart';
import '../../../../../common/domain/upload_policy.dart';
import '../../../../../network/network_client.dart';
import '../../../../../utils/api_endpoints.dart';
import '../../../../../utils/utils.dart';
import '../../data/apply_and_update_leave_date_source.dart';
import 'hr_leave_controller.dart';
import 'leave_controller.dart';

class HrUpdateLeaveController extends GetxController with StateMixin {
  final ApplyAndUpdateLeaveDateSource _updateLeaveDateSource = Get.find();

  RxBool isUpdateLeaveLoading = false.obs;
  RxBool isErrorOccurred = false.obs;
  final isUploadPolicyLoading = false.obs;
  RxBool isFileUploadedSuccessfully = false.obs;
  UploadPolicyResponse uploadPolicyResponse = UploadPolicyResponse();
  PickedFileFormStorage storageForUpload = PickedFileFormStorage();

  var isSelectLeaveType = ''.obs;
  var noteValue = ''.obs;
  var isSelectDate = ''.obs;

  Future<void> updateAssignLeave(
      {required String leaveId,
      required String startDate,
      required String endDate,
      required String key,
      required String size,
      required String name,
      required String id,
      required String? leaveTypeId}) async {
    isUpdateLeaveLoading(true);

    // Preparing the input data for the GraphQL mutation
    final Map<String, dynamic> inputData = {
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
            filePath: storageForUpload.filePath.value,
            uploadPolicyResponse: uploadPolicyResponse)
      }
    };

    // Sending the GraphQL request using NetworkClient
    final bool response =
        await _updateLeaveDateSource.updateAssignLeave(inputData);

    // Handling the response
    if (response) {
      isUpdateLeaveLoading(false);
      showSuccessMessage(message: AppString.leaveUpdatedSuccessMessage.tr);
      isFileUploadedSuccessfully(false);
      hrUpdateLeave(storageForUpload);
      isFileUploadedSuccessfully(false);
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
                      "size":
                          int.parse(storageForUpload.fileSize.value.toString()),
                      "name": storageForUpload.filePath.value
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

hrUpdateLeave(PickedFileFormStorage storageForUpload) {
  HrLeaveController controller = Get.find<HrLeaveController>();
  LeaveController leaveController = Get.find<LeaveController>();
  final now = DateTime.now();

  if (Get.find<LeaveController>().tabLength.value == 0) {
    controller.getHrLeaveCalender(
        startDate: leaveController.startDate.toString(),
        endDate: leaveController.endDate.toString());
  } else {
    final startDate = controller.selectedRangeStartDate.isEmpty
        ? DateTime(now.year, now.month, 1).toIso8601String()
        : controller.selectedRangeStartDate;

    final endDate = controller.selectedRangeEndDate.isEmpty
        ? DateTime(now.year, now.month + 1, 0).toIso8601String()
        : controller.selectedRangeEndDate;
    controller.getLeaveRecord(startDate: startDate, endDate: endDate);
  }

  Get.back(canPop: false);
  Get.back();
  leaveNoteController.clear();
  storageForUpload.fileSize.value = "";
  storageForUpload.filePath.value = "";
}

import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/domain/upload_policy.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/modules/leave/data/remote/leave_remote_data_source.dart';
import 'package:payrun_mobile/modules/leave/presentation/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../../network/exception_helper.dart';
import '../../../../network/network_client.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../utils/utils.dart';
import '../../domain/leave_type.dart';
import 'file_upload_controller.dart';

class ApplyLeaveController extends GetxController with StateMixin {
  // @override
  // void onInit() async {
  //   super.onInit();
  //   await getLeaveTypeDropdown();
  // }

  final LeaveRemoteDataSource _leaveRemoteDataSource =
      Get.find<LeaveRemoteDataSource>();

  LeaveTypeDropdown? leaveTypeDropdown;

  final isLoading = false.obs;
  final isAssignLeaveLoaderLoading = false.obs;
  String leaveId = '';
  RxBool isNoteRequired = false.obs;
  RxBool isDocumentRequired = false.obs;
  RxString numberOfLeaves = ''.obs;
  RxString calculateAllowanceOfLeave = ''.obs;
  RxBool isErrorOccurred = false.obs;
  final isUploadPolicyLoading = false.obs;
  RxBool isFileUploadedSuccessfully = false.obs;
  UploadPolicyResponse uploadPolicyResponse = UploadPolicyResponse();

  ///For Apply leave button enable
  var isSelectLeaveType = ''.obs;

  // Method to check if the button should be enabled
  bool get isButtonEnabledForApplyLeave {
    return isSelectLeaveType.isNotEmpty;
  }

  getLeaveTypeDropdown() async {
    change(null, status: RxStatus.loading());
    leaveTypeDropdown = await _leaveRemoteDataSource.getLeaveTypeDropdown();
    change(null, status: RxStatus.success());
  }

  Future<void> applyLeave({String? filePath}) async {
    isAssignLeaveLoaderLoading(true);

    // Preparing the input data for the GraphQL mutation
    final Map<String, dynamic> inputData = {
      "description": leaveNoteController.text,
      "end_date":
          DateTime.parse(Get.find<DateTimePickerController>().outDateTime.value)
              .toUtc()
              .toString(),
      "start_date":
          DateTime.parse(Get.find<DateTimePickerController>().inDateTime.value)
              .toUtc()
              .toString(),
      "status": "pending",
      "leave_type_id": leaveId,
      "files": _prepareFileData()
    };

    // Sending the GraphQL request using NetworkClient
    final bool response = await _leaveRemoteDataSource.applyLeave(inputData);

    // Handling the response
    if (response) {
      _resetLeaveForm();
      showSuccessMessage(message: AppString.leaveAddedSuccessMessage.tr);
      updateData();
      Get.back(canPop: false);
    }

    isAssignLeaveLoaderLoading(false);
  }

  /// Prepares the file data for the leave request.
  List<Map<String, dynamic>>? _prepareFileData() {
    final fileUploadController = Get.find<FileUploadController>();
    if (fileUploadController.storageForUpload.filePath.isEmpty) {
      return null;
    }

    String fileKey = uploadPolicyResponse.getUploadPolicy?.policyData
            ?.firstWhere((PolicyData e) => e.name?.toLowerCase() == 'key',
                orElse: () => PolicyData())
            .value
            ?.split("/")
            .last ??
        "";

    return [
      {
        "size": int.parse(
            fileUploadController.storageForUpload.fileSize.value.toString()),
        "name": fileUploadController.storageForUpload.filePath.value
            .split(".")
            .last,
        "key": fileKey,
      }
    ];
  }

  /// Resets the leave form after a successful leave application.
  void _resetLeaveForm() {
    leaveId = '';
    isNoteRequired.value = false;
    isDocumentRequired.value = false;
    numberOfLeaves.value = '';
    isErrorOccurred.value = false;

    final fileUploadController = Get.find<FileUploadController>();
    fileUploadController.storageForUpload.fileSize.value = "";
    fileUploadController.storageForUpload.filePath.value = "";

    leaveNoteController.clear();
    isFileUploadedSuccessfully(false);
  }


  getUploadPolicy({fileName}) async {
    isUploadPolicyLoading(true);
    final response = await NetworkClient().graphRequest(queryString: getUploadPolicyQuery, variables: {
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
      print(value.statusCode);
      isFileUploadedSuccessfully.value = true;
    }, onError: (_) => isFileUploadedSuccessfully.value = false);
    isUploadPolicyLoading(false);
  }

  // getUploadPolicy({required String fileName}) async {
  //   try {
  //     isUploadPolicyLoading(true);
  //
  //     // Construct the filename with a timestamp to avoid conflicts
  //     String formattedFileName =
  //         "${DateTime.now().millisecondsSinceEpoch}.${fileName.split('.').last}";
  //
  //     // Fetch the organization ID from storage
  //     String? organizationId = GetStorage().read(AppString.ORGANIZATION_ID);
  //
  //     Map<String, dynamic> inputData = {
  //       "sub_folder_name": organizationId,
  //       "filename": formattedFileName,
  //       "directive": "Files"
  //     };
  //
  //     // Make the GraphQL request to get the upload policy
  //     isFileUploadedSuccessfully.value =
  //         await _leaveRemoteDataSource.getUploadPolicy(inputData, fileName);
  //   } finally {
  //     isUploadPolicyLoading(false);
  //   }
  // }
}

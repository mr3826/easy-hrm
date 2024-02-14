import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/domain/upload_policy.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/modules/home/view/screen/main_screen.dart';
import 'package:payrun_mobile/modules/leave/model/leave_type.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';
import '../../../network/exception_helper.dart';
import '../../../utils/utils.dart';
import '../../dashboard/controller/dashbpard_controller.dart';
import '../model/workshief_response_by_date.dart';
import 'file_upload_controller.dart';
import 'leave_screen_controller.dart';

class ApplyLeaveController extends GetxController with StateMixin {
  @override
  void onInit() async {
    super.onInit();
    await getLeaveType();
    await getWorkShift();
  }

  LeaveTypeDropdown? leaveTypeDropdown;

  final isLoading = false.obs;
  final isAssignLeaveLoaderLoading = false.obs;
  String? startTime;
  String? endTime;
  String leaveId = '';
  RxBool isNoteRequired = false.obs;
  RxBool isDocumentRequired = false.obs;
  RxString numberOfLeaves = ''.obs;
  RxBool isErrorOccurred = false.obs;
  final isUploadPolicyLoading = false.obs;
  RxBool isFileUploadedSuccessfully = false.obs;
  UploadPolicyResponse uploadPolicyResponse = UploadPolicyResponse();

  getLeaveType() async {
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: leaveTypeDropdownQuery);

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      leaveTypeDropdown = LeaveTypeDropdown.fromJson(response.data!);
    }
    change(null, status: RxStatus.success());
  }

  getWorkShift() async {
    print(
        "GetStorage().read(AppString.ORGANIZATION_USER_ID)::: ${GetStorage().read(AppString.ORGANIZATION_USER_ID)}");
    change(null, status: RxStatus.loading());
    final response = await NetworkClient()
        .getGraphQuery(queryString: workShiftQuery, variables: {
      "queryData": {
        "employee_id": GetStorage().read(AppString.ORGANIZATION_USER_ID),
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      WorkShiftResponse workShiftResponse =
          WorkShiftResponse.fromJson(response.data!);
      GetWorkScheduleForAssignLeave? value = workShiftResponse
          .getWorkScheduleForAssignLeave
          ?.firstWhere((element) => element.isHoliday == false);

      print(value?.startTime);
      startTime = value?.startTime;
      endTime = value?.endTime;

      print("workShiftTime?.startTime:: $startTime");
    }
    change(null, status: RxStatus.success());
  }

  applyLeave({filePath}) async {
    print("applyLeave filePath:: ${uploadPolicyResponse.getUploadPolicy?.policyData?.firstWhere((e) => e.name == 'key'.toLowerCase()).value?.split("/").last}");


    print("size :::: ${Get.find<FileUploadController>()
        .storageForUpload
        .fileSize
        .value
        .toString()}");
    isAssignLeaveLoaderLoading(true);

    final response = await NetworkClient().mutationGraphData(assignLeaveQuery, {
      "inputData": {
        "description": leaveNoteController.text,
        "end_date": DateTime.parse(
                Get.find<DateTimePickerController>().outDateTime.value)
            .toUtc()
            .toString(),
        "start_date": DateTime.parse(
                Get.find<DateTimePickerController>().inDateTime.value)
            .toUtc()
            .toString(),
        "status": "pending",
        "leave_type_id": leaveId,
        "files":
            Get.find<FileUploadController>().storageForUpload.filePath.isEmpty
                ? null
                : [
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
                  ],
      }
    });

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      leaveId = '';
      isNoteRequired.value = false;
      isDocumentRequired.value = false;
      numberOfLeaves.value = '';
      isErrorOccurred.value = false;
      Get.find<FileUploadController>().storageForUpload.fileSize.value = "";
      Get.find<FileUploadController>().storageForUpload.filePath.value = "";
      Get.find<FileUploadController>().storageForUpload.filePath.isEmpty;
      leaveNoteController.clear();
      isAssignLeaveLoaderLoading(false);
      showSuccessMessage(message: AppString.leaveAddedSuccessMessage);
      isFileUploadedSuccessfully(false);
      Get.offAll(() => const MainScreen(routeIndex: 1));
    }

    isAssignLeaveLoaderLoading(false);
  }

  getUploadPolicy({fileName}) async {
    print(
        "${DateTime.now().millisecondsSinceEpoch.toString()}.${fileName.split('.').last}");
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
      print(value.statusCode);
      isFileUploadedSuccessfully.value = true;
    }, onError: (_) => isFileUploadedSuccessfully.value = false);
    isUploadPolicyLoading(false);
  }
}

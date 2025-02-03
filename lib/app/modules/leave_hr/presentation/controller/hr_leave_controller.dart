import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../view/widget/calendar/vertical_calendar/calendar_task_card_widget.dart';
import 'package:payrun_mobile/enum.dart';
import '../../../../../common/controller/file_piker_controller.dart';
import '../../../../../common/domain/upload_policy.dart';
import '../../../../../common/widget/success_message.dart';
import '../../../../../common/widget/timePicker/date_time_picker_controller.dart';
import '../../../../../modules/leave/data/remote/leave_remote_data_source.dart';
import '../../../../../network/exception_helper.dart';
import '../../../../../network/network_client.dart';
import '../../../../../utils/api_endpoints.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/utils.dart';
import '../../data/leave_remote_data_source.dart';
import '../model/avaible_leave_type.dart';
import '../model/download_file.dart';
import '../model/hr_leave_calender.dart';
import '../model/hr_leave_record.dart';
import '../model/leave_details_by_id.dart';
import 'hr_update_leave_controller.dart';
import 'leave_controller.dart';

class HrLeaveController extends GetxController {
  final HrLeaveRemoteDataSource _hrLeaveRemoteDataSource = Get.find();
  final LeaveRemoteDataSource _leaveRemoteDataSource = Get.find();
  HrLeaveCalender? hrLeaveCalender = HrLeaveCalender();
  LeaveDetailsById? leaveDetailsById = LeaveDetailsById();
  DownloadFile? downloadFile = DownloadFile();
  HrLeaveRecorde? leaveRecorde = HrLeaveRecorde();
  AvailableLeaveType? availableLeaveType = AvailableLeaveType();
  RxBool isHrLeaveCalendarLoading = false.obs;
  RxBool isHrLeaveDetailsByLoading = false.obs;
  RxBool isDownloadLoading = false.obs;
  RxBool updateLeaveLoader = false.obs;
  RxBool isLoadingLeaveRecord = false.obs;
  RxBool isAvailableLeaveType = false.obs;
  final isAssignLeaveLoaderLoading = false.obs;
  final isUploadPolicyLoading = false.obs;
  RxBool isFileUploadedSuccessfully = false.obs;
  RxBool isUpdateLeaveChangeValue = false.obs;

  RxString selectedEmployeeInfo = AppString.textSearchEmployee.tr.obs;
  RxString selectedEmployeeImgKey = "".obs;

  String selectedRangeStartDate = "";
  String selectedRangeEndDate = "";

  String selectedEmployeeId = "";
  RxString calculateAllowanceOfLeave = ''.obs;
  String? leaveTypeId;
  String? leaveId;
  String? fileName;
  String? fileKey;
  String? fileId;
  String? fileSize;

  UploadPolicyResponse uploadPolicyResponse = UploadPolicyResponse();
  PickedFileFormStorage storageForUpload = PickedFileFormStorage();

  /// Fetches employee leave data and updates the [hrLeaveCalender] object.
  Future<void> getHrLeaveCalender(
      {String? startDate, String? endDate, String? assignedId}) async {
    String getDefaultStartDate() {
      final now = DateTime.now();
      return "${DateTime(now.year, now.month, 1).toIso8601String().split('T')[0]}T00:00:00.000Z";
    }

    String getDefaultEndDate() {
      final now = DateTime.now();
      return "${DateTime(now.year, now.month + 1, 0).toIso8601String().split('T')[0]}T23:59:59.999Z";
    }

    Map<String, Map<String, Object>> queryMap = {"queryData": {}};

    queryMap["queryData"]?["startDate"] = startDate ?? getDefaultStartDate();

    queryMap["queryData"]?["endDate"] = endDate ?? getDefaultEndDate();

    if (assignedId != null) {
      queryMap["queryData"]?["assigned_to"] = assignedId;
    }
    isHrLeaveCalendarLoading(true);
    hrLeaveCalender =
    await _hrLeaveRemoteDataSource.getLeaveCalender(queryMap: queryMap);
    isHrLeaveCalendarLoading(false);
  }

  /// Constructs and returns a map of tasks grouped by date.
  /// Each task corresponds to a leave request.
  Map<String, List<Task>> getTaskDataFromLeaves() {
    final leaveRequests =
        hrLeaveCalender?.getLeavesCalendar?.leaveRequests ?? [];
    final taskData = <String, List<Task>>{};
    for (var leave in leaveRequests) {
      final date = leave.formattedDate ?? "Unknown Date";
      taskData.putIfAbsent(date, () => []).add(_createTask(leave));
    }

    return taskData;
  }

  /// Creates a [Task] object from a [LeaveRequests] object.
  Task _createTask(LeaveRequests leave) {
    return Task(
      name: _getFirstUserName(leave),
      role: _getUserRole(leave),
      leaveType:
      "${leave.leaveTypeName}: ${leave.leaveTypeCategory}", // Replace with actual leave type if needed.
      status: _getStatus(leave), // Customize based on leave request status.
      approvedCount: leave.totalApproved ?? 0,
      pendingCount: leave.totalPending ?? 0,
      rejectedCount: leave.totalRejected ?? 0,
      takenCount: leave.totalTaken ?? 0,
      cancelledCount: leave.totalCancelled ?? 0,
      imageUrls: _getUserImages(leave),
      isGroup: (leave.organizationUsers?.length ?? 0) > 1,
      designation: _getUserDesignation(leave),
      leaveId: _getLeaveId(leave),
      formattedLeaveHours: leave.formattedLeaveHours,
      startDate: leave.formattedDate,
    );
  }

  String _getLeaveId(LeaveRequests leave) {
    var data =
        leave.organizationUsers?.firstWhere((v) => v.leaveId != null).leaveId ??
            "";
    leave.organizationUsers?.forEach((v) {});
    return data;
  }

  String _getStatus(LeaveRequests leave) {
    if (leave.totalPending == 1) {
      return LeaveStatus.pending.name;
    } else if (leave.totalApproved == 1) {
      return LeaveStatus.approved.name;
    } else if (leave.totalRejected == 1) {
      return LeaveStatus.rejected.name;
    } else if (leave.totalTaken == 1) {
      return LeaveStatus.taken.name;
    } else if (leave.totalCancelled == 1) {
      return LeaveStatus.cancelled.name;
    } else {
      return LeaveStatus.pending.name;
    }
  }

  /// Returns the first user's full name in the leave request.
  String _getFirstUserName(LeaveRequests leave) {
    final profile = leave.organizationUsers?.first.profile;
    return "${profile?.firstName ?? 'Unknown'} ${profile?.lastName ?? ''}"
        .trim();
  }

  /// Returns the role name of the first user in the leave request.
  String _getUserRole(LeaveRequests leave) {
    return leave.organizationUsers?.first.roles?.first.name ?? "Unknown Role";
  }

  /// Returns the role name of the first user in the leave request.
  String _getUserDesignation(LeaveRequests leave) {
    return leave.organizationUsers?.first.designation ?? "No designation";
  }

  /// Returns a list of image URLs or user names if images are unavailable.
  List<String> _getUserImages(LeaveRequests leave) {
    return leave.organizationUsers?.map((user) {
      final imageUrl = user.profile?.image;
      if (imageUrl == null || imageUrl.isEmpty) {
        return "${user.profile?.firstName ?? 'Unknown'} ${user.profile?.lastName ?? ''}"
            .trim();
      }
      return imageUrl;
    }).toList() ??
        [];
  }

  /// update a leave and updates the relevant data if successful.
  Future<void> updateLeave({required String leaveId, String? status}) async {
    updateLeaveLoader(true);
    final bool response = await _hrLeaveRemoteDataSource.updateLeave(
        leaveId: leaveId, status: status ?? "cancelled");

    if (response) {
      showSuccessMessage(
          message: AppString.leaveUpdatedSuccessMessage
              .replaceAll("updated", status ?? "updated"));
      _updateLeaveData();
      Get.back(canPop: false);
    }
    updateLeaveLoader(false);
  }

  /// Fetches employee leave data and updates the [hrLeaveCalender] object.
  Future<void> getLeaveDetailsById({required String leaveId}) async {
    isHrLeaveDetailsByLoading(true);
    leaveDetailsById =
    await _hrLeaveRemoteDataSource.getLeaveDetailsById(leaveId);
    isHrLeaveDetailsByLoading(false);
  }

  /// Fetches employee leave document download .
  Future<void> getLeaveDocumentDownloadByUrl({String? imageKey}) async {
    isDownloadLoading(true);
    downloadFile = await _hrLeaveRemoteDataSource.getFileSignUrl(imageKey);
    isDownloadLoading(false);
  }

  /// Fetches employee leave record hr.
  Future<void> getLeaveRecord(
      {String? startDate, String? endDate, String? assignedLeaveId}) async {
    Map<String, Map<String, Object>> queryMap = {"queryData": {}};
    queryMap["queryData"]?["start_date"] = startDate ??
        "${DateTime(DateTime.now().year, DateTime.now().month, 1)}";

    queryMap["queryData"]?["end_date"] = endDate ??
        "${DateTime(DateTime.now().year, DateTime.now().month + 1, 0)}";

    if (assignedLeaveId != null) {
      queryMap["queryData"]?["assigned_to"] = assignedLeaveId;
    }

    isLoadingLeaveRecord(true);
    leaveRecorde = await _hrLeaveRemoteDataSource.getLeaveRecord(queryMap);

    isLoadingLeaveRecord(false);
  }

  /// Fetches leave type hr .
  Future<void> getAvailableLeaveType({String? orgUserId, String? year}) async {
    isAvailableLeaveType(true);
    availableLeaveType = await _hrLeaveRemoteDataSource.getAvailableLeaveType(orgUserId:
        orgUserId ?? GetStorage().read(AppString.ORGANIZATION_USER_ID),
        year: year ?? "${DateTime.now().year}");
    isAvailableLeaveType(false);
  }

  Future<void> applyLeave(
      {String? filePath, String? assignedId, String? status}) async {
    isAssignLeaveLoaderLoading(true);
    // Preparing the input data for the GraphQL mutation
    final Map<String, dynamic> inputData = {
      "description": leaveNoteController.text,
      "start_date":
      DateTime.parse(Get.find<DateTimePickerController>().inDateTime.value)
          .toUtc()
          .toString(),
      "end_date":
      DateTime.parse(Get.find<DateTimePickerController>().outDateTime.value)
          .toUtc()
          .toString(),
      "assigned_to": selectedEmployeeId.isEmpty
          ? "${GetStorage().read(AppString.ORGANIZATION_USER_ID)}"
          : selectedEmployeeId,
      "status": status ?? "pending",
      "leave_type_id": leaveTypeId,
      "files": _prepareFileData()
    };
    final bool response = await _leaveRemoteDataSource.applyLeave(inputData);

    // Handling the response
    if (response) {
      leaveTypeId = '';
      isFileUploadedSuccessfully(false);
      showSuccessMessage(message: AppString.leaveAddedSuccessMessage.tr);
      hrUpdateLeave(storageForUpload);
      isFileUploadedSuccessfully(false);
    }
    isAssignLeaveLoaderLoading(false);
  }

  /// Prepares the file data for the leave request.
  List<Map<String, dynamic>>? _prepareFileData() {
    if (storageForUpload.filePath.isEmpty) {
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
        "size": int.parse(storageForUpload.fileSize.value.toString()),
        "name": storageForUpload.filePath.value.split(".").last,
        "key": fileKey,
      }
    ];
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

  @override
  void onInit() {
    getHrLeaveCalender();
    getLeaveRecord();
    super.onInit();
  }
}

_updateLeaveData() {
  LeaveController leaveController = Get.find<LeaveController>();
  HrLeaveController controller = Get.find<HrLeaveController>();
  final now = DateTime.now();
  final startDate = controller.selectedRangeStartDate.isEmpty
      ? DateTime(now.year, now.month, 1).toIso8601String()
      : controller.selectedRangeStartDate;

  final endDate = controller.selectedRangeEndDate.isEmpty
      ? DateTime(now.year, now.month + 1, 0).toIso8601String()
      : controller.selectedRangeEndDate;
  controller.getLeaveRecord(startDate: startDate, endDate: endDate);

  controller.getHrLeaveCalender(
      startDate: leaveController.startDate.toString(),
      endDate: leaveController.endDate.toString());
}
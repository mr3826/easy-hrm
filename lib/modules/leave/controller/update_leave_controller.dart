import 'package:get/get.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/modules/dashboard/controller/dashbpard_controller.dart';
import 'package:payrun_mobile/modules/leave/controller/leave_screen_controller.dart';
import 'package:payrun_mobile/modules/leave/model/leave_record_response.dart';
import 'package:payrun_mobile/network/exception_helper.dart';
import 'package:payrun_mobile/utils/app_string.dart';

import '../../../network/network_client.dart';
import '../../../utils/api_endpoints.dart';
import '../../../utils/utils.dart';
import '../../home/view/screen/main_screen.dart';
import '../model/leave_type.dart';

class UpDateLeaveController extends GetxController with StateMixin {
  @override
  void onInit() async {
    await getLeaveType();
    super.onInit();
  }

  String leaveId = '';
  String leaveTypeId = '';
  RxBool isNoteRequired = false.obs;
  RxBool isDocumentRequired = false.obs;
  RxString numberOfLeaves = ''.obs;
  RxBool isUpdateLeaveLoading = false.obs;
  RxBool isErrorOccurred = false.obs;
  LeaveTypeDropdown? leaveTypeDropdown;
  Files files=Files();

  void updateLeave(
      {required String leaveId,
      required String startDate,
      required String endDate,
      required String? leaveTypeId}) async {
    print("""
    required String leaveId::$leaveId,
      required String startDate::$startDate,
      required String? endDate::$endDate
      leaveType id:: $leaveTypeId
    """);
    isUpdateLeaveLoading(true);
    final response = await NetworkClient()
        .getGraphQuery(queryString: cancelLeaveQuery, variables: {
      "inputData": {
        "leave_id": leaveId,
        "status": "pending",
        "description": leaveNoteController.text,
        "end_date": DateTime.parse(endDate).toUtc().toString(),
        "start_date": DateTime.parse(startDate).toUtc().toString(),
        "leave_type_id": leaveTypeId,
        "files": {
          "addData": [
            {
              "name": null,
              "key": null,
              "size": null
            }
          ],
          "removeData": "ui id"
        }

      }
    });

    // {
    //   "size": int.parse(Get.find<FileUploadController>()
    // .storageForUpload
    //     .fileSize
    //     .value
    //     .toString()),
    // "name": Get.find<FileUploadController>()
    //     .storageForUpload
    //     .filePath
    //     .value
    //     .split(".")
    //     .last
    //     .toString(),
    // "key": uploadPolicyResponse.getUploadPolicy?.policyData
    //     ?.firstWhere((e) => e.name == 'key'.toLowerCase())
    //     .value
    //     ?.split("/")
    //     .last ??
    // ""
    // }

    if (response.hasException) {
      ExceptionHelper.errorHandler(exception: response.exception!);
    } else {
      Get.off(() => const MainScreen(routeIndex: 1));
      leaveId = '';
      isNoteRequired.value = false;
      isDocumentRequired.value = false;
      numberOfLeaves.value = '';
      leaveTypeId = '';
      leaveNoteController.clear();
      showSuccessMessage(message: AppString.leaveUpdatedSuccessMessage.tr);
      await Get.find<LeaveScreenController>().getLeaveSummaryForDashboard();
      await Get.find<LeaveScreenController>().getLeaveDetailsByDate();
      await Get.find<DashboardController>()
          .getMonthlyTimelineInfoForDashboard();
    }

    isUpdateLeaveLoading(false);
  }

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
}

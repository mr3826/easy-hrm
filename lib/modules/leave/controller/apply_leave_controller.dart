import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payrun_mobile/common/controller/date_time_controller.dart';
import 'package:payrun_mobile/common/widget/success_message.dart';
import 'package:payrun_mobile/common/widget/timePicker/date_time_picker_controller.dart';
import 'package:payrun_mobile/modules/home/view/screen/main_screen.dart';
import 'package:payrun_mobile/modules/leave/model/apply_leave_response.dart';
import 'package:payrun_mobile/modules/leave/model/leave_type.dart';
import 'package:payrun_mobile/network/network_client.dart';
import 'package:payrun_mobile/utils/api_endpoints.dart';
import 'package:payrun_mobile/utils/app_string.dart';

import '../../../network/exception_helper.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';
import '../model/workshief_response_by_date.dart';

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

  applyLeave() async {
    isAssignLeaveLoaderLoading(true);

    print('''
            "end_date": ${Get.find<DateTimePickerController>().inDateTime.value},
        "start_date": ${Get.find<DateTimePickerController>().outDateTime.value},
    ''');
    final response = await NetworkClient().mutationGraphData(assignLeaveQuery, {
      "inputData": {
        "description": leaveNoteController.text,
        "end_date": Get.find<DateTimePickerController>().outDateTime.value,
        "start_date": Get.find<DateTimePickerController>().inDateTime.value,
        "status": "pending",
        "leave_type_id": leaveId
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
      showSuccessMessage(message: AppString.leaveAddedSuccessMessage);
      leaveNoteController.clear();
      Get.off(() => MainScreen(
            routeIndex: 1,
          ));
    }

    isAssignLeaveLoaderLoading(false);
  }
}
